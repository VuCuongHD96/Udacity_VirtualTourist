//
//  HomeViewModel.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 19/5/24.
//

import Foundation
import MapKit
import Combine

struct HomeViewModel {
    let navigator: HomeNavigatorType
}

extension HomeViewModel: ViewModel {
    
    class Input {
        var loadTrigger = Driver.just(Void())
        var pinLocation = PassthroughSubject<CLLocationCoordinate2D, Never>()
        var annotationAction = PassthroughSubject<PinItemViewData, Never>()
    }
    
    class Output: ObservableObject {
        @Published var region: MKCoordinateRegion = .init()
        @Published var pinItemViewArray = [PinItemViewData]()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loadTrigger.map { _ in
            let coordinate = CLLocationCoordinate2D(latitude: 21.043507, longitude: 105.836508)
            let coordinateSpan = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
            return MKCoordinateRegion(center: coordinate, span: coordinateSpan)
        }
        .assign(to: \.region, on: output)
        .store(in: cancelBag)
        
        input.pinLocation
            .map { locationCoordinate in
                PinItemViewData(coordinate: locationCoordinate)
            }
            .sink { pinItemViewData in
                output.pinItemViewArray.append(pinItemViewData)
            }
            .store(in: cancelBag)
        
        input.annotationAction
            .sink { pinItemViewData in
                navigator.toAlbum(pinItemViewData: pinItemViewData)
            }
            .store(in: cancelBag)
        
        return output
    }
}
