//
//  DataManager.swift
//  Delegate
//
//  Created by 순진이 on 2022/08/24.
//

import Foundation

class DataManager {
    
    static let shared = DataManager() // 1번. 타입 속성으로 자기 자신을 객체로 찍어내기
    
    var text: String = ""
    
    private init() {} // 2번. 다른 곳에서 객체 생성 못하도록 막아놓음.
}
