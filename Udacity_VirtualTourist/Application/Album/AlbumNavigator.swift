//
//  AlbumNavigator.swift
//  Udacity_VirtualTourist
//
//  Created by Work on 26/5/24.
//

import UIKit

protocol AlbumNavigatorType {
    func goBack()
}

struct AlbumNavigator: AlbumNavigatorType {
    
    let navigationController: UINavigationController
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
