//
//  SwiftUIView.swift
//  
//
//  Created by 김용록 on 2/16/25.
//

import SwiftUI
import MapKit

struct SwiftUIView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    var body: some View {
        GameMapView()
    }
}


#Preview {
    SwiftUIView()
}
