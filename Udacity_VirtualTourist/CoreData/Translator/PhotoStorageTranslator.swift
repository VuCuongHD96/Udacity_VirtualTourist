//
//  PhotoStorageTranslator.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 30/5/24.
//

import Foundation

struct PhotoStorageTranslator {
    
    static func createPhotoStorageEntityArray(from photoServiceEntity: [PhotoEntity],
                                              pinEntity: PinEntity) -> [PhotoStorageEntity] {
        photoServiceEntity.map {
            let photoURL = URL(string: $0.urlString)
            let photoData = try? Data(contentsOf: photoURL!)
            return .init(photoID: $0.id, pinEntity: pinEntity, photoData: photoData)
        }
    }
}
