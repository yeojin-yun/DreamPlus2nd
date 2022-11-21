//
//  LoginValidator.swift
//  TDD-Example
//
//  Created by 순진이 on 2022/11/21.
//

import Foundation
class LoginValidator {
    func isValid(id: String) -> Bool {
        return id.count > 3
    }
    
    func isValid(pw: String) ->  Bool {
        return pw.count >=  5
    }
    
    func shouldLogin(user: User, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            completion(self.isValid(id: user.id) && self.isValid(pw: user.pw))
        })
    }
}
