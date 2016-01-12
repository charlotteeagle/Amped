import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var locations = [CustomLocation]()
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var fillImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        mapView.setUserTrackingMode(.Follow, animated: true)
        
        
        let bournemouth = CustomLocation(lat: 50.716098, long: -1.875780, identifier: "bournemouthpier.json")
        locations.append(bournemouth)
        let gardens = CustomLocation(lat: 50.719799, long: -1.879439, identifier: "gardens.json")
        locations.append(gardens)
        let boscombePier = CustomLocation(lat: 50.719914, long: -1.843552, identifier: "boscombepier.json")
        locations.append(boscombePier)
        
        
        for location in locations {
            locationManager.startMonitoringForRegion(location.region)
        }
        
    }
    
    @IBAction func trackUser(sender: AnyObject) {
        mapView.setUserTrackingMode(.Follow, animated: true)
    }
    
    func getBearingBetweenTwoPoints(x: CLLocationCoordinate2D, y: CLLocationCoordinate2D) -> CGFloat {
        
        let lat1 = degreesToRadians(x.latitude)
        let lon1 = degreesToRadians(x.longitude)
        
        let lat2 = degreesToRadians(y.latitude);
        let lon2 = degreesToRadians(y.longitude);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        var radiansBearing = atan2(y, x);
        
        if radiansBearing < 0.0 {
            radiansBearing += CGFloat(2 * M_PI)
        }
        
        return radiansToDegrees(Double(radiansBearing))
    }
    
    func degreesToRadians(value:Double) -> CGFloat {
        return CGFloat(value * M_PI / 180.0)
    }
    
    func radiansToDegrees(radians: Double) -> CGFloat {
        return CGFloat(radians * 180.0 / M_PI)
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        //post noitification and tell other VC to download data 
        // https://www.andrewcbancroft.com/2014/10/08/fundamentals-of-nsnotificationcenter-in-swift/
        
        NSNotificationCenter.defaultCenter().postNotificationName("Hit Location", object: region.identifier)
        
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {

    }

}




extension MapViewController: MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        let newLocation = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        for location in locations {
            location.distanceFromUser = location.location.distanceFromLocation(newLocation)
            print(location.distanceFromUser)
        }
        
        locations.sortInPlace({return $0.distanceFromUser < $1.distanceFromUser})
   
        let closestLocation = locations.first
        
        if closestLocation!.distanceFromUser < 1000 {
            UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { _ in
                self.fillImage.transform = CGAffineTransformMakeScale(CGFloat(closestLocation!.distanceFromUser/1000), CGFloat(closestLocation!.distanceFromUser/1000))
                
            }) { _ in }
        }
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { _ in
            self.bgImage.transform = CGAffineTransformMakeRotation(self.getBearingBetweenTwoPoints(CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude), y: CLLocationCoordinate2D(latitude: closestLocation!.location.coordinate.latitude, longitude: closestLocation!.location.coordinate.longitude)))
            }) { _ in }

        
    }
    
    
}

