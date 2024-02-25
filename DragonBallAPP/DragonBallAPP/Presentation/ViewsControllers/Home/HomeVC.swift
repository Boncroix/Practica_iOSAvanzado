//
//  HomeVC.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 24/2/24.
//

import UIKit

final class HomeVC: UIViewController {
    
    private var viewModel: HomeVM
    
    init(viewModel: HomeVM = HomeVM()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HomeVC.self),
                   bundle: nil)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logoutTapped(_ sender: Any) {
        viewModel.deleteToken()
        navigateToLogin()
    }
    private func navigateToLogin() {
        let nextVC = LoginVC()
        navigationController?.setViewControllers([nextVC], animated: false)
    }
}
