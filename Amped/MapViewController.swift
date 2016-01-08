import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var fillImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        mapView.setUserTrackingMode(.Follow, animated: true)
        
        
        let bournemouthPier = CLLocationCoordinate2D(latitude: 50.716098, longitude: -1.875780)
        let bournemouthPierRegion = CLCircularRegion(center: bournemouthPier, radius: 50, identifier: "bournemouthpier.json")
        locationManager.startMonitoringForRegion(bournemouthPierRegion)

        let gardens = CLLocationCoordinate2D(latitude: 50.719799, longitude: -1.879439)
        let gardensRegion = CLCircularRegion(center: gardens, radius: 50, identifier: "gardens.json")
        locationManager.startMonitoringForRegion(gardensRegion)
        
        let boscombePier = CLLocationCoordinate2D(latitude: 50.719914, longitude: -1.843552)
        let boscombePierRegion = CLCircularRegion(center: boscombePier, radius: 50, identifier: "boscombepier.json")
        locationManager.startMonitoringForRegion(boscombePierRegion)
        
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
        
        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let distance = location.distanceFromLocation(CLLocation(latitude: 50.719914, longitude: -1.843552))
        
   
        if distance < 1000 {
            print(distance/1000)
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

