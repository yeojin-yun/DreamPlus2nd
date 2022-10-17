//
//  NetworkError.swift
//  Combine-Example
//
//  Created by 순진이 on 2022/10/17.
//

import Foundation
enum NetworkError: Error {
    case badURL
    case badResponse
    case communicationError
    case decodedError
    case noData
}
