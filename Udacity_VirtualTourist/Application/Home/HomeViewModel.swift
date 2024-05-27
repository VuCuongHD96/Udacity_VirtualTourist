//
//  HomeViewModel.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 19/5/24.
//

import Foundation
import MapKit
import Combine
import CoreData

struct HomeViewModel {
    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType
}

extension HomeViewModel: ViewModel {
    
    class Input {
        var loadTrigger = Driver.just(Void())
        var pinAction = PassthroughSubject<CLLocationCoordinate2D, Never>()
        var annotationAction = PassthroughSubject<PinItemViewData, Never>()
    }
    
    class Output: ObservableObject {
        @Published var region: MKCoordinateRegion = .init()
        @Published var pinItemViewArray = [PinItemViewData]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let activityTracker = ActivityTracker(false)
        let errorTracker = ErrorTracker()
        
        input.loadTrigger
            .map { _ in
                let coordinate = CLLocationCoordinate2D(latitude: 21.043507, longitude: 105.836508)
                let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                return MKCoordinateRegion(center: coordinate, span: coordinateSpan)
            }
            .assign(to: \.region, on: output)
            .store(in: cancelBag)
        
        input.loadTrigger
            .flatMap { _ in
                return useCase.getPinList()
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver()
            }
            .map { pinEntityList in
                PinItemViewDataTranslator.createPinItemViewDataArray(pinEntityArray: pinEntityList)
            }
            .assign(to: \.pinItemViewArray, on: output)
            .store(in: cancelBag)
        
        let pinName = input.pinAction
            .flatMap {
                useCase.getAddressNameFrom(location: $0)
                    .trackError(errorTracker)
                    .trackActivity(activityTracker)
                    .asDriver()
            }
            .compactMap {
                $0.first?.name
            }
        
        Publishers.Zip(pinName, input.pinAction)
            .map { (pinName, locationCoordinate) in
                PinEntity(pinID: UUID().uuidString,
                          name: pinName,
                          latitude: locationCoordinate.latitude,
                          longitude: locationCoordinate.longitude)
            }
            .map {
                PinItemViewDataTranslator.createPinItemViewData(pinEntity: $0)
            }
            .sink { pinItemViewData in
                output.pinItemViewArray.append(pinItemViewData)
            }
            .store(in: cancelBag)
        
        input.annotationAction
            .sink { pinItemViewData in
                navigator.toAlbum(pinItemViewData: pinItemViewData)
            }
            .store(in: cancelBag)
        
        return output
    }
}
