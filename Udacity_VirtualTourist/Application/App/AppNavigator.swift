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
        navigationController.navigationBar.isHidden = true
        let navigator = HomeNavigator(navigationController: navigationController)
        let useCase = HomeUseCase()
        let homeViewModel = HomeViewModel(navigator: navigator, useCase: useCase)
        let homeView = HomeView(viewModel: homeViewModel)
        let viewController = UIHostingController(rootView: homeView)
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
