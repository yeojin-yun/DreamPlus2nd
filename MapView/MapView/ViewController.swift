//
//  ViewController.swift
//  MapView
//
//  Created by 순진이 on 2022/09/26.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
//    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let mapButton = UIButton(type: .system)
    
    // 이 방법도 가능
//    override func loadView() {
//        super.loadView()
//        view = mapView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        requestLocationAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation() // 지속적인 위치 업데이트
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 지도의 정확성
        
        mapView.delegate = self
//        mapView.preferredConfiguration = MKImageryMapConfiguration
//        mapView.preferredConfiguration = MKHybridMapConfiguration
        fetchLocationsOnMap(locations: Stadium.stadium)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        print(#function)
        centerLocation(location: Stadium.stadium.last!)
    }
}


extension ViewController {
    private func requestLocationAuthorization() {
        let status = locationManager.authorizationStatus
        
        // 권한 요청
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            mapView.showsUserLocation = true
            //mapView.userTrackingMode = .follow //유저 위치 계속 따라가도록 - 이건 시뮬레이터의 Feature - Location에서 움직이는 설정으로 바꿔야 함
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        case .restricted:
            break
        @unknown default:
            // 추가된 새로운 케이스는 나중에 처리할게!! 나중에 추가된 케이스는 여기로 빠지게 됨
            break
        }
    }
    
    // 앱 실행하자마자 내 위치에서 시작하기
    private func centerUserLocation(locations: [CLLocation]) {
        // 가장 마지막에 추가된 값
        guard let coordination = locations.last?.coordinate else { return }
        
        let center = CLLocationCoordinate2D(latitude: coordination.latitude, longitude: coordination.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // 지도에서 얼마나 zoom-in 할 것인가
        
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
//    private func fetchLocationsOnMap(stadiums: [Stadium]) {
//        for stadium in stadiums {
//            let annotation = MKPointAnnotation()
//            annotation.title = stadium.name
//            annotation.coordinate = CLLocationCoordinate2D(latitude: stadium.latitude, longitude: stadium.longitude)
//            mapView.addAnnotation(annotation)
//        }
//    }
    
    private func fetchLocationsOnMap(locations: [LocationRepresentable]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func centerLocation(location: LocationRepresentable) {
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 반드시 실패 케이스도 적어줘야 함
        print(locations)
        centerUserLocation(locations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocationAuthorization()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        방향 전환이 중요할 때
//    }
}

//mapView.delegate = self
extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        if annotaionView == nil {
            annotaionView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            
        } else {
            annotaionView?.annotation = annotation
        }
        annotaionView?.image = UIImage(named: "peanut")
        annotaionView?.frame.size = CGSize(width: 30, height: 30)
        annotaionView?.canShowCallout = true // 이름이 뜸
        annotaionView?.clusteringIdentifier = "stadium" //cluster 기능함
//        annotaionView?.displayPriority = .defaultHigh // 표시의 우선순위
//        annotaionView?.rightCalloutAccessoryView
//        annotaionView?.annotation?.subtitle //서브타이틀
        return annotaionView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title) // 사용자가 뭘 클릭했는지 알 수 있음
    }
}

extension ViewController {
    private func setUI() {
        mapButton.setTitle("Map Button", for: .normal)
        mapButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        [mapView, mapButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60)
        ])
    }
}
