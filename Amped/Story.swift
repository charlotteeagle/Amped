
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
            color = UIColor(r: 197, g: 215, b: 232, a: 2)
        } else if json["color"].intValue == 2 {
            color = UIColor(r: 255, g: 226, b: 213, a: 2)
        }  else if json["color"].intValue == 3 {
            color = UIColor(r: 255, g: 238, b:213, a: 2)
        
    }
}
}