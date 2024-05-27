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
    func getPinList() -> Observable<[PinEntity]>
}

struct HomeUseCase: HomeUseCaseType {
    
    let geocoderManager = GeocoderManager()
    let pinRepository = PinRepository(coreDataManager: .shared)
    
    func getAddressNameFrom(location: CLLocationCoordinate2D) -> Observable<[CLPlacemark]> {
        geocoderManager.getAddressNameFrom(location: location)
    }
    
    func getPinList() -> Observable<[PinEntity]> {
        pinRepository.getPinList()
    }
}
