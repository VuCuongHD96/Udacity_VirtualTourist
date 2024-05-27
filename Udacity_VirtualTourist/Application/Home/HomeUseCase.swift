//
//  HomeUseCase.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 27/5/24.
//

import Foundation
import CoreLocation

protocol HomeUseCaseType {
    func getAddressNameFrom(location: CLLocationCoordinate2D) -> Observable<[CLPlacemark]>
}

struct HomeUseCase: HomeUseCaseType {
    
    let geocoderManager = GeocoderManager()
    
    func getAddressNameFrom(location: CLLocationCoordinate2D) -> Observable<[CLPlacemark]> {
        geocoderManager.getAddressNameFrom(location: location)
    }
}
