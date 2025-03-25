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
    
    // Show location detail sheet
    @Published var sheetLocation: Location? = nil
    
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
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            currentLocation = location
            showListOfLocations = false
        }
    }
    
    func nextButtonPressed() {
        
        // Get the current index
        
        guard let currentIndex = locations.firstIndex(where: { $0 == currentLocation }) else {
            print("Could not get the current index in locations array. Should never happen!")
            return
        }
        
        // Check if the next index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next Location index is NOT valid
            // Return to the first location
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Get location of the next index
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
        
    }
    
}
