//
//  SplashViewController.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 23/2/24.
//

import UIKit

final class SplashVC: UIViewController {
    
    private var viewModel: SplashVM
    
    
    //MARK: - IbOutlets
    @IBOutlet weak var splashActivityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Inits
    init(viewModel: SplashVM = SplashVM()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: SplashVC.self), 
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
        viewModel.simulationLoadData()
    }
}


//MARK: - Extension
extension SplashVC {

    private func setObservers() {
        viewModel.modelStatusLoad = { [weak self] status in
            switch status {
            case .loading:
                self?.showLoading(show: true)
            case .loaded:
                self?.showLoading(show: false)
                self?.navigateToLogin()
            case .error:
                print("error")
            case .none:
                print("nada")
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
        let nextVC = LoginVC()
        navigationController?.setViewControllers([nextVC], animated: false)
    }
}




