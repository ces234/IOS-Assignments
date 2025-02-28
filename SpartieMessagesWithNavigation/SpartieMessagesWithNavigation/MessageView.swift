//
//  MessageView.swift
//  SpartieMessagesWithNavigation
//
//  Created by Zoe Goldberg on 2/11/25.
//

import SwiftUI

struct MessageView: View {
    @State var message: Message
    
    func getDateFormat(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/d/yy, h:mm a"
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        VStack{
            HStack {
                Spacer()
                
                Text(message.message)
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .background(Color(UIColor(named: "DarkPink")!))
                    .foregroundStyle(Color.white)
                    .cornerRadius(12)
                
            }
            .padding(EdgeInsets(top: 2, leading: 10, bottom: 0, trailing: 10))
            
            HStack{
                Spacer()
                Text(getDateFormat(for: message.date))
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 2, trailing: 10))

        }
        .background(Color(UIColor(named: "BackgroundColor")!))

    }
}

#Preview {
    MessageView(message: Message(message: "Hello Spartie!"))
}
