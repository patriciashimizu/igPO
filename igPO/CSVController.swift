//=================================
import UIKit
//=================================
class CSVController: UIViewController
{
    @IBOutlet weak var cvsTextView: UITextView!
    /* ---------------------------------------*/
    let jsonManager = JsonManager(urlToJsonFile: "http://www.igweb.tv/ig_po/json/data.json")
    /* ---------------------------------------*/
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.jsonManager.importJSON()
        self.cvsTextView.text = self.jsonManager.converJsonToCsv("NOM,TÉLÉPHONE,COURRIEL,COMMENT,PROGRAMMES")
    }
    /* ---------------------------------------*/
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    /* ---------------------------------------*/
    @IBAction func buttonsForFiltering(sender: UIButton)
    {
        var strToDisplay = ""
        
        switch sender.currentTitle!
        {
        case "NOMS" :
            strToDisplay = "Noms :\n"
            for (a, _) in self.jsonManager.jsonParsed
            {
                strToDisplay += "\t. \(a)\n"
            }
            
            self.cvsTextView.text = strToDisplay
            
        case "TÉLÉPHONES" : self.cvsTextView.text = self.jsonManager.filter(0, title: "Téléphones")
        case "COURRIELS" : self.cvsTextView.text = self.jsonManager.filter(1, title: "Courriels")
        case "COMMENT" : self.cvsTextView.text = self.jsonManager.filter(2, title: "Comment avoir entendu parlé de nous")
            
        default : print("Not found...")
        }
    }
    /* ---------------------------------------*/
}
//=================================