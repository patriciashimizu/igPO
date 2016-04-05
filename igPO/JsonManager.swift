/*==================================*/
import Foundation
/*==================================*/
class JsonManager
{
    /* ------------------------------------- */
    var jsonParsed:NSMutableDictionary = [:]
    var urlToJsonFile: String = ""
    /* ------------------------------------- */
    init(urlToJsonFile: String)
    {
        self.urlToJsonFile = urlToJsonFile
    }
    /* ------------------------------------- */
    func parser(jsonFilePath: String) -> NSMutableDictionary
    {
        let data = NSData(contentsOfURL: NSURL(string: jsonFilePath)!)!
        return try! NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as! NSMutableDictionary
    }
    /* ------------------------------------- */
    func importJSON()
    {
        self.jsonParsed = self.parser(self.urlToJsonFile)
    }
    /* ------------------------------------- */
    func upload(stringToSend: String, urlForAdding: String)
    {
        let url:NSURL = NSURL(string: urlForAdding)!
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let data = stringToSend.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.uploadTaskWithRequest(request, fromData: data, completionHandler:
        {(data,response,error) in
            guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else
            {
                print("error")
                return
            }
                _ = NSString(data: data!, encoding: NSUTF8StringEncoding)
            }
        );
        
        task.resume()
    }
    /* ------------------------------------- */
    func returnValues(dataIndex: Int) -> [String]
    {
        var arrayForData: [String] = []
        
        for (_, b) in self.jsonParsed
        {
            arrayForData.append((b as! NSArray)[dataIndex] as! String)
        }
        
        return arrayForData
    }
    /* ------------------------------------- */
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
    func converJsonToCsv(fieldNamesSeperatedByComas: String) -> String
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
            
            CSV = CSV.substringToIndex(CSV.endIndex.predecessor())
            CSV += "\n"
        }
        
        return CSV.substringToIndex(CSV.endIndex.predecessor())
    }
    /* ------------------------------------- */
    func filter(index: Int, title: String) -> String
    {
        var strToDisplay = "\(title) :\n"
        
        for (_, b) in self.jsonParsed
        {
            if (b.objectAtIndex(index) as! String) != ""
            {
                strToDisplay += "\t. \(b.objectAtIndex(index) as! String)\n"
            }
        }
        
        return strToDisplay
    }
    /* ------------------------------------- */
}
/*==================================*/















