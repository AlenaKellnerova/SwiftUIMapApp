//
//  LocationsViewModel.swift
//  SwiftUIMapApp
//
//  Created by Alena Kellnerova on 07.03.2025.
//

import Foundation
import MapKit
import SwiftUI


class LocationsViewModel: ObservableObject {
    
    // all loaded locations
    @Published var locations: [Location]
    
    // current location on the map
    @Published var currentLocation: Location {
        didSet {
            updateMapRegion(location: currentLocation)
        }
    }
    
    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // current map region (MKCoordinateRegion)
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    // Show list of locations
    @Published var showListOfLocations: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.currentLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: span)
        }
    }
    
    func toggleListOfLocations() {
        withAnimation(.easeInOut) {
            showListOfLocations.toggle()
        }
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut) {
            toggleListOfLocations()
            currentLocation = location
        }
    }
    
}
