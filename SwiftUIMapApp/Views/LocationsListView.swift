//
//  LocationsListView.swift
//  SwiftUIMapApp
//
//  Created by Alena Kellnerova on 11.03.2025.
//

import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                    listItem(for: location)
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
                .onTapGesture {
                    DispatchQueue.main.async {
                        vm.showNextLocation(location: location) 
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}

extension LocationsListView {
    
    private func listItem(for location: Location) -> some View {
        HStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
                VStack (alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                    Text(location.cityName)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
