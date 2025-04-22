import SwiftUI
import SwiftData

struct HomePageView: View {
    var recentCategories = ["Entertainment", "Science: Computers", "Celebrities"]
    var usersTopCategories = ["Sports", "Entertainment: Music", "Animals"]
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var session: SessionManager
    
    @Query var users: [User]
    
    @State private var shouldNavigate = false
    
    var userRank: Int? {
        guard let currentUser = session.currentUser else { return nil }
        let sortedUsers = users.sorted { $0.dailyPoints > $1.dailyPoints }

        // Find index (0-based, so add 1 for rank)
        if let index = sortedUsers.firstIndex(where: { $0.id == currentUser.id }) {
            return index + 1
        } else {
            return nil
        }
    }
    
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
    
    
    @State var isCategorySelected = false
    @State var selectedCategoryNumber: Int?
    @State var selectedDifficulty: Difficulty = .easy
    
    var body: some View {
        Group {
            if let currUser = session.currentUser {
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .leading) {
                            
                            VStack(alignment: .leading) {
                                Text("Welcome back,")
                                    .font(.poppins(fontStyle: .title2, fontWeight: .medium))
                                    .padding(0)
                                
                                Text("\(currUser.firstName)")
                                    .font(.poppins(fontStyle: .largeTitle, fontWeight: .heavy))
                                    .foregroundStyle(.darkBlue)
                                    .padding(0)
                                
                                Rectangle()
                                    .frame(width: 280, height: 2.5)
                                    .padding(.vertical, -10)
                            }
                            .padding()
                            
                            VStack {
                                HStack {
                                    Spacer()

                                    HStack {
                                        Image(systemName: "trophy")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.darkBlue)
                                            .padding(.trailing, 5)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Rank:")
                                                .font(.poppins(fontStyle: .headline, fontWeight: .bold))
                                                .foregroundColor(.black)
                                            
                                            if let rank = userRank {
                                                Text("\(rank) / \(users.count)")
                                                    .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                                                    .foregroundColor(.black)
                                            } else {
                                                Text("0 / 0")
                                                    .font(.poppins(fontStyle: .body, fontWeight: .regular))
                                                    .foregroundColor(.black)
                                            }
                                        }
                                    }
                                    .padding()
                                    
                                    HStack {
                                        Image(systemName: "star.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 48, height: 48)
                                            .foregroundColor(.darkBlue)
                                            .padding(.trailing, 5)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Points:")
                                                .font(.poppins(fontStyle: .headline, fontWeight: .bold))
                                                .foregroundColor(.black)
                                            
                                            Text("\(currUser.dailyPoints)")
                                                .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 25)
                                    
                                    Spacer()
                                }
                                .background(.lightGray)
                                .clipShape(.rect(cornerRadius: 15))
                                .padding(.top, -15)
                                .padding()
                            }
                            
                            VStack(alignment: .leading) {
                                Text("History")
                                    .font(.poppins(fontStyle: .title2, fontWeight: .bold))
                                    .padding(.bottom, 0)
                                    .foregroundStyle(.darkBlue)
                                
                                List {
                                    HStack {
                                        Text("Daily Streak:")
                                            .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                                        Text("\(currUser.dailyStreak)")
                                            .font(.poppins(fontStyle: .body, fontWeight: .medium))
                                    }
                                    HStack {
                                        Text("Daily Points Record:")
                                            .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                                        Text("\(currUser.dailyPoints)")
                                            .font(.poppins(fontStyle: .body, fontWeight: .medium))
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Top Categories")
                                            .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 10) {
                                                ForEach(currUser.topCategories, id: \.self) { category in
                                                    Text(category)
                                                        .font(.poppins(fontStyle: .callout, fontWeight: .regular))
                                                        .foregroundStyle(.black)
                                                        .padding(10)
                                                        .background(.lightGray)
                                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                                }
                                                
                                                if currUser.topCategories.count == 0 {
                                                    Text("No categories played yet!")
                                                        .font(.poppins(fontStyle: .body, fontWeight: .regular))
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                .padding(.top, -10)
                                .listStyle(.inset)
                                .scrollDisabled(true)
                                .frame(height: 200)
                            }
                            .padding(.horizontal)
                            
                            VStack(alignment: .leading) {
                                Text("Recent Categories")
                                    .font(.poppins(fontStyle: .title2, fontWeight: .bold))
                                    .foregroundStyle(.darkBlue)
                                
                                VStack(spacing: 8) {
                                    
                                    if currUser.topCategories.count == 0 {
                                        Text("No categories played yet!")
                                            .font(.poppins(fontStyle: .body, fontWeight: .regular))
                                    }
                                    
                                    ForEach(currUser.recentCategories, id: \.self) { category in
                                        CategoryPlayRow(category: category)
                                            .onTapGesture {
                                                if let categoryNumber = categories.first(where: { $0.name == category })?.number {
                                                    selectedCategoryNumber = categoryNumber
                                                    isCategorySelected = true
                                                } else {
                                                    print("Category number not found for: \(category)")
                                                }
                                            }
                                    }

                                }
                            }
                            .padding(.horizontal)
                            
                            VStack(alignment: .leading) {
                                Text("Settings")
                                    .font(.poppins(fontStyle: .title2, fontWeight: .bold))
                                    .foregroundStyle(.darkBlue)
                                
                                Button(action: {
                                    session.logout()
                                    shouldNavigate = true
                                }) {
                                    HStack {
                                        Image(systemName: "rectangle.portrait.and.arrow.right")
                                        Text("Log Out")
                                            .font(.poppins(fontStyle: .body, fontWeight: .semibold))
                                    }
                                    .foregroundColor(.red)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                NavigationLink(destination: LandingPageView(), isActive: $shouldNavigate) {
                                    EmptyView()
                                }
                            }.padding()
                            
                            Spacer()
                        }
                    }
                }
                
                .fullScreenCover(isPresented: $isCategorySelected) {
                    StartView(
                        selectedCategoryNumber: $selectedCategoryNumber,
                        selectedDifficulty: $selectedDifficulty
                    )
                }
                .padding()
            } else {
                Text("Loading...")
                    .font(.title)
                    .padding()
            }
        }
    }
}

#Preview {
    HomePageView()
        .environmentObject({
            let mockSession = SessionManager()
            mockSession.currentUser = User(
                firstName: "Caroline",
                lastName: "Caroline",
                username: "Schafer",
                password: "1234"
            )
            mockSession.currentUser?.categoryPlayCounts = ["Sports": 10, "Geography": 20, "Entertaiment: Books": 15]
            mockSession.currentUser?.recentCategories = ["Sports", "Science & Nature", "Geography"]
            return mockSession
        }())
}
