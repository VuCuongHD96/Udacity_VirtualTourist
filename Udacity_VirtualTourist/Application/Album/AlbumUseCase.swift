//
//  AlbumUseCase.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation
import CoreData

protocol AlbumUseCaseType {
    func fetchAlbumList(pinEntity: PinEntity) -> Observable<[PhotoStorageEntity]>
    func fetchPhotoList(albumItemViewData: AlbumItemViewData) -> Observable<[PhotoStorageEntity]>
    func delete(object: NSManagedObject)
    func save() -> Observable<Bool>
}

struct AlbumUseCase: AlbumUseCaseType {
    
    let albumRepository: AlbumRepositoryType
    let albumStorageRepository = AlbumStorageRepository(coreDataManager: .shared)
    
    func fetchAlbumList(pinEntity: PinEntity) -> Observable<[PhotoStorageEntity]> {
        return albumRepository.fetchPhotoList(pinEntity: pinEntity)
    }
    
    func fetchPhotoList(albumItemViewData: AlbumItemViewData) -> Observable<[PhotoStorageEntity]> {
        let request = PhotoStorageRequest(photoID: albumItemViewData.photoID)
        return albumStorageRepository.coreDataManager.request(input: request)
    }
    
    func delete(object: NSManagedObject) {
        albumStorageRepository.delete(object: object)
    }
    
    func save() -> Observable<Bool> {
        albumStorageRepository.save()
    }
}
