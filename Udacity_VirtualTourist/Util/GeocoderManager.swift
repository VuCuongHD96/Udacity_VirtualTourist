//
//  GeocoderManager.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 27/5/24.
//

import CoreLocation
import Combine

protocol GeocoderManagerType {
    
    func getAddressNameFrom(location: CLLocationCoordinate2D) -> Observable<[CLPlacemark]>
}

struct GeocoderManager: GeocoderManagerType {
    
    private let geoCoder = CLGeocoder()
    
    func getAddressNameFrom(location: CLLocationCoordinate2D) -> Observable<[CLPlacemark]> {
        return Future { promise in
            let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
            geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let placemarks = placemarks {
                    promise(.success(placemarks))
                } else {
                    promise(.failure(BaseError.locationError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
