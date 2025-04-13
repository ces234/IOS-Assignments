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
    
    //hardcoded values for user id and pass (student id)
    @State var newLocation:NewLocation = NewLocation(user: "zmg12", pass: "3520464", lat: 0.0, lng: 0.0, label: "")
    
    @State private var currentUserLocation: CLLocationCoordinate2D?
    @State private var isPostingLocation = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // Timer for fetching locations
    @State private var locationTimer: Timer?
    @State private var lastRefreshTime: Date = Date()
    
    private let locationModel = LocationModel()
    private let locationManager = LocationManager.shared
    
    private let characterLimit = 25
    
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
    
    func startLocationTimer() {
        // Cancel any existing timer first
        locationTimer?.invalidate()
        
        // Create a new timer that fires every 30 seconds
        locationTimer = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { _ in
            loadLocations()
        }
    }
    
    func tagCurrentLocation() {
        // Make sure we have the most recent location
        guard let latestLocation = locationModel.locations.last else {
            showAlert(message: "Unable to get your location. Please ensure location services are enabled.")
            return
        }
        
        //enforce character limit
        if newLocation.label.count > characterLimit {
            let newText = String(newLocation.label.prefix(characterLimit))
            newLocation.label = newText
        }
        
        let userCoordinate = latestLocation.coordinate
        currentUserLocation = userCoordinate
        
        // update the newLocation object with coordinates
        newLocation.lat = userCoordinate.latitude
        newLocation.lng = userCoordinate.longitude
        
        // Post the location data
        isPostingLocation = true
        
        Task {
            let response = await locationsModel.postLocation(newLocation: newLocation)
            if response {
                showAlert(message: "Location tagged successfully!")
                newLocation.label = ""
                
                // refresh the locations list
                loadLocations()
            } else {
                showAlert(message: "Failed to post location. Please try again.")
            }
            
            isPostingLocation = false
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
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
            HStack {
                TextField("Add new location", text: $newLocation.label)
                Button("Tag Location") {
                    //TODO: Add action to post new location
                    //get user's current location and set in newLocation
                    tagCurrentLocation()
                }.disabled(isPostingLocation || newLocation.label.isEmpty)
            }.padding()
            
        }
        .onAppear{
            locationManager.delegate = locationModel
            locationManager.requestPermission()
            locationManager.startUpdating()
            
            loadLocations()
            startLocationTimer()
        }
        .onDisappear {
            // Clean up timer when view disappears
            locationTimer?.invalidate()
            locationTimer = nil
        }
        .alert(alertMessage, isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    ContentView()
}
