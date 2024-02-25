//
//  NetworkError.swift
//  DragonBallAPP
//
//  Created by Jose Bueno Cruz on 25/2/24.
//

import Foundation

enum NetworkError: Error {
    case malformedURL
    case dataFormatting
    case other
    case noData
    case errorCode(Int?)
    case tokenFormatError
    case decoding
}
