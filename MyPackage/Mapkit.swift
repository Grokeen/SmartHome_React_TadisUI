//
//  Mapkit.swift
//  
//
//  Created by 김용록 on 2/16/25.
//

import SwiftUI
import MapKit

struct GameMapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // 샌프란시스코 좌표 예제
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    var body: some View {
        Map(coordinateRegion: $region)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView: View {
    var body: some View {
        GameMapView()
    }
}

@main
struct GameMapNavigationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
