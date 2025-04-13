//
//  ContentView.swift
//  CWRUPlaces
//
//  Created by Amala on 4/1/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var locationsModel = LocationsModel()
    @State var fetchingLocations = false
    @State var places: [CWRUPlace]?
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.506145, longitude: -81.607000), span: .init(latitudeDelta: 0.03, longitudeDelta: 0.03))
    )
    
    func loadLocations() {
        fetchingLocations = true
        Task {
            await locationsModel.refresh()
            fetchingLocations = false
            
            if let locations = locationsModel.locations {
                places = locations.map { location in
                    CWRUPlace(user: location.user, label: location.label, coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng))
                }
            }
        }
    }

    
    var body: some View {
        
        VStack {
            if(fetchingLocations){
                Text("Fetching...")
            }
            else{
                
                Map(position: $position) {
                    if let places = places{
                        ForEach(places) { place in
                            Annotation("", coordinate: place.coordinate) {
                                VStack(spacing: 4) {
                                    Image(systemName: "mappin.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.pink)
                                    
                                    VStack(spacing: 2) {
                                        Text(place.user)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.white)
                                        Text(place.label)
                                            .font(.caption2)
                                            .foregroundColor(.white)
                                    }
                                    .padding(6)
                                    .background(Color.pink.opacity(0.8))
                                    .cornerRadius(8)
                                }
                            }
                            
                        }
                    }
                    
                    
                }
            }
            
        }
        .padding()
        .onAppear{
            Task {
                loadLocations()
            }
        }
    }
}

#Preview {
    ContentView()
}
