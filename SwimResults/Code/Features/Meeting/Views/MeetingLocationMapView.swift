//
//  MeetingLocationMapView.swift
//  SwimResults
//
//  Created by Konrad Weiß on 16.08.24.
//

import SwiftUI
import CoreLocation
import MapKit

struct MeetingLocationMapView: View {
    var name: String
    var location: CLLocationCoordinate2D
    
    var body: some View {
        Map {
            Marker(name, coordinate: location)
        }
        .navigationTitle("Wettkampfstätte")
    }
}

#Preview {
    MeetingLocationMapView(
        name: "Glück Auf Schwimmhalle",
        location: CLLocationCoordinate2D(latitude: 50.72720310, longitude: 12.49943780)
    )
}
