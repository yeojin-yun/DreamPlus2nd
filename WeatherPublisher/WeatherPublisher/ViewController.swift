//
//  ViewController.swift
//  WeatherPublisher
//
//  Created by 순진이 on 2022/10/19.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldNotification()
        WeatherService().getWeather(city: "seoul")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Finished")
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }, receiveValue: { weatherInfo in
                print(weatherInfo.main)
            })
            .store(in: &cancellables)
    }
    
    //NotificationCenter
    func textFieldNotification() {
        //cityTextField에 대한 pulisher 만들기
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: cityTextField)
            .compactMap { notification in
                return (notification.object as! UITextField).text//.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            }
            .sink {
                print($0)
            }
            .store(in: &cancellables)
    }
}


