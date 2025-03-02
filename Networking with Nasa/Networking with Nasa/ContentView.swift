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
    
    func loadNasaPicture(date: String? = nil) {
        fetchingNasaResponse = true
        Task {
            await nasaModel.refresh(date: date)
            fetchingNasaResponse = false
        }
    }
    
    func isToday() -> Bool {
        guard let nasaDate = nasaModel.getDate() else { return false }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let todayString = dateFormatter.string(from: Date()) // Today's date
        
        return nasaDate == todayString // Compare
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
            
            HStack {
                Button("Previous") {
                    if let previousDate = nasaModel.getPreviousDate() {
                        loadNasaPicture(date: previousDate)
                    }
                }
                .disabled(fetchingNasaResponse)
                
                Button("Next") {
                    if let nextDate = nasaModel.getNextDate() {
                        loadNasaPicture(date: nextDate)
                    }
                }
                .disabled(fetchingNasaResponse)
                .disabled(isToday())
            }
                        
            
            Spacer()
            Button("Get Nasa Photo!"){
                fetchingNasaResponse = true
                
            }
            .disabled(fetchingNasaResponse)
        }
        .padding()
        .onAppear {
            loadNasaPicture()
        }
    }
}

#Preview {
    ContentView()
}
