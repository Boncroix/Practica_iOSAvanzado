//
//  UIViewController.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 26/2/24.
//

import UIKit

extension UIViewController {
    
    func setupNavigationBarWithLogout() {
        navigationController?.navigationBar.tintColor = UIColor.black
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        logoutButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)], for: .normal)
        navigationItem.rightBarButtonItem = logoutButton
    }
    

    @objc func logoutTapped() {
        let backVC = LoginVC()
        self.navigationController?.setViewControllers([backVC], animated: true)
    }
}
