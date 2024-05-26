//
//  AppViewModel.swift
//  Udacity_OnTheMap
//
//  Created by Work on 21/03/2024.
//

import Foundation

struct AppViewModel {
    
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
}

extension AppViewModel {
    
    func toMainView() {
        navigator.toMainView()
    }
    
    func saveData() -> Observable<Bool> {
        return useCase.saveData()
    }
}
