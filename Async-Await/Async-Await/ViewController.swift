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
        getQuote()
    }
    
//    func getQuote() {
//        networkService.getQuote { [weak self] result in
//            switch result {
//            case .success(let quote):
//                print(quote)
//                DispatchQueue.main.async {
//                    self?.centerLabel.text = quote
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    func getQuote() {
//
//        //async함수는 반드시 Task 안에서 써야 함. await 키워드와 함께 -> 그러나 async 함수 안에서 await를 쓸 때는 Task 안 써도 됨
//        Task {
//            let quote = await networkService.getQuoteWithAsync()
//
//                self.centerLabel.text = quote
//
//        }
//
//    }
//    
//    func getQuotesArray() {
//        var quoteArray = ""
//        Task {
//            let quotes = await networkService.getQuotesArray1()
//
//            quotes.forEach { quoteArray += "-\($0)\n" }
//            self.centerLabel.text = quoteArray
//        }
//    }
    
//    func getQuotesArray() {
//        var quoteArray = ""
//        //async함수는 반드시 Task 안에서 써야 함. await 키워드와 함께 -> 그러나 async 함수 안에서 await를 쓸 때는 Task 안 써도 됨
//        Task {
//            let quotes = await networkService.getQuotesArray3()
//
//            quotes.forEach { quoteArray += "-\($0)\n" }
//            self.centerLabel.text = quoteArray
//        }
//    }
        
    
    func getQuote() {
        Task {
            let quote = await networkService.continuationGetQuote()
            self.centerLabel.text = quote
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
        centerLabel.textColor = .black
        centerLabel.textAlignment = .center
        centerLabel.numberOfLines = 0
    }
}
