//=================================
import UIKit
//=================================
class CSVController: UIViewController
{
    @IBOutlet weak var cvsTextView: UITextView!
    /* ---------------------------------------*/
    var jsonManager = JsonManager(urlToJsonFile: "http://www.igweb.tv/ig_po/json/data.json")
    var listOfSelectedPrograms: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var listOfMedias: [Int] = [0, 0, 0, 0, 0, 0, 0, 0]
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
    // ***** Boutons buttonsForFiltering
    /*
     *  Montre tous les informations qui sont dans la base de données
     *
     */
    @IBAction func buttonsForFiltering(_ sender: UIButton)
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
            case "MÉDIAS" : self.mostEfficientMedia()
            case "PARTICIPANTS" : self.cvsTextView.text = "PARTICIPANTS :\n\t\(self.jsonManager.jsonParsed.count) participants inscrits aux portes ouvertes."
                
            default : print("Not found...")
        }
    }
    /* ---------------------------------------*/
    // ***** Boutons programInterests
    /*
     *  Montre le rapport des programmes en ordre décroisant qui ont été les plus sélectionnées
     *
     */
    @IBAction func programInterests(_ sender: UIButton)
    {
        self.listOfSelectedPrograms = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

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
        
        for index in 0 ..< arrProgramNames.count
        {
            let s = ". \(arrProgramNames[index])"

            for (_, b) in self.jsonManager.jsonParsed
            {
                if s == (b as AnyObject).objectAt(3) as! String
                {
                    self.listOfSelectedPrograms[index] += 1
                }
            }
        }
        
        var s: String = "INTÉRÊT DES PROGRAMMES : \n\n"
        
        for index in 0 ..< arrProgramNames.count
        {
            // . Administrateur → CSV → Programmes
            //s += "\t. \(self.listOfSelectedPrograms[index]) = \(arrProgramNames[index])\n"
            s += "\t \(self.listOfSelectedPrograms[index]) = \(arrProgramNames[index])\n"
        }
        
        self.cvsTextView.text = s
    }
    /* ---------------------------------------*/
    // ***** Fonction mostEfficientMedia
    /*
     *  Montre le rapport des médias en ordre décroisant qui ont été les plus sélectionnées
     *
     */
    func mostEfficientMedia()
    {
        self.listOfMedias = [0, 0, 0, 0, 0, 0, 0, 0]
        
        let arrMedias: [String] = [
            "Amis / Famille",
            "Radio",
            "Publicité Internet",
            "Journaux",
            "Moteur de recherche",
            "Médias sociaux",
            "Télévision",
            "Autres"]
        
        for index in 0 ..< arrMedias.count
        {
            let s = "\(arrMedias[index])"
            
            for (_, b) in self.jsonManager.jsonParsed
            {
                if s == (b as AnyObject).objectAt(2) as! String
                {
                    self.listOfMedias[index] += 1
                }
            }
        }
        
        var s: String = "EFFICACITÉ DES MÉDIAS : \n\n"
        
        for index in 0 ..< arrMedias.count
        {
            // . Administrateur → CSV → Médias
            //s += "\t. \(self.listOfMedias[index]) = \(arrMedias[index])\n"
            s += "\t \(self.listOfMedias[index]) = \(arrMedias[index])\n"
        }
        
        self.cvsTextView.text = s
    }
    /* ---------------------------------------*/
    // ***** Bouton reset
    /*
     *  Montre un alerte à l’utilisateur si il veut vraiment effacer les données
     *
     */
    @IBAction func reset(_ sender: UIButton)
    {
        let refreshAlert = UIAlertController(title: "Réinialisation", message: "Vous voulez vraiment effacer toutes les données?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Oui", style: .default, handler: { (action: UIAlertAction!) in
            self.reallyDoReset()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Non", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    /* ---------------------------------------*/
    // ***** Fonction reallyDoReset
    /*
     * Efface toutes les informations dans la base de données
     *
     */
    func reallyDoReset()
    {
        self.jsonManager.upload("delete=reset", urlForAdding: "http://www.igweb.tv/ig_po/php/delete.php")
        self.cvsTextView.text = ""
        self.jsonManager = JsonManager(urlToJsonFile: "http://www.igweb.tv/ig_po/json/data.json")
    }
    /* ---------------------------------------*/
}
//=================================








