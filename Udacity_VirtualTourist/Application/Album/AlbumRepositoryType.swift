//
//  AlbumRepositoryType.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 31/5/24.
//

import Foundation

protocol AlbumRepositoryType {
    
    func fetchPhotoList(pinEntity: PinEntity) -> Observable<[PhotoStorageEntity]>
}
