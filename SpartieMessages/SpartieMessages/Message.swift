import Foundation

/*
 Create a struct called "Message". It should conform to the protocol "Identifiable". It should have the
 properties message, date, and id. The id property should be initialized when the object is constructed
 using the UUID() function. The date should be initialized with the Date() function
 */
struct Message : Identifiable {
    let message:String
    let date:Date
    let id:UUID
    
    init(message: String) {
        self.message = message
        self.date = Date()
        self.id = UUID()
    }
}

