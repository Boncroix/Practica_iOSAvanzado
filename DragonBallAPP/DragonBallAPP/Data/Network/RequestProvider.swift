//
//  RequestProvider.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 29/2/24.
//

import Foundation


struct RequestProvider {
    let host = URL(string: "https://dragonball.keepcoding.education")!
    
    func requestFor(endPoint: EndPoints) -> URLRequest {
        let url = host.appendingPathComponent(endPoint.endpoint())
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.post
        return request
    }
    
    func requestFor(endPoint: EndPoints, token: String, params: [String: Any]) -> URLRequest {
        var request = self.requestFor(endPoint: endPoint)
        let jsonParameters = try? JSONSerialization.data(withJSONObject: params)
        request.httpBody = jsonParameters
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue(HTTPMethods.contentType, forHTTPHeaderField: "Content-Type")
        return request
    }
}
