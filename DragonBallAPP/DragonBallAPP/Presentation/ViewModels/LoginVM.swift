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
        } onError: { networkError in
            DispatchQueue.main.async {
                switch networkError {
                case .malformedURL:
                    print("malformedURL")
                case .dataFormatting:
                    print("dataFormatting")
                case .other:
                    print("other")
                case .noData:
                    print("noData")
                case .errorCode(_):
                    print("errorCode")
                case .tokenFormatError:
                    print("tokenFormatError")
                case .decoding:
                    print("decoding")
                }
            }
        }

    }
}
