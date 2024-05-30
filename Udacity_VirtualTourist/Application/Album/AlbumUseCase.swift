//
//  AlbumUseCase.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

protocol AlbumUseCaseType {
    func fetchAlbumList(pinEntity: PinEntity) -> Observable<[PhotoEntity]>
}

struct AlbumUseCase: AlbumUseCaseType {
    
    let albumRepository = AlbumRepository(api: .share)
    
    func fetchAlbumList(pinEntity: PinEntity) -> Observable<[PhotoEntity]> {
        return albumRepository.fetchAlbumList(pinEntity: pinEntity)
    }
}
