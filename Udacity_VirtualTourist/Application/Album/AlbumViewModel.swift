//
//  AlbumViewModel.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Combine

struct AlbumViewModel {
    
    let useCase: AlbumUseCaseType
    let navigator: AlbumNavigatorType
    let pinEntity: PinEntity
}

extension AlbumViewModel: ViewModel {
    
    enum EditMode {
        case editing
        case doneEdit
    }
    
    struct Input {
        var loadTrigger = Driver.just(Void())
        var backAction = PassthroughSubject<Void, Never>()
        var editMode = PassthroughSubject<EditMode, Never>()
        var deleteAction = PassthroughSubject<Void, Never>()
    }
    
    class Output: ObservableObject {
        @Published var albumItemViewDataArray = [AlbumItemViewData]()
        @Published var isEditing = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let activityTracker = ActivityTracker(false)
        let errorTracker = ErrorTracker()
        
        let albumItemViewDataArray = input.loadTrigger
            .flatMap {
                useCase.fetchAlbumList(pinEntity: pinEntity)
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
                    .asDriver()
            }
            .map {
                AlbumItemViewDataTranslator.createAlbumItemViewData(from: $0)
            }
            .share()
        
        albumItemViewDataArray
            .assign(to: \.albumItemViewDataArray, on: output)
            .store(in: cancelBag)
        
        albumItemViewDataArray
            .map {
                $0.isEmpty
            }
            .sink {
                pinEntity.isAlbumValid = !$0
            }
            .store(in: cancelBag)

        input.backAction
            .sink {
                navigator.goBack()
            }
            .store(in: cancelBag)
        
        input.editMode
            .map {
                $0 == EditMode.editing
            }
            .assign(to: \.isEditing, on: output)
            .store(in: cancelBag)
        
        input.deleteAction
            .sink {
                print("--- debug --- delete action")
            }
            .store(in: cancelBag)
        
        return output
    }
}
