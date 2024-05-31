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
    
    struct Input {
        var loadTrigger = Driver.just(Void())
        var backAction = PassthroughSubject<Void, Never>()
    }
    
    class Output: ObservableObject {
        @Published var albumItemViewDataArray = [AlbumItemViewData]()
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
        
        return output
    }
}
