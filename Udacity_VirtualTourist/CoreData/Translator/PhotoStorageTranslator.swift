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
            .init(urlString: $0.urlString, pinEntity: pinEntity)
        }
    }
}
