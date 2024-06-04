//
//  PinItemViewData.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 28/5/24.
//

import Foundation
import CoreLocation

struct PinItemViewData: Identifiable {
    let id: String
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var name: String
    
    init(id: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees, name: String) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
    init() {
        self.init(id: "", latitude: 0, longitude: 0, name: "")
    }
}
