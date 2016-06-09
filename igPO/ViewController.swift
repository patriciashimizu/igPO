//=================================
import UIKit
//=================================
class ViewController: UIViewController
{
    /* ---------------------------------------*/
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var amis: UIButton!
    @IBOutlet weak var radio: UIButton!
    @IBOutlet weak var pub_internet: UIButton!
    @IBOutlet weak var journaux: UIButton!
    @IBOutlet weak var moteur: UIButton!
    @IBOutlet weak var sociaux: UIButton!
    @IBOutlet weak var tv: UIButton!
    @IBOutlet weak var autres: UIButton!
    /* ---------------------------------------*/
    var pickerChoice: String = ""
    var arrMediaButtons:[UIButton]!
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
        "AEC - Techniques d’inspection en bâtiment (EEC.13)",
        "AEC - Métré pour l’estimation en construction (EEC.00)",
        "AEC - Sécurité industrielle et commerciale (LCA.5Q)"]
    //let jsonManager = JsonManager(urlToJsonFile: "http://localhost/xampp/geneau/ig_po/json/data.json")
    let jsonManager = JsonManager(urlToJsonFile: "http://www.igweb.tv/ig_po/json/data.json")
    /* ---------------------------------------*/
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        arrMediaButtons = [amis, radio, pub_internet, journaux, moteur, sociaux, tv, autres]
        
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
        
        for x in 0 ..< arrProgramNames.count
        {
            if arrForButtonManagement[x]
            {
                stringToReturn += arrProgramNames[x] + "\n. "
            }
        }
        
        // Delete 3 last characters of string...
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
            arrForButtonManagement[buttonIndexInArray] = true
        }
        else
        {
            sender.setImage(UIImage(named: "case.png"), forState: UIControlState.Normal)
            arrForButtonManagement[buttonIndexInArray] = false
        }
    }
    /* ---------------------------------------*/
    func deselectAllButtons()
    {
        for x in 0 ..< arrForButtonManagement.count
        {
            arrForButtonManagement[x] = false
            let aButton: UIButton = (view.viewWithTag(100 + x) as? UIButton)!
            aButton.setImage(UIImage(named: "case.png"), forState: UIControlState.Normal)
        }
    }
    /* ---------------------------------------*/
    @IBAction func saveInformation(sender: UIButton)
    {
        if name.text == ""
        {
            alert("Veuillez insérer votre nom...")
            return
        }
        
        if !checkMediaSelection()
        {
            alert("Veuillez nous indiquer comment vous avez entendu parler de nous...")
            return
        }
        
        let progs = manageSelectedPrograms()
        
        let stringToSend = "name=\(name.text!)&phone=\(phone.text!)&email=\(email.text!)&how=\(pickerChoice)&progs=\(progs)"
        //jsonManager.upload(stringToSend, urlForAdding: "http://localhost/xampp/geneau/ig_po/php/add.php")
        jsonManager.upload(stringToSend, urlForAdding: "http://www.igweb.tv/ig_po/php/add.php")
        clearFields()
        deselectAllButtons()
        resetAllMediaButtonAlphas()
        
        alert("Les données ont été sauvegardées...")
    }
    /* ---------------------------------------*/
    func alert(theMessage: String)
    {
        let refreshAlert = UIAlertController(title: "Message...", message: theMessage, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        refreshAlert.addAction(OKAction)
        presentViewController(refreshAlert, animated: true){}
    }
    /* ---------------------------------------*/
    func clearFields()
    {
        name.text = ""
        phone.text = ""
        email.text = ""
    }
    /* ---------------------------------------*/
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    /* ---------------------------------------*/
    @IBAction func mediaButtons(sender: UIButton)
    {
        resetAllMediaButtonAlphas()
        
        pickerChoice = (sender.titleLabel?.text)!
        
        if sender.alpha == 0.5
        {
            sender.alpha = 1.0
        }
        else
        {
            sender.alpha = 0.5
        }
    }
    /* ---------------------------------------*/
    func resetAllMediaButtonAlphas()
    {
        for index in 0 ..< arrMediaButtons.count
        {
            arrMediaButtons[index].alpha = 0.5
        }
    }
    /* ---------------------------------------*/
    func checkMediaSelection() -> Bool
    {
        var chosen = false
        
        for index in 0 ..< arrMediaButtons.count
        {
            if arrMediaButtons[index].alpha == 1.0
            {
                chosen = true
                break
            }
        }
        
        return chosen
    }
    /* ---------------------------------------*/
}
//=================================












