/*==================================*/
import Foundation
/*==================================*/
class JsonManager
{
    /* ------------------------------------- */
    var jsonParsed:NSMutableDictionary = [:]
    var urlToJsonFile: String = ""
    /* ------------------------------------- */
    // ***** Méthode constructeur
    init(urlToJsonFile: String)
    {
        self.urlToJsonFile = urlToJsonFile
    }
    /* ------------------------------------- */
    // ***** Fonction parser
    /*
     *  Fait le « parse » du contenu du fichier JSON
     *
     */
    func parser(_ jsonFilePath: String) -> NSMutableDictionary
    {
        let data = try! Data(contentsOf: URL(string: jsonFilePath)!)
        return try! JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableDictionary
    }
    /* ------------------------------------- */
    // ***** Fonction importJSON
    /*
     *  Fait l’importation du fichier JSON
     *
     */
    func importJSON()
    {
        self.jsonParsed = self.parser(self.urlToJsonFile)
    }
    /* ------------------------------------- */
    // ***** Fonction upload
    /*
     *  Télécharge le fichier JSON
     *
     */
    func upload(_ stringToSend: String, urlForAdding: String)
    {
        let url:URL = URL(string: urlForAdding)!
        
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let data = stringToSend.data(using: String.Encoding.utf8)
        
        let task = session.uploadTask(with: request as URLRequest, from: data, completionHandler:
        {(data,response,error) in
            guard let _:Data = data, let _:URLResponse = response, error == nil else
            {
                print("error")
                return
            }
                _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            }
        );
        
        task.resume()
    }
    /* ------------------------------------- */
    // ***** Fonction returnValues
    /*
     *  Retourne le contenu du fichier JSON
     *
     */
    func returnValues(_ dataIndex: Int) -> [String]
    {
        var arrayForData: [String] = []
        
        for (_, b) in self.jsonParsed
        {
            arrayForData.append((b as! NSArray)[dataIndex] as! String)
        }
        
        return arrayForData
    }
    /* ------------------------------------- */
    // ***** Fonction returnKeys
    /*
     *  Retourne les clés du fichier JSON
     *
     */
    func returnKeys() -> [String]
    {
        var arrayForData: [String] = []
        
        for (a, _) in self.jsonParsed
        {
            arrayForData.append(a as! String)
        }
        
        return arrayForData
    }
    /* ------------------------------------- */
    // ***** Fonction converJsonToCsv
    /*
     *  Fait la mise en forme du contenu du fichier JSON pour qu’il soit prêt à être exporté
     *
     */
    func converJsonToCsv(_ fieldNamesSeperatedByComas: String) -> String
    {
        var CSV: String = "\(fieldNamesSeperatedByComas)\n"
        
        for (a, b) in self.jsonParsed
        {
            var newString = "\""
            newString +=  a as! String
            newString += "\""
            CSV += newString + ","
            
            for c in 0 ..< (b as! NSArray).count
            {
                var newString = "\""
                newString +=  ((b as! NSArray)[c] as! String)
                newString += "\""
                CSV += newString + ","
            }
            
            CSV = CSV.substring(to: CSV.characters.index(before: CSV.endIndex))
            CSV += "\n"
        }
        
        return CSV.substring(to: CSV.characters.index(before: CSV.endIndex))
    }
    /* ------------------------------------- */
    // ***** Fonction filter
    /*
     *  Fait le filtre du titre avec « \t » (horizontal tab)
     *
     */
    func filter(_ index: Int, title: String) -> String
    {
        var strToDisplay = "\(title) :\n"
        
        for (_, b) in self.jsonParsed
        {
            if (b as AnyObject)[index] as! String != ""
            {
                strToDisplay += "\t. \((b as AnyObject)[index] as! String)\n"
            }
        }
        
        return strToDisplay
    }
    /* ------------------------------------- */
}
/*==================================*/















