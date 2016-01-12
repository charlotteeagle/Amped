import UIKit
import CoreLocation

class CustomLocation {
    
    var location: CLLocation!
    var identifier: String!
    var region: CLCircularRegion {
        return CLCircularRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), radius: 50, identifier: identifier)
    }
    var distanceFromUser: Double!
    
    init(lat: Double, long: Double, identifier: String) {
        self.location = CLLocation(latitude: lat, longitude: long)
        self.identifier = identifier
    }
    
    
}