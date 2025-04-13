import Foundation
import CoreLocation


@Observable
class LocationModel : LocationManagerDelegate {
    var locations = [CLLocation]()
    
    // since a delegate, must implement method in the protocol
    func didUpdateLocation(_ location: CLLocation) {
        self.locations.append(location)
        print("\(location)")
    }
}

