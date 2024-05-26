//
//  AppUseCase.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 27/5/24.
//

import Foundation

protocol AppUseCaseType {
    
    func saveData() -> Observable<Bool>
}

struct AppUseCase: AppUseCaseType {
    
    let coreDataManager = CoreDataManager.shared
    
    func saveData() -> Observable<Bool> {
        return coreDataManager.save()
    }
}
