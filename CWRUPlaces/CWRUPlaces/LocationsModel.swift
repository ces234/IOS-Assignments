//
//  LocationsModel.swift
//  CWRUPlaces
//
//  Created by Caroline Schafer on 4/13/25.
//

import Foundation

@Observable
class LocationsModel {
    var locationResponse: LocationResponse?
    var locations: [Location]?
    
    func refresh() async {
        self.locationResponse = await getLocationsDetails()
        self.locations = locationResponse?.locations
    }
    
    func getLocationsDetails () async -> LocationResponse? {
        
        var urlString = "https://caslab.case.edu/392/map.php"
        let session = URLSession(configuration: .default)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            do{
                let (data, _) = try await session.data(for: request)
                let decoder = JSONDecoder()
                let locationResponse = try decoder.decode(LocationResponse.self, from: data)
                
                return locationResponse
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        return nil
        
    }
    
    
}

