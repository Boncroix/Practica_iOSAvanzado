//
//  LoginVC.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 23/2/24.
//

import UIKit

final class LoginVC: UIViewController {
    
    private var viewModel: LoginVM
    private var secureData: SecureDataKeychainProtocol
    private var constraisntBottomLoginButtonDefault = 50.0
    private var constraintTopLoginButtonDefault = 50.0
    
    //MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var constraintBottomLoginButton: NSLayoutConstraint!
    @IBOutlet weak var constraintTopLoginButton: NSLayoutConstraint!
    
    
    //MARK: - Inits
    init(viewModel: LoginVM = LoginVM(), 
         secureData: SecureDataKeychainProtocol = SecureDataKeychain()) {
        self.viewModel = viewModel
        self.secureData = secureData
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
        secureData.deleteToken()
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:  #selector(changedFrameKeyboard(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, 
                                               selector: #selector(changedOrientation(notification:)),
                                               name: UIDevice.orientationDidChangeNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
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
    
    //MARK: - Objc
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc func changedFrameKeyboard(notification: Notification) {
        let userInfo = notification.userInfo
        let frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let delta = UIScreen.main.bounds.size.height - (frame?.origin.y ?? 0)
        self.constraintBottomLoginButton.constant = constraisntBottomLoginButtonDefault + delta
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func changedOrientation(notification: Notification) {
        let orientation = UIDevice.current.orientation
        self.view.endEditing(true)
        switch orientation {
        case .portrait:
            constraisntBottomLoginButtonDefault = 50.0
            self.constraintBottomLoginButton.constant = constraisntBottomLoginButtonDefault
            self.constraintTopLoginButton.constant = constraintTopLoginButtonDefault
        case .landscapeLeft, .landscapeRight, .portraitUpsideDown:
            self.constraintBottomLoginButton.constant = 4.0
            self.constraintTopLoginButton.constant = 4.0
            constraisntBottomLoginButtonDefault = 4.0
        default: break
        }
    }
}
