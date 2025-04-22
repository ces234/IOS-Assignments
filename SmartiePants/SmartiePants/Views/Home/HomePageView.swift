import SwiftUI
import SwiftData

struct HomePageView: View {
    /* TODO: Pull these variables from saved data */
    var recentCategories = ["Entertainment", "Science: Computers", "Celebrities"]
    var usersTopCategories = ["Sports", "Entertainment: Music", "Animals"]
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var session: SessionManager
    
    @Query var users: [User]
    
    @State var isCategorySelected = false
    @State var selectedCategoryNumber: Int?
    @State var selectedDifficulty: Difficulty = .easy
    
    var body: some View {
        Group {
            if let currUser = session.currentUser {
                NavigationStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            VStack(alignment: .leading) {
                                Text("Welcome back,")
                                    .font(.title2)
                                
                                Text("\(currUser.firstName)!")
                                    .font(.title)
                                    .bold()
                                
                                Rectangle()
                                    .frame(width: 250, height: 3)
                            }
                            
                            VStack {
                                HStack {
                                    HStack {
                                        Image(systemName: "trophy")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(.white)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Rank:")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                            Text("1 / \(users.count)")
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .padding()
                                    
                                    HStack {
                                        Image(systemName: "star.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 48, height: 48)
                                            .foregroundColor(.white)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Points:")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                            
                                            Text("\(currUser.dailyPoints)")
                                                .font(.subheadline)
                                                .fontWeight(.medium)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .background(Color.gray)
                                .clipShape(.rect(cornerRadius: 15))
                                .padding()
                            }
                            
                            VStack(alignment: .leading) {
                                Text("History")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                List {
                                    HStack {
                                        Text("Daily Streak:").bold()
                                        Text("\(currUser.dailyStreak)")
                                    }
                                    HStack {
                                        Text("Daily Points Record").bold()
                                        Text("\(currUser.dailyPoints)")
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Top Categories").bold()
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 10) {
                                                let topCategories = currUser.categoryPlayCounts
                                                    .sorted { $0.value > $1.value }
                                                    .prefix(3)
                                                    .map { $0.key }
                                                ForEach(topCategories, id: \.self) { category in
                                                    Text(category)
                                                        .font(.callout)
                                                        .padding(8)
                                                        .background(Color.gray.opacity(0.3))
                                                        .clipShape(RoundedRectangle(cornerRadius: 7))
                                                }
                                            }
                                            .padding(.horizontal)
                                        }
                                    }
                                }
                                .listStyle(.inset)
                                .scrollDisabled(true)
                                .frame(height: 200)
                            }
                            .padding(.horizontal)
                            
                            VStack(alignment: .leading) {
                                Text("Recent Categories")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                VStack(spacing: 8) {
                                    ForEach(currUser.recentCategories, id: \.self) { category in
                                        CategoryPlayRow(category: category)
                                            .onTapGesture {
                                                isCategorySelected.toggle()
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
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
            return mockSession
        }())
}
