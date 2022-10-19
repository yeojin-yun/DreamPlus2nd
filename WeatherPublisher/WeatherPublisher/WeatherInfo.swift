//
//  WeatherInfo.swift
//  WeatherPublisher
//
//  Created by 순진이 on 2022/10/19.
//

import Foundation

struct WeatherInfo: Decodable {
    let main: Main
    
    struct Main: Decodable {
        let temp: Double
    }
}
