//
//  ViewController.swift
//  Preprocessor-Example
//
//  Created by 순진이 on 2022/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    var server = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // 전처리 (preprocessor)
        // 컴파일이 안되도록 막을 수 있음
//        #if DEBUG
//        print("Debug: Debug 모드에서만 보임")
//        #else
//        print("Release: Release 모드에서만 보임")
//        #endif
        
//    // 모드마다 변수를 설정할 수도 있음
//    #if TEST
//        server = "Server Test"
//    #elseif DEBUG
//        server = "Debug Server"
//    #elseif QA
//        server = "QA Server"
//    #else
//        server = "Relese Server"
//    #endif
//
//
//
//
//        print(server)
//
        
            #if DEBUG
                server = "Debug Server"
            #elseif QA
                server = "QA Server"
            #else
                server = "Relese Server"
            #endif
        
        print(server)
    }
    
    
}

