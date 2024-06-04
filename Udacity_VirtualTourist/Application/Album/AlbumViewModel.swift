//
//  AlbumViewModel.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Combine
import MapKit

struct AlbumViewModel {
    
    let useCase: AlbumUseCaseType
    let navigator: AlbumNavigatorType
    let pinEntity: PinEntity
    let reloadTimer = Timer.publish(every: 0.003, on: .main, in: .default)
        .autoconnect()
}

extension AlbumViewModel: ViewModel {
    
    enum EditMode {
        case editing
        case doneEdit
    }
    
    struct Input {
        var loadTrigger = Driver.just(Void())
        var backAction = PassthroughSubject<Void, Never>()
        var reloadAction = PassthroughSubject<Void, Never>()
        var editMode = PassthroughSubject<EditMode, Never>()
        var deleteAction = PassthroughSubject<AlbumItemViewData, Never>()
    }
    
    class Output: ObservableObject {
        @Published var albumItemViewDataArray = [AlbumItemViewData]()
        @Published var isEditing = false
        @Published var isLoading = false
        @Published var degrees: Double = 0
        @Published var alertMessage = AlertMessage()
        @Published var region: MKCoordinateRegion = .init()
        @Published var pinItem = PinItemViewData()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let activityTracker = ActivityTracker(false)
        let errorTracker = ErrorTracker()
        
        errorTracker.map {
            AlertMessage(error: $0)
        }
        .assign(to: \.alertMessage, on: output)
        .store(in: cancelBag)
        
        input.loadTrigger
            .map { _ in
                let coordinate = CLLocationCoordinate2D(latitude: pinEntity.latitude, longitude: pinEntity.longitude)
                let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                return MKCoordinateRegion(center: coordinate, span: coordinateSpan)
            }
            .assign(to: \.region, on: output)
            .store(in: cancelBag)
        
        Just(pinEntity)
            .map {
                PinItemViewDataTranslator.createPinItemViewData(pinEntity: $0)
            }
            .assign(to: \.pinItem, on: output)
            .store(in: cancelBag)
        
        input.loadTrigger
            .flatMap {
                useCase.fetchAlbumList(pinEntity: pinEntity)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver()
            }
            .map {
                AlbumItemViewDataTranslator.createAlbumItemViewData(from: $0)
            }
            .assign(to: \.albumItemViewDataArray, on: output)
            .store(in: cancelBag)
        
        let deleteAllPhotoOfPin = Just(Void())
            .flatMap { _ in
                useCase.fetchAlbumList(pinEntity: pinEntity)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver()
            }
            .flatMap { photoStorageItem in
                photoStorageItem.publisher
            }
            .map {
                useCase.delete(object: $0)
            }
        
        input.reloadAction
            .flatMap { 
                deleteAllPhotoOfPin
            }
            .flatMap { _ in
                useCase.fetchAlbumList(pinEntity: pinEntity)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver()
            }
            .filter {
                $0.isEmpty
            }
            .flatMap { _ in
                useCase.fetchPhotoServiceList(pinEntity: pinEntity)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver()
            }
            .map {
                AlbumItemViewDataTranslator.createAlbumItemViewData(from: $0)
            }
            .assign(to: \.albumItemViewDataArray, on: output)
            .store(in: cancelBag)
        
        input.editMode
            .map {
                $0 == .editing
            }
            .assign(to: \.isEditing, on: output)
            .store(in: cancelBag)
        
        let photoItemToDelete = input.deleteAction
            .flatMap {
                useCase.fetchPhotoStorageList(albumItemViewData: $0)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .flatMap {
                $0.publisher
            }

        photoItemToDelete
            .sink {
                useCase.delete(object: $0)
            }
            .store(in: cancelBag)
        
        photoItemToDelete
            .compactMap { photoStorageEntity in
                output.albumItemViewDataArray.firstIndex {
                    $0.photoID == photoStorageEntity.photoID
                }
            }
            .sink(receiveValue: {
                output.albumItemViewDataArray.remove(at: $0)
            })
            .store(in: cancelBag)
        
        input.backAction
            .flatMap {
                useCase.save()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .filter {
                $0 == true
            }
            .sink { _ in
                navigator.goBack()
            }
            .store(in: cancelBag)
        
        activityTracker
            .filter {
                $0 == true
            }
            .flatMap { _ in
                reloadTimer
            }
            .scan(0) { (accumulatedAngle, _) in
                return accumulatedAngle + 1
            }
            .assign(to: \.degrees, on: output)
            .store(in: cancelBag)
        
        activityTracker
            .filter {
                $0 == false
            }
            .sink { _ in
                reloadTimer.upstream.connect().cancel()
            }
            .store(in: cancelBag)
        
        let doneEdit = input.editMode
            .filter {
                $0 == .doneEdit
            }
            .mapToVoid()

        Publishers.Merge(input.backAction, doneEdit)
            .flatMap {
                useCase.save()
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .sink {
                print("--- debug --- lưu thành công = ", $0)
            }
            .store(in: cancelBag)
        
        return output
    }
}
