//=================================
import UIKit
//=================================
class EntriesController: UIViewController
{
    /* ---------------------------------------*/
    //let jsonManager = JsonManager(urlToJsonFile: "http://localhost/xampp/geneau/ig_po/json/data.json")
    let jsonManager = JsonManager(urlToJsonFile: "http://www.igweb.tv/ig_po/json/data.json")
    var names: [String] = []
    var phones: [String] = []
    var emails: [String] = []
    var hows: [String] = []
    var progs: [String] = []
    @IBOutlet weak var theTableView: UITableView!
    /* ---------------------------------------*/
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.jsonManager.importJSON()
        self.names = self.jsonManager.returnKeys()
        self.phones = self.jsonManager.returnValues(0)
        self.emails = self.jsonManager.returnValues(1)
        self.hows = self.jsonManager.returnValues(2)
        self.progs = self.jsonManager.returnValues(3)
    }
    /* ---------------------------------------*/
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    /* ---------------------------------------*/
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        tableView.backgroundColor = UIColor.clearColor()
        return self.names.count
    }
    /* ---------------------------------------*/
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = (self.theTableView.dequeueReusableCellWithIdentifier("po")! as UITableViewCell)
        
        if let theLabel = cell.viewWithTag(200) as? UILabel
        {
            theLabel.text = "NOM : \(self.names[indexPath.row])"
        }
        
        if let theLabel = cell.viewWithTag(201) as? UILabel
        {
            theLabel.text = "TÉLÉPHONE : \(self.phones[indexPath.row])"
        }
        
        if let theLabel = cell.viewWithTag(202) as? UILabel
        {
            theLabel.text = "COURRIEL : \(self.emails[indexPath.row])"
        }
        
        if let theLabel = cell.viewWithTag(203) as? UILabel
        {
            theLabel.text = "COMMENT AVOIR ENTENDU PARLÉ DE NOUS : \(self.hows[indexPath.row])"
        }
        
        if let theTextView = cell.viewWithTag(204) as? UITextView
        {
            theTextView.text = "INTÉRESSÉ PAR LES PROGRAMMES : \n\(self.progs[indexPath.row])"
        }
        
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    /* ---------------------------------------*/
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let selectedCell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGrayColor()
    }
    /* ---------------------------------------*/
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete
        {
            self.jsonManager.upload("delete=\(self.names[indexPath.row])", urlForAdding: "http://www.igweb.tv/ig_po/php/delete.php")
            
            self.names.removeAtIndex(indexPath.row)
            self.phones.removeAtIndex(indexPath.row)
            self.emails.removeAtIndex(indexPath.row)
            self.hows.removeAtIndex(indexPath.row)
            self.progs.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    /* ---------------------------------------*/
}
//=================================
















