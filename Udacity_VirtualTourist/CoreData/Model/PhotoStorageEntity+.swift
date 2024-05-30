//
//  PhotoStorageEntity+.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 30/5/24.
//

import Foundation
import CoreData

extension PhotoStorageEntity {
    
    convenience init(urlString: String, pinEntity: PinEntity) {
        self.init(context: CoreDataManager.shared.container.viewContext)
        self.urlString = urlString
        self.toPin = pinEntity
    }
}
