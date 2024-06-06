//
//  AlbumItemViewData.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

struct AlbumItemViewData: Identifiable, Equatable {
    var id: String
    var photoID: String
    var photoData: Data?
    
    init(id: String, photoID: String, photoData: Data?) {
        self.id = id
        self.photoID = photoID
        self.photoData = photoData
    }
    
    init(id: String) {
        self.init(id: id, photoID: "", photoData: nil)
    }
}
