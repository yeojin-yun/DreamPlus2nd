//
//  NetworkService.swift
//  Async-Await
//
//  Created by 순진이 on 2022/09/19.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    let url = URL(string: "https://api.quotable.io/random")!
    
    func getQuote(completion: @escaping (Result<String, NetworkError>) -> Void) -> String {
        var result = ""
        URLSession.shared.dataTask(with: url) { data, response, error in
            // 1. error check
            if let error = error {
                print(error)
                completion(.failure(.communicationError))
                return
            }
            
            // 2. response check
            if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
                completion(.failure(.badResponse))
                return
            }
            
            // 3. data check
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let quote = try JSONDecoder().decode(Quote.self, from: data)
                result = quote.content
                completion(.success(result))
            } catch {
                completion(.failure(.decodeFailed))
                print(error)
            }
            
        }.resume()
        return result
    }
    
    
    func getQuoteWithAsync() async -> String {
        do {
            // try 뒤에 await 써야 함
            // 애초에 data와 response를 반환함
            let (data, response) = try await URLSession.shared.data(from: url)
            
            
            if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
                return "응답 에러"
            }
            
            let quote = try JSONDecoder().decode(Quote.self, from: data)
            return quote.content
        } catch {
            return "Decode Error"
        }
    }
    
    func getQuotesArray1() async -> [String] {
        var quotes = [String]()

        for _ in 1...3 {
            quotes.append(await getQuoteWithAsync())
        }
        return quotes
    }
    
    func getQuotesArray2() async -> [String] {
        // 기다리지 않음 -> 순서가 보장되지 않으나 빠름
        // 리턴될 배열이 꽉차기를 기다릴 뿐
        async let firstQuote = "1️⃣" + getQuoteWithAsync()
        async let secondQuote = "2️⃣" + getQuoteWithAsync()
        async let thirdQuote = "3️⃣" + getQuoteWithAsync()
        return await [firstQuote, secondQuote, thirdQuote]
    }
    
    func getQuotesArray3() async -> [String] {
        // 무조건 순서대로 진행됨 (순서 보장되지만 시간 소요가 큼)
        // 95번~97번줄의 각 작업이 10초가 걸린다면 이 함수는 무조건 30초가 걸림
        let firstQuote = await "1️⃣" + getQuoteWithAsync()
        let secondQuote = await "2️⃣" + getQuoteWithAsync()
        let thirdQuote = await "3️⃣" + getQuoteWithAsync()
        return [firstQuote, secondQuote, thirdQuote]
    }
    
    // 내용을 알지 못하지만 async하게 쓰고 싶다!
    // 회사에 갔는데 기존 함수가 패키지에 쌓여 있거나, 너무 복잡해서 건드릴 수 없을 때 등
    // unsafe보다는 withCheckedContinuation를 쓸 것
    func continuationGetQuote() async -> String {
        return await withCheckedContinuation { continuation in
            getQuote { result in
                switch result {
                case .success(let quote):
                    // resume은 반드시 한 번만 호출해야 함
                    continuation.resume(returning: quote)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
