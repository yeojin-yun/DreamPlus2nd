//
//  NetworkError.swift
//  Async-Await
//
//  Created by 순진이 on 2022/09/19.
//

import Foundation

enum NetworkError: Error {
    case badResponse
    case communicationError
    case decodeFailed
    case noData
}
