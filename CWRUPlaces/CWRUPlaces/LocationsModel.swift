//
//  LocationsModel.swift
//  CWRUPlaces
//
//  Created by Caroline Schafer on 4/13/25.
//

import Foundation

struct NewLocation : Codable {
    let user:String
    let pass:String
    var lat:Double
    var lng:Double
    var label:String
}

@Observable
class LocationsModel {
    var locationResponse: LocationResponse?
    var locations: [Location]?
    let urlString = "https://caslab.case.edu/392/map.php"
    
    func refresh() async {
        self.locationResponse = await getLocationsDetails()
        self.locations = locationResponse?.locations
    }
    
    func getLocationsDetails () async -> LocationResponse? {
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
    
    func postLocation(newLocation:NewLocation) async -> Bool {
        //to enforce character limit
        
        
        let session = URLSession(configuration: .default)
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do{
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(newLocation)
                request.httpBody = jsonData
                
                let (_, response) = try await session.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    throw URLError(.badServerResponse)
                }
                
                return true
                
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        return false
    }
    
    
}

