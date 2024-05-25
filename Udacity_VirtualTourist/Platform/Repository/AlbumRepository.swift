//
//  AlbumRepository.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

class AlbumRepository: ServiceBaseRepository {
    
    func fetchAlbumList(pinItemViewData: PinItemViewData) -> Observable<[PhotoEntity]> {
        let request = AlbumRequest(pinItemViewData: pinItemViewData)
        return api.request(input: request)
            .map { (data: PhotosResponse) in
                return data.photos.photo
            }
            .eraseToAnyPublisher()
    }
}
