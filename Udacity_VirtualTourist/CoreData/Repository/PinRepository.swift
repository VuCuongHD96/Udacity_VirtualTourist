//
//  PinRepository.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 28/5/24.
//

import Foundation

protocol PinRepositoryType {
    
    func getPinList() -> Observable<[PinEntity]>
}

class PinRepository: CoreDataBaseRepository {
    
}

extension PinRepository: PinRepositoryType {
    
    func getPinList() -> Observable<[PinEntity]> {
        let request = PinRequest()
        return coreDataManager.request(input: request)
    }
}
