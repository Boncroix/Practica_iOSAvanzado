//
//  LoginVC.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 23/2/24.
//

import UIKit

final class LoginVC: UIViewController {
    
    private var viewModel: LoginVM
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var contraintLoginButton: NSLayoutConstraint!
    
    
    //MARK: - Inits
    init(viewModel: LoginVM = LoginVM()) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: LoginVC.self),
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
    }
    
    //MARK: - IBActions
    @IBAction func didTapLoginButton(_ sender: Any) {
        viewModel.onLoginButton(email: emailTextField.text, password: passwordTextField.text)
    }
    
}


//MARK: - Extension
extension LoginVC {
    
    //MARK: - Observers
    private func setObservers() {
        viewModel.loginViewState = { [weak self] status in
            switch status {
            case .loading(let isLoading):
                self?.loadingView.isHidden = !isLoading
                self?.errorEmail.isHidden = true
                self?.errorPassword.isHidden = true
                
            case .loaded:
                self?.loadingView.isHidden = true
                self?.navigateToHome()
                
            case .showErrorEmail(let error):
                self?.errorEmail.text = error
                self?.errorEmail.isHidden = (error == nil || error?.isEmpty == true)
                
            case .showErrorPassword(let error):
                self?.errorPassword.text = error
                self?.errorPassword.isHidden = (error == nil || error?.isEmpty == true)
                
            case .errorNetwork(let errorMessage):
                self?.loadingView.isHidden = true
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    //MARK: - Navigate
    private func navigateToHome() {
        let nextVC = HomeVC()
        navigationController?.setViewControllers([nextVC], animated: true)
    }
    
    //MARK: - Alert
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error Network", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
