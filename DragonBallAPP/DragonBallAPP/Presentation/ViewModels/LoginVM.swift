//
//  LoginVM.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 24/2/24.
//

import Foundation

final class LoginVM {
    
    //MARK: - Binding con UI
    var loginViewState: ((LoginStatusLoad) -> Void)?
    
    //MARK: - Binding con loginNetwork
    private let loginNetwork: LoginNetworkProtocol
    
    //MARK: - Inits
    init(loginNetwork: LoginNetworkProtocol = LoginNetwork()) {
        self.loginNetwork = loginNetwork
    }
    
    //MARK: - Methods
    func onLoginButton(email: String?, password: String?) {
        loginViewState?(.loading(true))
        
        //Check email
        guard let email = email, isValid(email: email) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorEmail("Error en el email"))
            return
        }
        
        //Check password
        guard let password = password, isValid(password: password) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorPassword("Error en el password"))
            return
        }
        
        doLoginWith(email: email, password: password)
    }
    
    //Check email
    private func isValid(email: String) -> Bool {
        email.isEmpty == false && email.contains("@")
    }
    
    //Check password
    private func isValid(password: String) -> Bool {
        password.isEmpty == false && password.count >= 4
    }
    
    private func doLoginWith(email: String, password: String) {
        loginNetwork.login(user: email, password: password) { [weak self] token in
            DispatchQueue.main.async {
                self?.loginViewState?(.loaded)
            }
        } onError: { [weak self] networkError in
            DispatchQueue.main.async {
                var errorMessage = "Error Desconocido"
                switch networkError {
                case .malformedURL:
                    errorMessage = "Error mal formed URL"
                case .dataFormatting:
                    errorMessage = "Error data formating"
                case .other:
                    errorMessage = "Error other"
                case .noData:
                    errorMessage = "Error no data"
                case .errorCode(let error):
                    errorMessage = "Error code \(error?.description ?? "Unknown")"
                case .tokenFormatError:
                    errorMessage = "Error token format"
                case .decoding:
                    errorMessage = "Error desconocido"
                }
                self?.loginViewState?(.errorNetwork(_error: errorMessage))
            }
        }

    }
}
