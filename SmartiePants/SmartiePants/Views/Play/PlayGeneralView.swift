//
//  PlayGeneralView.swift
//  SmartiePants
//
//  Created by Zoe Goldberg on 3/28/25.
//

import SwiftUI

enum Difficulty: String, CaseIterable, Identifiable {
    case easy
    case medium
    case hard
    var id: Self { self }
}

struct PlayGeneralView: View {
    /* TODO: Pull from data (or hard code values?) */
    var allCategories = ["Entertainment: Books", "Science: Computers", "Celebrities", "Entertainment: Music", "Science and Nature", "Geography", "Animals", "Entertainment: TV", "Sports"]
    
    @State var selectedDifficulty:Difficulty = .easy
    @State var isCategorySelected = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                Heading(headingText: "Play")
                
                VStack(alignment: .leading) {
                    Text("All Categories")
                        .font(.title)
                        .bold()
                    
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(Difficulty.allCases) { difficulty in
                            Text(difficulty.rawValue.capitalized)
                        }
                    }.pickerStyle(.palette)
                        .padding(.bottom)
                    
                    VStack(spacing: 8) { 
                        ForEach(allCategories, id: \.self) { category in
                            //TODO: Formatting when navigating to Start page is weird
                                CategoryPlayRow(category: category)
                                .onTapGesture {
                                    isCategorySelected.toggle()
                                }
                        }
                    }
                    
                }.padding()
                
            }
        }.padding()
        .fullScreenCover(isPresented: $isCategorySelected) {
            StartView()
        }
    }
}

#Preview {
    PlayGeneralView()
}
