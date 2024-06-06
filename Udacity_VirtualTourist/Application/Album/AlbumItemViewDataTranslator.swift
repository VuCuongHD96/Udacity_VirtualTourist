//
//  AlbumItemViewDataTranslator.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

struct AlbumItemViewDataTranslator {
    
    static func createAlbumItemViewData(from photoStorageEntityArray: [PhotoStorageEntity]) -> [AlbumItemViewData] {
        return photoStorageEntityArray.map {
            return .init(id: UUID().uuidString, photoID: $0.photoID!, photoData: $0.photoData)
        }
    }
}
