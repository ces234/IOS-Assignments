import SwiftUI

/* TODO: Spacing on this page is weird */
struct HomePageView: View {
    /* TODO: Pull these variables from saved data */
    var recentCategories = ["Entertainment", "Science: Computers", "Celebrities"]
    var usersTopCategories = ["Sports", "Entertainment: Music", "Animals"]
    
    @EnvironmentObject var session: SessionManager

    @State var isCategorySelected = false
    @State var selectedCategoryNumber: Int?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    VStack(alignment: .leading) {
                        Text("Welcome back,")
                            .font(.title2)
                        if let currUser = session.currentUser {
                            Text("Hello, \(currUser.firstName)! You have \(currUser.dailyPoints) points.")
                                .font(.title)
                                .bold()
                        }
                        Text("Caroline") /* TODO: REPLACE WITH USER'S NAME PASSED IN */
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
                                    
                                    Text("5 / 123")
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
                                    
                                    Text("6000")  /* TODO: REPLACE WITH DATA */
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
                            /* TODO: REPLACE WITH DATA */
                            HStack {
                                Text("Daily Streak:").bold()
                                Text("5")
                            }
                            HStack {
                                Text("Daily Points Record").bold()
                                Text("14000")
                            }
                           
                            VStack(alignment: .leading) {
                                Text("Top Categories").bold()

                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(usersTopCategories, id: \.self) { category in
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
                        .frame(height: 200) // Limit height of the list
                    }.padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Recent Categories")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        VStack(spacing: 8) { // Use a VStack instead of List to control layout
                            ForEach(recentCategories, id: \.self) { category in
                                CategoryPlayRow(category: category)
                                .onTapGesture {
                                    isCategorySelected.toggle()
                                }
                            }
                        }
                    }.padding(.horizontal)
                    
                    Spacer()
                }
                
            }
        }.padding()
        .fullScreenCover(isPresented: $isCategorySelected) {
            StartView(selectedCategoryNumber: $selectedCategoryNumber)
        }
    }
}

#Preview {
    HomePageView()
}
