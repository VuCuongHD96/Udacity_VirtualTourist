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
        
        input.loadTrigger
            .flatMap {
                useCase.fetchAlbumList()
                    .asDriver()
            }
            .map { 
                AlbumItemTranslator.createAlbumItemViewData(from: $0)
            }
            .assign(to: \.albumItemViewDataArray, on: output)
            .store(in: cancelBag)
        
        input.backAction
            .sink {
                navigator.goBack()
            }
            .store(in: cancelBag)
        
        return output
    }
}
