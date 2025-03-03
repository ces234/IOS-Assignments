//
//  NASAResponse.swift
//  Networking with Nasa
//
//  Created by Caroline Schafer on 3/1/25.
//

import SwiftUI

struct NASAResponse: Codable {     //MUST BE CODABLE
    var date: String
    var explanation: String
    var hdurl: String
    var media_type: String
    var service_version: String
    var title: String
    var url: String
    
    func toString() -> String {
        return date
    }
}


