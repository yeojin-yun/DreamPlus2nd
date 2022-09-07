//
//  ViewController.swift
//  Result
//
//  Created by 순진이 on 2022/09/07.
//

import UIKit

// Result
// 어떤 결과값이 성공 or 실패로 나뉜다면 Result로 쓰면 좋음. 예를들어 URLSession


class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getQuote { result in
            switch result {
            case .success(let quote):
                print(quote)
            case .failure(let error):
                print(error)
                print(error.localizedDescription) // localizedDescription를 잘 작성해두면 error를 잘 파악할 수 있음
                //이렇게 error를 switch로 분기처리할 수도 있음
//                switch error {
//                case .noData:
//                case .badResponse:
//                case .communicationError:
//                case .badUrl:
//                case .decodeFailed:
//                }
            }
        }
    }
}

extension ViewController {
    
    // @frozen enum Result<Success, Failure> where Failure : Error
    // Failure는 Error 프로토콜을 채택해야 함
    private func getQuote(completion: @escaping (Result<Quote, NetworkError>) -> Void) {
        let url = URL(string: "https://api.quotable.io/random")
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                completion(.failure(.communicationError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            
            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                completion(.success(quote))
            } catch {
                print(error)
            }
            
        }.resume()
    }
    
    private func throwingGetQuote(completion: @escaping (Result<Quote, NetworkError>) -> Void) throws {
        let url = URL(string: "https://api.quotable.io/random")
        guard let url = url else {
            throw NetworkError.badUrl
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.communicationError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                completion(.failure(.badResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            
            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                completion(.success(quote))
            } catch {
                print(error)
            }
            
        }.resume()
        
    }
    
    
}
