//
//  ViewController.swift
//  Async-Await
//
//  Created by 순진이 on 2022/09/19.
//

import UIKit

class ViewController: UIViewController {
    
    let networkService = NetworkService.shared
    
    let centerLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setAttributes()
        //        networkService.getQuote { result in
        //            switch result {
        //            case .success(let quote):
        //                print(quote)
        //            case .failure(let error):
        //                print(error)
        //            }
        //        }
        //
        //
        // async함수는 반드시 Task 안에서 써야 함. await 키워드와 함께 -> 그러나 async 함수 안에서 await를 쓸 때는 Task 안 써도 됨
        //        Task {
        //            let quote = await networkService.getQuoteWithAsync()
        //            print(quote)
        //        }
        
        
        //배열로 부를 때
        //        Task {
        //            print(await networkService.getQuotesArray(), "0")
        //        }
        
        Task {
            print(await networkService.continuationGetQuote())
        }
    }
}

// MARK: -URLSession
extension ViewController {
    func setUI() {
        view.addSubview(centerLabel)
        centerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            centerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            centerLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            centerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            centerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setAttributes() {
        centerLabel.textColor = .blue
    }
}
