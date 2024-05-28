//
//  PinItemViewDataTranslator.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 28/5/24.
//

import Foundation

struct PinItemViewDataTranslator {
    
    static func createPinItemViewData(pinEntity: PinEntity) -> PinItemViewData {
        .init(id: pinEntity.pinID!, 
              latitude: pinEntity.latitude,
              longitude: pinEntity.longitude,
              name: pinEntity.name!)
    }
    
    static func createPinItemViewDataArray(pinEntityArray: [PinEntity]) -> [PinItemViewData] {
        pinEntityArray.map {
            createPinItemViewData(pinEntity: $0)
        }
    }
}
