//
//  NASAModel.swift
//  Networking with Nasa
//
//  Created by Caroline Schafer on 3/1/25.
//

import Foundation

class NASAModel {
    var nasaImage: NASAResponse?
    var imageURL:URL?
    var refreshDate:Date?
    
    let apiKey = "2uzM8sOZSBuJ2qTdUspVQ8HqWN9XqxM0Te0LMAWQ"
    

    func refresh(date: String? = nil) async {
        self.nasaImage = await getNasaDetails(date: date)
    }

    
    
    func getDate() -> String? {
        guard let currentDate = nasaImage?.date else { return nil }
        return currentDate
    }
    
    func toString() -> String? {
        return nasaImage?.date
    }
    
    private func getNasaDetails (date: String? = nil) async -> NASAResponse? {
        var urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
        if let date = date {
            urlString += "&date=\(date)"
        }
        let session = URLSession(configuration: .default)
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                do{
                    let (data, _) = try await session.data(for: request)
                    let decoder = JSONDecoder()
                    let nasaImage = try decoder.decode(NASAResponse.self, from: data)
                    self.imageURL = URL(string:nasaImage.url)
                    self.refreshDate = Date()
                    return nasaImage
                }
                catch {
                    
                }
            
        }
        
        return nil
    }
    
    
}
