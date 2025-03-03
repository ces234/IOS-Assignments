//
//  DetailView.swift
//  Networking with Nasa
//
//  Created by Caroline Schafer on 3/3/25.
//

import SwiftUI

struct DetailView: View {
    var item: NASAResponse // Assuming item is of type NASAResponse
    
    var body: some View {
        VStack {
            Text(item.date)
                .font(.title)
            
            AsyncImage(url: URL(string: item.url)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
            }
            
            Text(item.explanation)
                .padding()
        }
        .navigationTitle("Detail")
    }
}
