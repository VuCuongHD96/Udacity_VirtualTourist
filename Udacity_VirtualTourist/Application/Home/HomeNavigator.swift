//
//  HomeNavigator.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import UIKit
import SwiftUI

protocol HomeNavigatorType {
    func toAlbum()
}

struct HomeNavigator: HomeNavigatorType {
    
    let navigationController: UINavigationController
    
    func toAlbum() {
        let useCase = AlbumUseCase()
        let navigator = AlbumNavigator(navigationController: navigationController)
        let viewModel = AlbumViewModel(useCase: useCase, navigator: navigator)
        let albumView = AlbumView(viewModel: viewModel)
        let albumScreen = UIHostingController(rootView: albumView)
        navigationController.pushViewController(albumScreen, animated: true)
    }
}
