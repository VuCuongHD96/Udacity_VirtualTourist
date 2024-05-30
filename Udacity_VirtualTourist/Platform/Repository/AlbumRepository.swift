//
//  AlbumRepository.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

class AlbumRepository: ServiceBaseRepository {
    
    func fetchAlbumList(pinEntity: PinEntity) -> Observable<[PhotoEntity]> {
        let request = AlbumRequest(pinEntity: pinEntity)
        return api.request(input: request)
            .map { (data: PhotosResponse) in
                return data.photos.photo
            }
            .handleEvents(receiveOutput: {
               _ = $0.map {
                    PhotoStorageEntity(urlString: $0.urlString, pinEntity: pinEntity)
                }
            })
            .eraseToAnyPublisher()
    }
}
