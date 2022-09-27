//
//  Stadium.swift
//  MapView-Starter
//
//  Created by 순진이 on 2022/09/27.
//

import CoreLocation
import Foundation

protocol LocationRepresentable {
    var name: String { get set }
    var latitude: CLLocationDegrees { get set }
    var longitude: CLLocationDegrees { get set }
}

struct Stadium: LocationRepresentable {
    static let stadium = [
        Stadium(name: "Emirates Stadium", latitude: 51.5549,longitude: -0.108436),
        Stadium(name: "Stanford Bridge", latitude: 51.4816,longitude: -0.191034),
        Stadium(name: "White Hard Lane", latitude: 51.6033,longitude: -0.065684),
        Stadium(name: "Olympic Stadium", latitude: 51.5383,longitude: -0.016587),
        Stadium(name: "Old Tranfford", latitude: 53.4631,longitude: -2.29139),
        Stadium(name: "Anfield", latitude: 53.4308, longitude: -2.96096)
    ]
    
    var name: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}
