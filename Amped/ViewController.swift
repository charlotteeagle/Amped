
import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data.append("Kyle")
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let story = data[indexPath.row]
        
        let titleLabel = cell?.viewWithTag(1) as! UILabel
        titleLabel.text = story
        
        return cell!
    }
    
}


extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}


