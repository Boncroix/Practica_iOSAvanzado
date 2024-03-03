//
//  ApiProviderTests.swift
//  DragonBallAPPTests
//
//  Created by Jose Bueno Cruz on 3/3/24.
//

import XCTest
@testable import DragonBallAPP

final class ApiProviderTests: XCTestCase {
    
    let host =  URL(string: "https://dragonball.keepcoding.education")!
    let token = "expectedToken"
    
    var sut: ApiProvider!
    var sutLoginViewModel: LoginViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = ApiProvider(session: session)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_login() throws {
        // Given
        let tokenData = try XCTUnwrap(token.data(using: .utf8))
        let (user, password) = ("user", "password")
        MockURLProtocol.error = nil
        MockURLProtocol.handler = { request in
            let loginString = String(format: "%@:%@", user, password)
            let base64String = loginString.data(using: .utf8)!.base64EncodedString()
            XCTAssertEqual(request.httpMethod, HTTPMethods.post)
            XCTAssertEqual(
                request.value(forHTTPHeaderField: "Authorization"),
                "Basic \(base64String)")
            let response = try XCTUnwrap(
                MockURLProtocol.urlResponseFor(url: self.host))
            return (response, tokenData)
        }
        
        // When
        let expectation = expectation(description: "Login Success")
        var receivedToken: Bool?
        sut.loginWith(email: user, password: password) { result in
            switch result {
            case .success(let token):
                receivedToken = token
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but received \(error)")
                return
            }
        }
        
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(receivedToken)
        XCTAssertEqual(receivedToken, true)
    }
    
    /*
    func test_getHeroes() {
        // Given
        let expectedHero = Hero(id:"FE40CD14-7DCA-4135-944C-19D3EFE4697D", name: "Bootcamp Mobile II")

        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "GET")
            let url = try XCTUnwrap(request.url)
            XCTAssertEqual(url, self.host.appendingPathComponent("api/data/bootcamps"))
            
            let mockUrl = try XCTUnwrap(Bundle(for: type(of: self)).url(forResource: "MockBootcamps", withExtension: "json"))
            let data = try Data(contentsOf: mockUrl)
            
            let response = try  XCTUnwrap(MockURLProtocol.urlResponseFor(url: url))
            
            return (response, data)
        }
        
        
        //When
        let expectation = expectation(description: "Load Bootcamps")
        sut.getBootcamps { result in
            switch result {
            case .success(let bootcamps):
                XCTAssertEqual(bootcamps.count, 16)
                let firstBootcamp = bootcamps.first
                XCTAssertEqual(firstBootcamp?.id, expectedBootcamp.id)
                XCTAssertEqual(firstBootcamp?.name, expectedBootcamp.name)
            case .failure(_):
                XCTFail("Waiting for success")
            }
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.2)
    }
    
    func test_getBootcampsWithError() {
        //Given
        MockURLProtocol.error = NSError(domain: "io.keepcoding.LoadBootcamps", code: -1008)
        
        //When
        let expectation = expectation(description: "Load Bootcamps Server Error")
        sut.getBootcamps { result in
            switch result {
            case .success(_):
                XCTFail("Waiting for error")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.2)
    }
    
    func test_getBootcampsErrorStatusCode() {
        //Given
        MockURLProtocol.handler = { request in
            XCTAssertEqual(request.httpMethod, "GET")
            let url = try XCTUnwrap(request.url)
            XCTAssertEqual(url, self.host.appendingPathComponent("api/data/bootcamps"))
      
            let response = try  XCTUnwrap(MockURLProtocol.urlResponseFor(url: url, statusCode: 401))

            return (response, Data())
        }
        
        
        //When
        let expectation = expectation(description: "Load Bootcamps Error with Status code")
        sut.getBootcamps { result in
            switch result {
            case .success(_):
                XCTFail("Waiting for error")
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.description, "Received error status code 401")
            }
            expectation.fulfill()
        }
        
        //Then
        wait(for: [expectation], timeout: 0.2)
    }
     */
}
