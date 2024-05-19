//
//  AppNavigator.swift
//  Udacity_OnTheMap
//
//  Created by Work on 21/03/2024.
//

import UIKit
import SwiftUI

protocol AppNavigatorType {
    func toMainView()
}

struct AppNavigator: AppNavigatorType {
    
    unowned let window: UIWindow!
    
    func toMainView() {
        let navigationController = UINavigationController()
        let homeView = HomeView()
        let viewController = UIHostingController(rootView: homeView)
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
