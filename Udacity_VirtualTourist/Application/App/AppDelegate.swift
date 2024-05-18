//
//  AppDelegate.swift
//  Udacity_OnTheMap
//
//  Created by Work on 21/03/2024.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        toMainView()
        return true
    }
    
    private func toMainView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigator = AppNavigator(window: window)
        let appViewModel = AppViewModel(navigator: navigator)
        appViewModel.toMainView()
    }
}
