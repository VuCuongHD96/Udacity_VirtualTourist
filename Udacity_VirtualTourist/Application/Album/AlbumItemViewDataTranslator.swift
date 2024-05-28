//
//  AlbumItemViewDataTranslator.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

struct AlbumItemViewDataTranslator {
    
    static func createAlbumItemViewData(from photoEntityArray: [PhotoEntity]) -> [AlbumItemViewData] {
        return photoEntityArray.map {
            let urlString = "https://farm\($0.farm).staticflickr.com/\($0.server)/\($0.id)_\($0.secret).jpg"
            return .init(imageUrlString: urlString)
        }
    }
}
