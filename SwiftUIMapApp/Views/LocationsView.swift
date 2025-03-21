//
//  LocationsView.swift
//  SwiftUIMapApp
//
//  Created by Alena Kellnerova on 07.03.2025.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {

        ZStack {
            mapLayer
            .ignoresSafeArea()
            
            VStack {
                header
                    .onTapGesture {
                            vm.toggleListOfLocations()
                    }
                
                Spacer()
                
                locationsPreviewStack
            }
            
        }
    }
}

extension LocationsView {
    
    private var header: some View {
        VStack {
            // Title
            Text(vm.currentLocation.name + ", " + vm.currentLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .animation(.none, value: vm.currentLocation)
                .overlay(alignment: .leading) {
                    Image(systemName : "arrow.down")
                        .font(.headline)
                        .padding()
                        .rotationEffect(Angle(degrees: vm.showListOfLocations ? 180 : 0))
                }
            // Expandable list of locations
            if (vm.showListOfLocations) {
                LocationsListView()
            }
        }
        .background(.ultraThickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 15)
        .padding()
    }
    
    private var mapLayer: some View {
        
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.currentLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.currentLocation == location {
                LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.2), radius: 20)
                        .padding()
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
