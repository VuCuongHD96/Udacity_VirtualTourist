//
//  AlbumUseCase.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

protocol AlbumUseCaseType {
    func fetchAlbumList(pinItemViewData: PinItemViewData) -> Observable<[PhotoEntity]>
}

struct AlbumUseCase: AlbumUseCaseType {
    
    let albumRepository = AlbumRepository(api: .share)
    
    func fetchAlbumList(pinItemViewData: PinItemViewData) -> Observable<[PhotoEntity]> {
        return albumRepository.fetchAlbumList(pinItemViewData: pinItemViewData)
    }
}
