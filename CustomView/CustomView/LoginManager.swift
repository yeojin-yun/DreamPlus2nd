//
//  LoginManager.swift
//  CustomView
//
//  Created by 순진이 on 2022/08/10.
//

import Foundation

struct LoginManager {
    
    private let id = "admin"
    private let password = "temp"
    
    func check(id: String, password: String) -> Bool {
        return id == self.id && password == self.password
    }
}
