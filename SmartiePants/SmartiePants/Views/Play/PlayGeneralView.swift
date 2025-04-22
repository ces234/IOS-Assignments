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
    
    let categories = [
        (name: "General Knowledge", number: 9),
        (name: "Books", number: 10),
        (name: "Film", number: 11),
        (name: "Music", number: 12),
        (name: "Musical Theater", number: 13),
        (name: "Television", number: 14),
        (name: "Video Games", number: 15),
        (name: "Board Games", number: 16),
        (name: "Science & Nature", number: 17),
        (name: "Computers", number: 18),
        (name: "Mathematics", number: 19),
        (name: "Mythology", number: 20),
        (name: "Sports", number: 21),
        (name: "Geography", number: 22),
        (name: "History", number: 23),
        (name: "Politics", number: 24),
        (name: "Art", number: 25),
        (name: "Celebrities", number: 26),
        (name: "Animals", number: 27),
        (name: "Vehicles", number: 28),
        (name: "Comics", number: 29),
        (name: "Gadgets", number: 30),
        (name: "Japanese Anime & Manga", number: 31),
        (name: "Cartoon & Animations", number: 32)
    ]
    
    @State var selectedDifficulty:Difficulty = .easy
    @State var isCategorySelected = false
    @State var selectedCategoryNumber: Int?

    var body: some View {
        NavigationView {
            ScrollView {
                Heading(headingText: "Play")
                
                VStack(alignment: .leading) {
                    Text("All Categories")
                        .font(.poppins(fontStyle: .title, fontWeight: .bold))
                        .foregroundStyle(.darkBlue)
                        .padding(.top, -10)
                    
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(Difficulty.allCases) { difficulty in
                            Text(difficulty.rawValue.capitalized)
                                .font(.poppins(fontStyle: .callout, fontWeight: .medium))
                                .foregroundStyle(.darkBlue)
                        }
                    }
                    .font(.poppins(fontStyle: .body, fontWeight: .medium))
                    .pickerStyle(.palette)
                        .padding(.bottom)
                    
                    VStack(spacing: 8) { 
                        ForEach(categories, id: \.number) { category in
                            CategoryPlayRow(category: category.name)
                                .onTapGesture {
                                    selectedCategoryNumber = category.number
                                    print("selected category number: ", selectedCategoryNumber ?? 213)
                                    isCategorySelected = true
                                }
                        }

                    }
                    
                }.padding()
                
            }
        }.padding()
        .fullScreenCover(isPresented: $isCategorySelected) {
            StartView(selectedCategoryNumber: $selectedCategoryNumber, selectedDifficulty: $selectedDifficulty)
        }
    }
}

#Preview {
    PlayGeneralView()
}
