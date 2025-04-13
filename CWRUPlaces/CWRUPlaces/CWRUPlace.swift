//
//  CWRUPlaces.swift
//  CWRUPlaces
//
//  Created by Caroline Schafer on 4/13/25.
//

import Foundation
import MapKit

struct CWRUPlace : Identifiable {
    let id: UUID = UUID()
    var user: String
    var label: String
    var coordinate: CLLocationCoordinate2D
}
