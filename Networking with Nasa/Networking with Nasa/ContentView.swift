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

            for _ in 0..<5 {
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

                print(dateString) // Debugging: Check if dates are updating correctly
            }
            
            fetchingPastImages = false
        }
    }

    
    
    
    var body: some View {
            VStack {
                Text("Today's NASA Image")
                    .font(.title)
                
                AsyncImage(url:nasaModel.imageURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode:.fit)
                } placeholder: {
                    if(fetchingNasaResponse){
                        ProgressView()
                    }
                }
                
                if let currentDate = nasaModel.getDate() {
                    Text(currentDate)
                }
                
                
                
                NavigationStack {
                    List(pastImages, id: \.date) { image in
                        NavigationLink(destination: DetailView(item: image)) { 
                            Text(image.date)
                        }
                    }
                }
                            
                
                Spacer()
                Button("Get Nasa Photo!"){
                    fetchingNasaResponse = true
                    
                }
                .disabled(fetchingNasaResponse)
                

            }
            .padding()
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
