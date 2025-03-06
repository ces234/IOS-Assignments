//
//  ContentView.swift
//  Networking with Nasa
//
//  Created by Caroline Schafer on 2/28/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var nasaModel = NASAModel()
    @State var fetchingNasaResponse = false
    @State var fetchingPastImages = false
    @State var pastImages: [NASAResponse] = []
    
    func loadNasaPicture(date: String? = nil) {
        fetchingNasaResponse = true
        Task {
            await nasaModel.refresh(date: date)
            fetchingNasaResponse = false
        }
    }
    
    func getPreviousDate(currentDate: String) -> String? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let currentDate = dateFormatter.date(from: currentDate),
               let previous = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) {
                return dateFormatter.string(from: previous)
            }
            return nil
        }
    
    func loadPastImages() {
        fetchingPastImages = true
        Task {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var dateString = dateFormatter.string(from: Date()) // Start with today's date

            for _ in 0..<6 {
                let currentDate = dateString
                await nasaModel.refresh(date: currentDate)
                
                if let currentImage = nasaModel.nasaImage, currentImage.media_type == "image" {
                    self.pastImages.append(currentImage)
                }
                
                if let newDate = getPreviousDate(currentDate: currentDate) {
                    dateString = newDate // Move to the previous day
                } else {
                    break // Stop loop if we can't get a valid previous date
                }
            }
            
            fetchingPastImages = false
        }
    }

    var body: some View {
            VStack {
                Text("NASA APOD")
                    .font(.title).bold()
                                
                NavigationStack {
                    List(pastImages, id: \.date) { image in
                        NavigationLink(destination: DetailView(item: image)) {
                            ImageRow(item: image)
                        }
                    }
                }
                .listStyle(.plain)
                Spacer()
            }
            .onAppear {
                Task{
                    loadNasaPicture()
                }
                loadPastImages()
            }
    }
        
}

#Preview {
    ContentView()
}
