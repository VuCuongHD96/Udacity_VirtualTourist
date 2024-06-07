//
//  PhotoStorageEntity+.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 30/5/24.
//

import Foundation
import CoreData

extension PhotoStorageEntity {
    
    convenience init(photoID: String, pinEntity: PinEntity, photoData: Data?) {
        self.init(context: CoreDataManager.shared.container.viewContext)
        self.toPin = pinEntity
        self.photoID = photoID
        self.photoData = photoData
    }
}
