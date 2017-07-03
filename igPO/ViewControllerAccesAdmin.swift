import UIKit

class ViewControllerAccesAdmin: UIViewController{
    
    @IBOutlet weak var aLabelMessage: UILabel!
    @IBOutlet weak var aTexteUtilisateur: UITextField!
    @IBOutlet weak var aTexteMotDePasse: UITextField!
    @IBOutlet weak var aButtonAcceder: UIButton!
    
    //---------------------
    var UtilisateurMotDePasse = [""]
    var defaults = UserDefaults.standard
    var utilisateur: String!
    var password: String!
    //---------------------
    @IBAction func bAcceder(_ sender: UIButton) {
        
        if defaults.object(forKey: "SavedDict") == nil {
            let dictionnaire = [
                "UTILISATEUR" : aTexteUtilisateur.text!,
                "MOTDEPASSE" : aTexteMotDePasse.text!
            ]
            defaults.set(dictionnaire, forKey: "SavedDict")
            for (key, value) in dictionnaire.reversed() {
                print ("\(key) -> \(value)")
            }
        }
        else {
            let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
            
            
            for (key, value) in dict.reversed() {
                print ("DICT: " + "\(key) -> \(value)")
            }

            
            for (key, value) in dict.reversed() {
                if key == "UTILISATEUR" {
                    utilisateur = value
                }
                else{
                    password = value
                }
                
            }

            
            
            if password == aTexteMotDePasse.text && utilisateur == aTexteUtilisateur.text{
                performSegue(withIdentifier: "seg", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "MAUVAISE UTILISATEUR ET/OU MOT DE PASSE", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
      }
 
        //---------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //defaults.removeObject(forKey: "SavedDict")
        
        montrerMessageEtBouton()
        
    }
    
    //---------------------
    func montrerMessageEtBouton(){
        if defaults.object(forKey: "SavedDict") == nil{             aLabelMessage.text = "CREATE PASSWORD"
            aButtonAcceder.setTitle("CREATE", for: .normal)

        }
        else {
            aLabelMessage.text = "INSERT PASSWORD"
            aButtonAcceder.setTitle("INSERT", for: .normal)
            aTexteMotDePasse.text = ""
            aTexteMotDePasse.isSecureTextEntry = true
            
        }
    }
   
}
