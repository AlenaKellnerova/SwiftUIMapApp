//
//  Location.swift
//  SwiftUIMapApp
//
//  Created by Alena Kellnerova on 07.03.2025.
//

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // Identifiable
    var id: String {
        // name = "Colloseum"
        // cityName = "Rome"
        // id = ColloseumRome
        name + cityName
    }
    
    // Equatable
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    
}
