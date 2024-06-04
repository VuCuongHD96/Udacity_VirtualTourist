//
//  AlbumItemViewData.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

struct AlbumItemViewData: Identifiable, Equatable {
    var id = UUID().uuidString
    var photoID: String
    var imageUrlString: String
}
