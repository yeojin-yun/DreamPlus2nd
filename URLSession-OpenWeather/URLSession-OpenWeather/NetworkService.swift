//
//  NetworkService.swift
//  URLSession-OpenWeather
//
//  Created by 순진이 on 2022/08/31.
//

import Foundation

// singleton으로 사용
class NetworkService {

    static let shared = NetworkService()

    
    func fetch(urlString: String, completion: @escaping (WeatherInfo)-> Void) {
        URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            // 1. error가 있다면
            guard error == nil else { fatalError() }
            
            // 2. response가 있으면서 응답 코드가 200 ~ 400 사이일 때 (응답이 성공했을 때)
            guard let response = response as? HTTPURLResponse, (200..<400).contains(response.statusCode) else { fatalError() }

            // 3. data가 있다면
            guard let data = data else { return }
            
            do {
                let decodedData = try JSONDecoder().decode(WeatherInfo.self, from: data)
                
                DispatchQueue.main.async {
                    // UI에 대한 작업이기 때문에 main thread에서 해줘야 함.
                    // main에서는 항상 async만 써야 함 (sync X)
                    print(Thread.isMainThread) // true
                    completion(decodedData)
                }
                
            } catch {
                fatalError()
            }
        }.resume()
    }
    
    private init() {}
}

