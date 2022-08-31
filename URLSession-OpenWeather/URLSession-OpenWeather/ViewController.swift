//
//  ViewController.swift
//  URLSession-OpenWeather
//
//  Created by 순진이 on 2022/08/31.
//

import UIKit

class ViewController: UIViewController {
   
    let temperatureLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        NetworkService.shared.fetch(urlString: URL.weather) { weatherInfo in
            self.temperatureLabel.text = String(weatherInfo.main.temp)
        }
    }
}

//MARK: -UI
extension ViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    
    final private func setAttributes() {
        temperatureLabel.text = "0"
    }

    final private func setConstraints() {
        view.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
