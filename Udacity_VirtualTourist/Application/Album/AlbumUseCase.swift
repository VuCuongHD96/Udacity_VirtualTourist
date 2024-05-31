//
//  AlbumUseCase.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

protocol AlbumUseCaseType {
    func fetchAlbumList(pinEntity: PinEntity) -> Observable<[PhotoStorageEntity]>
}

struct AlbumUseCase: AlbumUseCaseType {
    
    let albumRepository: AlbumRepositoryType
    
    func fetchAlbumList(pinEntity: PinEntity) -> Observable<[PhotoStorageEntity]> {
        return albumRepository.fetchPhotoList(pinEntity: pinEntity)
    }
}
