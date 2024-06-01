//
//  PhotoStorageRequest.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 30/5/24.
//

import CoreData

class PhotoStorageRequest: CoreDataBaseRequestType {
    
    typealias T = PhotoStorageEntity
    var request: NSFetchRequest<T> = T.fetchRequest()
    
    init(pinID: String) {
        let predicate = NSPredicate(format: "toPin.pinID == %@", "\(pinID)")
        request.predicate = predicate
    }
    
    init(photoID: String) {
        let predicate = NSPredicate(format: "photoID == %@", "\(photoID)")
        request.predicate = predicate
    }
}
