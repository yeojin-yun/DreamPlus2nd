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
    
    let centerLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        throwingGetQuote { result in
            switch result {
            case .success(let data):
                do {
                    let quote = try? self.decodedData(data: data)
                } catch {
                    
                }
                
            case .failure(let error):
                
            }
        }
        
//        getQuote { [weak self] result in
//            print(result)
//            switch result {
//            case .success(let quote):
//
//                DispatchQueue.main.async {
//                    self?.centerLabel.text = "성공\n \(quote.content)"
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.centerLabel.text = "실패\n \(error.localizedDescription)"
//                }
//
//                //print(error.localizedDescription) // localizedDescription를 잘 작성해두면 error를 잘 파악할 수 있음
//                //이렇게 error를 switch로 분기처리할 수도 있음
////                switch error {
////                case .noData:
////                case .badResponse:
////                case .communicationError:
////                case .badUrl:
////                case .decodeFailed:
////                }
//            }
//        }
    }

}
                    
extension ViewController {
    
//    private func getQuote(completion: @escaping (Result<Quote, Error>) -> Void) {
//        let url = URL(string: "https://api.quotable.io/random")
//        URLSession.shared.dataTask(with: url!) { data, response, error in
//            guard error == nil else {
//                print("error")
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
//                print("response")
//                return
//            }
//
//            guard let data = data else {
//                return
//            }
//
//
//            do {
//                let quote = try JSONDecoder().decode(Quote.self, from: data)
//                completion(.success(quote))
//            } catch {
//                completion(.failure(error))
//            }
//
//        }.resume()
//    }
    
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
    
    private func throwingGetQuote(completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let url = URL(string: "https://api.quotable.io/random")!
        
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
            
            completion(.success(data))
            
        }.resume()
    }
    
    private func decodedData(data: Data) throws -> Quote {
        return try JSONDecoder().decode(Quote.self, from: data)
    }
}

// MARK: -URLSession
extension ViewController {
    func setUI() {
        setConstraints()
        setAttributes()
    }
    
    func setConstraints() {
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
        centerLabel.text = "Test"
    }
}
