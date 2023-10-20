
import UIKit
import Alamofire
import SwiftyJSON

typealias JSONDictionary = Dictionary<String, AnyObject>
typealias JSONStringDictionary = Dictionary<String, String>
typealias JSONArray = Array<AnyObject>
typealias json = JSON

class Config : NSObject{
    static let BaseUrl = "https://api.themoviedb.org/3/"
    static let Apikey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
}


class API: NSObject {
    
    public func getMovieList(paramters : Parameters ,result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        
        CallService(serviceName : .movieListing, parameters : paramters, method : .get ,encoding: URLEncoding.queryString) { responseObj in
            let Object = JSON(responseObj as Any)
            result(Object)
            
        } failure : { error in
            failure(error)
        }
    }
    

    public func getConfiguration(paramters : Parameters ,result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        
        CallService(serviceName : .configuration, parameters : paramters, method : .get ,encoding: URLEncoding.queryString) { responseObj in
            let Object = JSON(responseObj as Any)
            result(Object)
            
        } failure : { error in
            failure(error)
        }
    }
    
    public func getDetails(movieID:Int, paramters : Parameters ,result : @escaping ((_ responseObj : JSON?) -> Void), failure : @escaping ((_ error : String?) -> Void)){
        
        CallService(serviceName : .details(movieID), parameters : paramters, method : .get ,encoding: URLEncoding.queryString) { responseObj in
            let Object = JSON(responseObj as Any )
            result(Object)
            
        } failure : { error in
            failure(error)
        }
    }
}



func CallService(serviceName : APIEndPoint, parameters : Parameters, method : HTTPMethod , isShowloader:Bool = true, encoding: ParameterEncoding = URLEncoding.default, withSuccess : @escaping ((_ responseObj : JSONDictionary?) -> Void), failure : @escaping ((_ error : String?) -> Void)) {
    
    let pageUrlStr =  Config.BaseUrl + serviceName.value

    print("pageUrlStr :- ",pageUrlStr)
    print("parameters :- ",parameters)
    if isShowloader{
        showLoader()
    }
    AF.request(pageUrlStr, method : method, parameters : parameters, encoding : URLEncoding.queryString).responseJSON { response in
        switch response.result {
            
        case .success(let JSON):
            if var jsonDictionary = JSON as? JSONDictionary{
                jsonDictionary["statusCode"] = (response.response?.statusCode as AnyObject)
                withSuccess(jsonDictionary)
                
            }else{
                failure("Request failed with error")
            }
            if isShowloader {
                hideLoader()
            }
            break
        case .failure(let error):
            if error.responseCode == -1001 {
                print("TIME OUR ERROR")
            }
            failure("Request failed with error: \(error)")
            if isShowloader{
                hideLoader()
            }
            break
        }
    }
}


func stringArrayToData(stringArray: [String]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
}
func intArrayToData(stringArray: [Int]) -> Data? {
    return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
}
func stringDicToData(dic: JSONDictionary) -> Data? {
    return try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted)
}


//MARK: - Decodable
extension Decodable {
    init(from: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

extension JSON {
    func string(key:String) -> String{
        return self[key].stringValue
    }
    
    func double(key:String) -> Double{
        return self[key].doubleValue
    }
    
    func array(key:String) -> [JSON]{
        return self[key].arrayValue
    }
    
    func object(key:String) -> JSON{
        return JSON(rawValue: self[key].dictionaryValue) ?? [:]
    }
}
