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
    var appViewModel: AppViewModel!
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        toMainView()
        return true
    }
    
    private func toMainView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigator = AppNavigator(window: window)
        let useCase = AppUseCase()
        appViewModel = AppViewModel(navigator: navigator, useCase: useCase)
        appViewModel.toMainView()
    }
    
    private func saveData() {
        _ = appViewModel
            .saveData()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        saveData()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
}
