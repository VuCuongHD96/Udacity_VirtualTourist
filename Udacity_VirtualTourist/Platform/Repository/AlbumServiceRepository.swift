//
//  AlbumServiceRepository.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

class AlbumServiceRepository: ServiceBaseRepository {
}

extension AlbumServiceRepository: AlbumRepositoryType {
    
    func fetchPhotoList(pinEntity: PinEntity) -> Observable<[PhotoStorageEntity]> {
        let request = AlbumRequest(pinEntity: pinEntity)
        return api.request(input: request)
            .map { (data: PhotosResponse) in
                return data.photos.photo
            }
            .map {
                PhotoStorageTranslator.createPhotoStorageEntityArray(from: $0, pinEntity: pinEntity)
            }
            .eraseToAnyPublisher()
    }
}
