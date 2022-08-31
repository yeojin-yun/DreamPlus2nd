//
//  WeatherInfo.swift
//  URLSession-OpenWeather
//
//  Created by 순진이 on 2022/08/31.
//

import Foundation

struct WeatherInfo: Codable {
    let main: Main
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
    }
    
    struct Weather: Codable {
        let main: String
    }
}
