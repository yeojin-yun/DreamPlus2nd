//
//  WeatherService.swift
//  WeatherPublisher
//
//  Created by 순진이 on 2022/10/19.
//

import Foundation
import Combine

struct WeatherService {

    func getWeather(city: String) -> AnyPublisher<WeatherInfo, Error> {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=cc67530774268e4f6e4250794df2dca2")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherInfo.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
