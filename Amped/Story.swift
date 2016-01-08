
import Foundation
import SwiftyJSON


class Story {
    
    var text: String!
    var username: String!
    var imageName: String!
    var date: Int!
    var color: UIColor!
    
    init(json: JSON){
        text = json["text"].stringValue
        username = json["userName"].stringValue
        imageName = json["image"].stringValue
        date = json["data"].intValue
        
        if json["color"].intValue == 1 {
            color = UIColor(r: 132, g: 202, b: 173, a: 2)
        } else if json["color"].intValue == 2 {
            color = UIColor.redColor()
        }  else if json["color"].intValue == 3 {
            color = UIColor.greenColor()
        
        
    }
    
    
}
}