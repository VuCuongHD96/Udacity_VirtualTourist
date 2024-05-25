//
//  PhotosEntity.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import Foundation

struct PhotosEntity: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [PhotoEntity]
}
