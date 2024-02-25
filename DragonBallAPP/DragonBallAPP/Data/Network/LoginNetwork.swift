//
//  LoginNetwork.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 25/2/24.
//

import Foundation

protocol LoginNetworkProtocol {
    func login (email: String,
                password: String,
                onSucces: @escaping (String?) -> Void,
                onError: @escaping (NetworkError) -> Void)
}

final class LoginNetwork: LoginNetworkProtocol {
    
    private var secureData: SecureDataKeychainProtocol
    
    
    //MARK: - Inits
    init(secureData: SecureDataKeychainProtocol = SecureDataKeychain()) {
        self.secureData = secureData
    }
    
    //MARK: - Login
    func login(email: String,
               password: String,
               onSucces: @escaping (String?) -> Void,
               onError: @escaping (NetworkError) -> Void)
    {
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.login.rawValue)") else {
            onError(.malformedURL)
            return
        }
        
        let loginString = String(format: "%@:%@", email, password)
        guard let loginData = loginString.data(using: .utf8) else {
            onError(.dataFormatting)
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard error == nil else {
                onError(.other)
                return
            }
            guard let data = data else {
                onError(.noData)
                return
            }
            guard let httpResponse = (response as? HTTPURLResponse),
                  httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                onError(.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            guard let token = String(data: data, encoding: .utf8) else {
                onError(.tokenFormatError)
                return
            }
            
            onSucces(token)
            self?.secureData.setToken(token: token)
        }
        task.resume()
    }
}
