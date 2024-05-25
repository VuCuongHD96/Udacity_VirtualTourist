//
//  AlbumRepository.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

class AlbumRepository: ServiceBaseRepository {
    
    func fetchAlbumList() -> Observable<[PhotoEntity]> {
        let request = AlbumRequest()
        return api.request(input: request)
            .map { (data: PhotosResponse) in
                return data.photos.photo
            }
            .eraseToAnyPublisher()
    }
}
