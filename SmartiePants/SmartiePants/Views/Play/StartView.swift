import SwiftUI
import SwiftData


struct StartView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var session: SessionManager
    
    @State var triviaModel = TriviaModel()
    @State var fetchingQuestions = false
    @Binding var selectedCategoryNumber: Int? // Use Binding to receive the value
    @Binding var selectedDifficulty:Difficulty
    

    @State var startQuiz = false
    @State var showResults = false
    @State var currScore = 0
    
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
    
    
    func loadTriviaQuestions(category: String? = nil) {
        fetchingQuestions = true
        Task {
            await triviaModel.refresh(category: category, difficulty: selectedDifficulty.rawValue)
            fetchingQuestions = false
        }
        print("selected category number: \(selectedCategoryNumber ?? -1)")

    }
    
    func categoryName(for number: Int?) -> String? {
        guard let number = number else { return nil }
        return categories.first(where: { $0.number == number })?.name
    }
    
    func updateUserScore() {
        guard let user = session.currentUser else { return }

        user.dailyPoints += currScore

        if let number = selectedCategoryNumber,
           let category = categoryName(for: number) {

            user.categoryPlayCounts[category, default: 0] += 1

            user.recentCategories.removeAll(where: { $0 == category })
            user.recentCategories.insert(category, at: 0)
            if user.recentCategories.count > 5 {
                user.recentCategories = Array(user.recentCategories.prefix(5))
            }
        }

        try? modelContext.save()
    }
    var body: some View {
        VStack{
            if fetchingQuestions {
                Text("Fetching...")
                    .padding()
            }
            else if !startQuiz && !showResults {
                HStack{
                    Button{
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 12, height: 12)
                                .foregroundColor(Color.black)
                            
                            Text("Back")
                                .font(.footnote)
                                .padding(.leading, 5)
                                .padding(.vertical, 10)
                        }
                        .padding(.horizontal, 20)
                        .background(Color.gray.opacity(0.15))
                        .clipShape(.rect(cornerRadius: 10))
                    }.buttonStyle(.plain)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            Text(categoryName(for: selectedCategoryNumber) ?? "Unknown Category")
                .font(startQuiz ? .title2 : .title)
                .bold()
                .padding(.top)
            
            Rectangle()
                .frame(width: 275, height: 2)
                .padding(.bottom)
            
            if startQuiz {
                QuestionPage(onNext: {
                    withAnimation(.bouncy(duration: 0.6)){
                        startQuiz = false
                        showResults = true
                    }
                }, questions: triviaModel.questions ?? [], currScore: $currScore)
            } else if showResults {
                ResultPage(
                    onReplay: {
                        withAnimation(.bouncy(duration: 0.7)) {
                            showResults = false
                        }
                    },
                    currScore: $currScore,
                    difficulty: selectedDifficulty
                )
                .onAppear {
                       updateUserScore()
                   }
            } else {
                Button{
                    withAnimation(.bouncy(duration: 0.7)) {
                        startQuiz = true
                    }
                } label: {
                    HStack{
                        Text("Play")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.black)
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                }
                .buttonStyle(.plain)
                .background(Color.gray.opacity(0.15))
                .clipShape(.rect(cornerRadius: 10))
            }
            
            Spacer()
        }.padding()
        .onAppear {
            loadTriviaQuestions(category: selectedCategoryNumber != nil ? String(selectedCategoryNumber!) : nil)
        }
        .onChange(of: selectedCategoryNumber, initial: false) { oldValue, newValue in
            if let number = newValue {
                let categoryString = String(number)
                loadTriviaQuestions(category: categoryString)
            }
        }
    }
}
