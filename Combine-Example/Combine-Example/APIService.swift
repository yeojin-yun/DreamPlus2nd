//
//  APIService.swift
//  Combine-Example
//
//  Created by 순진이 on 2022/10/17.
//

import Foundation
struct APIService {
    func getQuote(completion: @escaping (Result<Quote, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: URL.quote) { data, response, error in
            if let error = error {
                completion(.failure(.communicationError))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200..<300).contains(response.statusCode) {
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
                completion(.failure(.decodedError))
            }
        }.resume()
    }
    
    func getQuotes() async throws -> Quote {
        let (data, response) = try await URLSession.shared.data(from: URL.quote)
        print(response)
        return try JSONDecoder().decode(Quote.self, from: data)
    }
}
