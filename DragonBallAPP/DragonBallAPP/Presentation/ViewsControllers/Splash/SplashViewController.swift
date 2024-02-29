//
//  SplashViewController.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 23/2/24.
//

import UIKit

final class SplashViewController: UIViewController {
    
    private var viewModel: SplashViewModel
    
    
    //MARK: - IbOutlets
    @IBOutlet weak var splashActivityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Inits
    init(viewModel: SplashViewModel = SplashViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SplashViewController.self), 
                   bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservers()
        viewModel.checkToken()
    }
}


//MARK: - Extension
extension SplashViewController {

    private func setObservers() {
        viewModel.modelStatusLoad = { [weak self] status in
            switch status {
            case .loading:
                self?.showLoading(show: true)
            case .noToken:
                self?.showLoading(show: false)
                self?.navigateToLogin()
            case .haveToken:
                self?.showLoading(show: false)
                self?.naviateToHome()
            }
        }
    }
    
    private func showLoading(show: Bool) {
        switch show {
        case true where !splashActivityIndicator.isAnimating:
            splashActivityIndicator.startAnimating()
        case false where splashActivityIndicator.isAnimating:
            splashActivityIndicator.stopAnimating()
        default: break
        }
    }
    
    private func navigateToLogin() {
        let nextVC = LoginViewController()
        navigationController?.setViewControllers([nextVC], animated: false)
    }
    
    private func naviateToHome() {
        let nextVC = HerosCollectionView()
        navigationController?.setViewControllers([nextVC], animated: true)
    }
}




