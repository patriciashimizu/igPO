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
        
        let dictionnaire = [
            "UTILISATEUR" : aTexteUtilisateur.text,
            "MOTDEPASSE" : aTexteMotDePasse.text
        ]
        
        Singleton.sharedInstance.dictionnaire = dictionnaire as! [String : String]
        
        
        
       //defaults.set(dictionnaire, forKey: "SavedDict")
       //let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
        
        /*if defaults.object(forKey: "SavedDict") == nil {
            defaults.set(dictionnaire, forKey: "SavedDict")
        }
        else {
            for (key, value) in dictionnaire {
                print ("\(key) -> \(value)")
            }
        }*/
        
        
        if  defaults.object(forKey: "UTILISATEUR") == nil && defaults.object(forKey: "MOTDEPASSE") == nil {
            defaults.set(aTexteUtilisateur.text, forKey: "UTILISATEUR")
            defaults.set(aTexteMotDePasse.text, forKey: "MOTDEPASSE")
        }
            
        else {
            utilisateur = defaults.object(forKey: "UTILISATEUR") as! String!
            password = defaults.object(forKey: "MOTDEPASSE") as! String!
            if password == aTexteMotDePasse.text && utilisateur == aTexteUtilisateur.text{
                performSegue(withIdentifier: "seg", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "MAUVAISE UTILISATEUR ET/OU MOT DE PASSE", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
            /*let dictionnaire = [
            "NAME" : "PATRICIA",
            "LASTNAME" : "SHIMIZU",
            "COUNTRY" : "BRAZIL",
            "PROFESSION" : "PM"
            
        ]
        
        Singleton.sharedInstance.dictionnaire = dictionnaire*/
        
        /*if defaults.object(forKey: "PASSWORD") == nil {
            defaults.set(aTexteMotDePasse.text, forKey: "PASSWORD")
            montrerMessageEtBouton()
        }
            
        else {
            password = defaults.object(forKey: "PASSWORD") as! String!
            if password == aTexteMotDePasse.text {
                performSegue(withIdentifier: "seg", sender: nil)
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "PASSWORD INCORRECT", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }*/

    }
 
        //---------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        /*UtilisateurMotDePasse.remove(at: 0)
        for(_, b) in Singleton.sharedInstance.dictionnaire{
            UtilisateurMotDePasse.append(b)
        }*/
        
        //defaults.removeObject(forKey: "MOTDEPASSE")
        //defaults.removeObject(forKey: "UTILISATEUR")

        
        montrerMessageEtBouton()
        
    }
    
    //---------------------
    func montrerMessageEtBouton(){
        if defaults.object(forKey: "MOTDEPASSE") == nil && defaults.object(forKey: "UTILISATEUR") == nil{             aLabelMessage.text = "CREATE PASSWORD"
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
