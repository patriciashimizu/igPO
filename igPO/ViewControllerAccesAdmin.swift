//============================================================
import UIKit
//============================================================
class ViewControllerAccesAdmin: UIViewController{
    
    @IBOutlet weak var aLabelMessage: UILabel!
    @IBOutlet weak var aTexteUtilisateur: UITextField!
    @IBOutlet weak var aTexteMotDePasse: UITextField!
    @IBOutlet weak var aButtonAcceder: UIButton!
    
    //------------------------------
    var UtilisateurMotDePasse = [""]
    var defaults = UserDefaults.standard
    var utilisateur: String!
    var motDePasse: String!
    //------------------------------
    @IBAction func bAcceder(_ sender: UIButton) {
        
        if defaults.object(forKey: "SauverDict") == nil {
            let dictionnaire = [
                "UTILISATEUR" : aTexteUtilisateur.text!,
                "MOTDEPASSE" : aTexteMotDePasse.text!
            ]
            defaults.set(dictionnaire, forKey: "SauverDict")
        }
        else {
            let dict = defaults.object(forKey: "SauverDict") as? [String: String] ?? [String: String]()
            
            for (key, value) in dict.reversed() {
                if key == "UTILISATEUR" {
                    utilisateur = value
                }
                else{
                    motDePasse = value
                }
                
            }
           
            if motDePasse == aTexteMotDePasse.text && utilisateur == aTexteUtilisateur.text{
                performSegue(withIdentifier: "seg", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "MAUVAISE UTILISATEUR ET/OU MOT DE PASSE", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
      }
 
    //------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        //defaults.removeObject(forKey: "SauverDict")
        
        montrerMessageEtBouton()
        
    }
    
    //------------------------------
    func montrerMessageEtBouton(){
        if defaults.object(forKey: "SauverDict") == nil{             aLabelMessage.text = "S'INSCRIRE"
            aButtonAcceder.setTitle("SAUVEGARDER", for: .normal)

        }
        else {
            aLabelMessage.text = "SE CONNECTER"
            aButtonAcceder.setTitle("CONNECTER", for: .normal)
            aTexteMotDePasse.text = ""
            aTexteMotDePasse.isSecureTextEntry = true
            
        }
    }
    //------------------------------
   
}
//============================================================
