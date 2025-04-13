import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocation)
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    // how to get longitude/latitude
    private let locationManager = CLLocationManager()
    
    public var delegate:LocationManagerDelegate?
    
    static let shared = LocationManager() //singleton
    
    private override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdating() {
        locationManager.startUpdatingLocation()
    }
    
    //delegate method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            delegate?.didUpdateLocation(location)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("Authorization Changed: \(manager.authorizationStatus)")
        //get a callback from system because delegate
        switch(manager.authorizationStatus) {
            case .authorizedWhenInUse:
                print("Authorized for when in use")
            case .notDetermined:
                print("Waiting on user")
            case .authorizedAlways:
                print("We can access location in background")
            default:
                print("Not Authorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    
    
}
