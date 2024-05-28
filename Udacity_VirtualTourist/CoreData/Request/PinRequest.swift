//
//  PinRequest.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 28/5/24.
//

import Foundation
import CoreData

struct PinRequest: CoreDataBaseRequestType {
    
    typealias T = PinEntity
    var request: NSFetchRequest<PinEntity>
    
    init() {
        request = T.fetchRequest()
    }
}
