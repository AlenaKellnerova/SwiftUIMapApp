//
//  LocationPreviewView.swift
//  SwiftUIMapApp
//
//  Created by Alena Kellnerova on 12.03.2025.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var locationsViewModel : LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                imageSection
                locationNameSection
            }
            
            VStack(spacing: 12) {
      
                learnMoreButton
                nextButton
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
                .offset(y: 65)
//                .clipped()
                .cornerRadius(10)
        )
    }
}

#Preview {
    ZStack {
        Color.blue.opacity(0.8).ignoresSafeArea()
        
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationPreviewView {
    
    private var imageSection: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(.white)
        .cornerRadius(10)
    }
    
    private var locationNameSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            locationsViewModel.sheetLocation = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            locationsViewModel.nextButtonPressed()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125, height: 30)
        }
        .buttonStyle(.bordered)
    }
}
