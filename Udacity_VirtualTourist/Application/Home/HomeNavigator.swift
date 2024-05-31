//
//  HomeNavigator.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 25/5/24.
//

import UIKit
import SwiftUI

protocol HomeNavigatorType {
    func toAlbum(pinEntity: PinEntity, albumRepository: AlbumRepositoryType)
}

struct HomeNavigator: HomeNavigatorType {
    
    let navigationController: UINavigationController
    
    func toAlbum(pinEntity: PinEntity, albumRepository: AlbumRepositoryType) {
        let useCase = AlbumUseCase(albumRepository: albumRepository)
        let navigator = AlbumNavigator(navigationController: navigationController)
        let viewModel = AlbumViewModel(useCase: useCase, navigator: navigator, pinEntity: pinEntity)
        let albumView = AlbumView(viewModel: viewModel)
        let albumScreen = UIHostingController(rootView: albumView)
        navigationController.pushViewController(albumScreen, animated: true)
    }
}
