//
//  SwiftUIMapAppApp.swift
//  SwiftUIMapApp
//
//  Created by Heimdal Data on 07.03.2025.
//

import SwiftUI

@main
struct SwiftUIMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LocationsView()
                .environmentObject(vm)
        }
    }
}
