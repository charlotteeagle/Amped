import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var locations = [CustomLocation]()
    
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
                self.fillImage.transform = CGAffineTransformMakeScale(CGFloat(distance/1000), CGFloat(distance/1000))
            }) { _ in }
        }
        
        
//        UIView.animateWithDuration(0.2, delay: 0, options: [], animations: { _ in
//            
//            if distance > 2000 {
//                
//            }
//            if distance > 1500 {
//                self.fillImage.transform = CGAffineTransformMakeScale(0.3, 0.3)
//            }
//            if distance > 1000 {
//                self.fillImage.transform = CGAffineTransformMakeScale(0.5, 0.5)
//            }
//            if distance > 500 {
//                self.fillImage.transform = CGAffineTransformMakeScale(0.8, 0.8)
//            }
//            if distance > 100 {
//                self.fillImage.transform = CGAffineTransformMakeScale(1, 1)
//            }
//            
//            }) { _ in
//                
//        }
        
    }
    
}

