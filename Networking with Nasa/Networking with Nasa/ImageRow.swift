//
//  ImageRow.swift
//  Networking with Nasa
//
//  Created by Amala on 3/5/25.
//


import SwiftUI

struct ImageRow: View {
    
    var item: NASAResponse
    
    func checkDate(dateString:String) -> Bool {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";

        let todayDate = Date();
        let todayString = dateFormatter.string(from: todayDate)
        
        return dateString == todayString
    }
    
    var body: some View {
        
        let isToday = checkDate(dateString: item.date)
        
        HStack {
            VStack {
                
                HStack {
                    Text(item.title)
                        .font(.headline)
                    Spacer()
                }
                
                HStack {
                    Text(isToday ? "Today" : item.date)
                        .font(.caption)
                    Spacer()
                }
                
                HStack {
                    Text(item.explanation.prefix(50) + "...more")
                        .foregroundStyle(.secondary)
                    Spacer()
                }
            }
            
            Spacer()
            
            HStack {
                AsyncImage(url: URL(string: item.url)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } placeholder: {
                    ProgressView()
                }
            }
        }
//        .background(
//            isToday ? .gray : .clear
//        )
    }
}

#Preview {
    ImageRow(item: NASAResponse(date: "2025-03-05", explanation: "On the right, dressed in blue, is the Pleiades.  Also known as the Seven Sisters and M45, the Pleiades is one of the brightest and most easily visible open clusters on the sky. The Pleiades contains over 3,000 stars, is about 400 light years away, and only 13 light years across. Surrounding the stars is a spectacular blue reflection nebula made of fine dust.  A common legend is that one of the brighter stars faded since the cluster was named. On the left, shining in red, is the California Nebula.  Named for its shape, the California Nebula is much dimmer and hence harder to see than the Pleiades.  Also known as NGC 1499, this mass of red glowing hydrogen gas is about 1,500 light years away. Although about 25 full moons could fit between them, the featured wide angle, deep field image composite has captured them both.  A careful inspection of the deep image will also reveal the star forming region IC 348 and the molecular cloud LBN 777 (the Baby Eagle Nebula).    Jump Around the Universe: Random APOD Generator", hdurl: "https://apod.nasa.gov/apod/image/2503/California2Pleiades_Anderson_9953.jpg", media_type: "image", service_version: "v1", title: "Seven Sisters versus California", url: "https://apod.nasa.gov/apod/image/2503/California2Pleiades_Anderson_960.jpg"))
}
