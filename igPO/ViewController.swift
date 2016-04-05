//=================================
import UIKit
//=================================
class ViewController: UIViewController
{
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var how: UITextField!
    /* ---------------------------------------*/
    var arrForButtonManagement: [Bool] = []
    let arrProgramNames: [String] = [
        "DEC - Techniques de production et postproduction télévisuelles (574.AB)",
        "AEC - Production télévisuelle et cinématographique (NWY.15)",
        "AEC - Techniques de montage et d’habillage infographique (NWY.00)",
        "DEC - Techniques d’animation 3D et synthèse d’images (574.BO)",
        "AEC - Production 3D pour jeux vidéo (NTL.12)",
        "AEC - Animation 3D et effets spéciaux (NTL.06)",
        "DEC - Techniques de l’informatique, programmation nouveaux médias (420.AO)",
        "DEC - Technique de l’estimation en bâtiment (221.DA)",
        "DEC - Techniques de l’évaluation en bâtiment (221.DB)",
        "AEC - Techniques d’inspection en bâtiment (13)",
        "AEC - Métré pour l’estimation en construction (EEC.00)",
        "AEC - Sécurité industrielle et commerciale (LCA.5Q)"]
    //let jsonManager = JsonManager(urlToJsonFile: "http://localhost/xampp/geneau/ig_po/json/data.json")
    let jsonManager = JsonManager(urlToJsonFile: "http://www.igweb.tv/ig_po/json/data.json")
    /* ---------------------------------------*/
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        jsonManager.importJSON()
        
        fillUpArray()
    }
    /* ---------------------------------------*/
    func fillUpArray()
    {
        for _ in 0...11
        {
            arrForButtonManagement.append(false)
        }
    }
    /* ---------------------------------------*/
    func manageSelectedPrograms() -> String
    {
        var stringToReturn: String = ". "
        
        for x in 0 ..< self.arrProgramNames.count
        {
            if self.arrForButtonManagement[x]
            {
                stringToReturn += self.arrProgramNames[x] + "\n. "
            }
        }
        
        // Delete 2 last characters of string...
        if stringToReturn != ""
        {
            stringToReturn = stringToReturn.substringToIndex(stringToReturn.endIndex.predecessor())
            stringToReturn = stringToReturn.substringToIndex(stringToReturn.endIndex.predecessor())
            stringToReturn = stringToReturn.substringToIndex(stringToReturn.endIndex.predecessor())
        }
        
        return stringToReturn
    }
    /* ---------------------------------------*/
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    /* ---------------------------------------*/
    @IBAction func buttonManager(sender: UIButton)
    {
        let buttonIndexInArray = sender.tag - 100
        
        if !arrForButtonManagement[buttonIndexInArray]
        {
            sender.setImage(UIImage(named: "case_select.png"), forState: UIControlState.Normal)
            self.arrForButtonManagement[buttonIndexInArray] = true
        }
        else
        {
            sender.setImage(UIImage(named: "case.png"), forState: UIControlState.Normal)
            self.arrForButtonManagement[buttonIndexInArray] = false
        }
    }
    /* ---------------------------------------*/
    func deselectAllButtons()
    {
        for x in 0 ..< self.arrForButtonManagement.count
        {
            self.arrForButtonManagement[x] = false
            let aButton: UIButton = (self.view.viewWithTag(100 + x) as? UIButton)!
            aButton.setImage(UIImage(named: "case.png"), forState: UIControlState.Normal)
        }
    }
    /* ---------------------------------------*/
    @IBAction func saveInformation(sender: UIButton)
    {
        if self.name.text == ""
        {
            self.alert("Veuillez insérer votre nom...")
            return
        }
        
        let progs = self.manageSelectedPrograms()
        
        let stringToSend = "name=NOM : \(self.name.text!)&phone=TÉLÉPHONE : \(self.phone.text!)&email=COURRIEL : \(self.email.text!)&how=COMMENT NOUS AVOIR TROUVÉS : \(self.how.text!)&progs=PROGRAMMES INTÉRESSÉS : \n\(progs)"
        //self.jsonManager.upload(stringToSend, urlForAdding: "http://localhost/xampp/geneau/ig_po/php/add.php")
        self.jsonManager.upload(stringToSend, urlForAdding: "http://www.igweb.tv/ig_po/php/add.php")
        self.clearFields()
        self.deselectAllButtons()
        self.alert("Les données ont été sauvegardées...")
    }
    /* ---------------------------------------*/
    func alert(theMessage: String)
    {
        let refreshAlert = UIAlertController(title: "Message...", message: theMessage, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        refreshAlert.addAction(OKAction)
        self.presentViewController(refreshAlert, animated: true){}
    }
    /* ---------------------------------------*/
    func clearFields()
    {
        self.name.text = ""
        self.phone.text = ""
        self.email.text = ""
        self.how.text = ""
    }
    /* ---------------------------------------*/
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    /* ---------------------------------------*/
}
//=================================












