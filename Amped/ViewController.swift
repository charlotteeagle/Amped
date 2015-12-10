//Kyle's comment

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let locationManager = CLLocationManager()
    
    var stories = [Story]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "downloadData:", name: "Hit Location", object: nil)

    }

    func downloadData(notification: NSNotification) {
        
        let file = notification.object as! String
        
        Alamofire.request(.GET, "http://kylegoslan.co.uk/" + file)
            .response { request, response, data, error in
                
                if let data = data {
                    let json = JSON(data: data)
                    
                    for story in json {
                        let newStory = Story(json: story.1)
                        self.stories.removeAll()
                        self.stories.append(newStory)
                    }
                    
                    self.tableView.reloadData()
                }
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let story = stories[indexPath.row]
        
        let titleLabel = cell?.viewWithTag(2) as! UILabel
        titleLabel.text = story.username
        
        let textLabel = cell?.viewWithTag(1) as! UILabel
        textLabel.text = story.text
        
        return cell!
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    
    
}

