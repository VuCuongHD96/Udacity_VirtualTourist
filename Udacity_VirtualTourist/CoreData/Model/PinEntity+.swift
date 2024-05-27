//
//  PinEntity+.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 26/5/24.
//
//

import Foundation
import CoreData

extension PinEntity {
    
    convenience init(pinID: String,
                     locationName: String,
                     latitude: Double,
                     longitude: Double) {
        self.init(context: CoreDataManager.shared.container.viewContext)
        self.pinID = pinID
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
    }
}
