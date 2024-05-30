//
//  AlbumStorageRepository.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 30/5/24.
//

import Foundation

class AlbumStorageRepository: CoreDataBaseRepository {
    
}

extension AlbumStorageRepository: AlbumRepositoryType {
    
    func fetchPhotoList(pinEntity: PinEntity) -> Observable<[PhotoStorageEntity]> {
        let request = PhotoStorageRequest()
        request.findPhoto(with: pinEntity.pinID!)
        return coreDataManager.request(input: request)
    }
}

