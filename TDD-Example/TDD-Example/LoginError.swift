//
//  LoginError.swift
//  TDD-Example
//
//  Created by 순진이 on 2022/11/21.
//

import Foundation
enum LoginError: Error {
    case notEnoughInfo
    case idRequired
    case wrongPassword
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notEnoughInfo:
            return "아이디, 패스워드를 올바르게 입력하세요."
        case .idRequired:
            return "아이디를 올바르게 입력하세요."
        case .wrongPassword:
            return "비밀번호가 잘못되었습니다."
        }
    }
}
