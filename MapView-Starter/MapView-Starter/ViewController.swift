//
//  ViewController.swift
//  MapView-Starter
//
//  Created by 순진이 on 2022/09/27.
//


import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let mapButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        requestLocationAuthorization()
        locationManager.delegate = self
        setAnnotationOnMap(locations: Stadium.stadium)
    }

    @objc func mapButtonTapped(_ sender: UIButton) {
        centerLocation(location: Stadium.stadium.last!)
    }
}

extension ViewController {
    private func requestLocationAuthorization() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            // 위치 권한이 허용된 경우
            print("")
            locationManager.requestLocation()
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .follow
        @unknown default:
            // 추가된 새로운 케이스는 나중에 처리할게!! 나중에 추가된 케이스는 여기로 빠지게 됨
            break
        }
    }
    
    private func setAnnotationOnMap(locations: [LocationRepresentable]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
 }

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        centerUserLocation(locations: locations)
        print(#line ,locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        requestLocationAuthorization()
    }
}

extension ViewController {
    // 해당 위치를 센터로 잡는 함수
    private func centerUserLocation(locations: [CLLocation]) {
        // 가장 마지막에 추가된 값을 coordination에 바인딩
        guard let coordination = locations.last?.coordinate else { return }
        
        let center = CLLocationCoordinate2D(latitude: coordination.latitude, longitude: coordination.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    private func centerLocation(location: LocationRepresentable) {
        print("---",location)
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension ViewController {
    private func setUI() {
        mapButton.setTitle("Map Button", for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonTapped(_:)), for: .touchUpInside)
        
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
