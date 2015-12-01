
import Foundation
import SwiftyJSON


class Story {
    
    var text: String!
    var username: String!
    var imageName: String!
    var date: Int!
    
    init(json: JSON){
        text = json["text"].stringValue
        username = json["userName"].stringValue
        imageName = json["image"].stringValue
        date = json["data"].intValue
    }
    
    
}