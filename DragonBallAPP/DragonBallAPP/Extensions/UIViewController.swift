//
//  UIViewController.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 26/2/24.
//

import UIKit

extension UIViewController {
    
    func setupNavigationBarWithLogout() {
        navigationController?.navigationBar.tintColor = UIColor.customColor2
        
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular)
        let symbolImage = UIImage(systemName: "figure.walk.motion", withConfiguration: symbolConfiguration)
        
        let logoutButton = UIButton(type: .custom)
        logoutButton.setImage(symbolImage, for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: logoutButton)
        
        navigationItem.rightBarButtonItem = barButton
    }
    

    @objc func logoutTapped() {
        let backVC = LoginViewController()
        self.navigationController?.setViewControllers([backVC], animated: true)
    }
}
