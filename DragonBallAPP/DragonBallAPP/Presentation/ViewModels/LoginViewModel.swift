//
//  LoginVM.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 24/2/24.
//

import Foundation

final class LoginViewModel {
    
    //MARK: - Binding con UI
    var loginViewState: ((LoginStatusLoad) -> Void)?
    
    //MARK: - Binding con loginNetwork
    private let client: ApiProvider
    
    //MARK: - Inits
    init(client: ApiProvider = ApiProvider()) {
        self.client = client
    }
    
    //MARK: - Methods Login
    func onLoginButton(email: String?, password: String?) {
        loginViewState?(.loading(true))
        
        guard let email = email, isValid(email: email) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorEmail("Error en el email"))
            return
        }
        
        guard let password = password, isValid(password: password) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorPassword("Error en el password"))
            return
        }
        
        client.loginWith(email: email, password: password) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.loginViewState?(.loaded)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.loginViewState?(.errorNetwork(_error: error.description))
                }
            }
        }
    }
    
    private func isValid(email: String) -> Bool {
        email.isEmpty == false && email.contains("@")
    }
    
    private func isValid(password: String) -> Bool {
        password.isEmpty == false && password.count >= 4
    }
}
