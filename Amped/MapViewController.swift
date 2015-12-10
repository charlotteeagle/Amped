import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
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
        //print(location.distanceFromLocation(CLLocation(latitude: 50.719914, longitude: -1.843552)))
        
    }
    
}

