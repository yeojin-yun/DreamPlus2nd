//
//  NetworkError.swift
//  Result
//
//  Created by 순진이 on 2022/09/07.
//

import Foundation


//Error protocol을 채택해야 함
enum NetworkError: Error {
    case badUrl
    case badResponse
    case communicationError
    case decodeFailed
    case noData
    // case는 얼마든지 늘리고 줄여도 됨
}

// localizedDescription를 잘 작성해두면 error를 잘 파악할 수 있음
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badUrl:
            return "badUrl 오류입니다."
        case .badResponse:
            return "badResponse 오류입니다."
        case .communicationError:
            return "communicationError 오류입니다."
        case .decodeFailed:
            return "decodeFailed 오류입니다."
        case .noData:
            return "noData 오류입니다."
        }
    }
}
