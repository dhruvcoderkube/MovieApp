//
// Copyright (c) 2023 YASSIR. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
import Toast_Swift
import SDWebImage
import ObjectiveC
import Alamofire

var hud = JGProgressHUD(style: .dark)
let appdelgate = UIApplication.shared.delegate as! AppDelegate
var ConfigurationData = [Images]()

func showLoader() {
    hud.textLabel.text = "loading"
    hud.show(in: UIApplication.shared.windows.first!)
}

func hideLoader() {
    hud.dismiss(animated: true)
}

func makeBottomToast(strMessage : String){
    var style = ToastStyle()
    style.messageColor = .white
    appdelgate.window?.rootViewController?.view.makeToast(strMessage, duration: 3.0, position: .bottom, style: style)
    ToastManager.shared.style = style
    ToastManager.shared.isTapToDismissEnabled = true
    ToastManager.shared.isQueueEnabled = true
}

extension UIImageView {
    func getImage(url: String)
    {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if url != "" {
            self.sd_setImage(with: URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), placeholderImage:UIImage(named: "movie"), options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                if(error == nil){
                    self.image = image
                    self.updateHeight()
                }else {
                    print("error to getting image.")
                }
            })
        }
    }
    
    open func updateHeight(){
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio
            self.selfconstraintWithIdentifier("ImageHeight")?.constant = scaledHeight-1
        }
    }
    
    open func updateHeight(newvalue : UIImage) -> CGFloat{
        let myImageWidth = newvalue.size.width
        let myImageHeight = newvalue.size.height
        let myViewWidth = self.frame.size.width
        
        let ratio = myViewWidth/myImageWidth
        let scaledHeight = myImageHeight * ratio
        self.selfconstraintWithIdentifier("ImageHeight")?.constant = scaledHeight-1
        return scaledHeight-1
    }
    
    @objc func selfconstraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        return self.constraints.first {$0.identifier == identifier}
    }
}

func gettingConfigurations(){
    
    var apiKey = Parameters()
    apiKey["api_key"] = Config.Apikey
    
    API().getConfiguration(paramters: apiKey) { responseObj in
        let dataModel = ConFigurations(responseObj!)
        
        if let data =  dataModel.images{
            ConfigurationData.append(data)
        }
        
    } failure: { error in
        
    }
}

extension Dictionary{
    
    /// convert dictionary to json string
    ///
    /// - Returns: return value description
    func convertToJSonString() -> String {
        do {
            let dataJSon = try JSONSerialization.data(withJSONObject: self as AnyObject, options: JSONSerialization.WritingOptions.prettyPrinted)
            let st: NSString = NSString.init(data: dataJSon, encoding: String.Encoding.utf8.rawValue)!
            return st as String
        } catch let error as NSError { print(error) }
        return ""
    }
    
    
    /// check given key have value or not
    ///
    /// - Parameter stKey: pass key what you want check
    /// - Returns: true if exist
    func isKeyNull(_ stKey: String) -> Bool {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] { return val is NSNull ? true : false }
        return true
    }
    
    
    
    /// handal carsh when null valu or key not found
    ///
    /// - Parameter stKey: pass the key of object
    /// - Returns: blank string or value if exist
    func valueForKeyString(_ stKey: String) -> String {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return ""
            }else if (val as? NSNumber) != nil {
                return  val.stringValue
                
            }else if (val as? String) != nil {
                return val as! String
            }else{
                return ""
            }
        }
        return ""
    }
    
    ///expaned function of null value
    func valueForKeyString(_ stKey: String,nullvalue:String) -> String {
        return  self.valueForKeyWithNullString(Key: stKey, NullReplaceValue: nullvalue)
    }
    
    /// Update dic with other Dictionary
    ///
    /// - Parameter other: add second Dictionary which one you want to add
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    
    /// USE TO GET VALUE FOR KEY if key not found or null then replace with the string
    ///
    /// - Parameters:
    ///   - stKey: pass key of dic
    ///   - NullReplaceValue: set value what you want retun if that key is nill
    /// - Returns: retun key value if exist or return null replace value
    func valueForKeyWithNullString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    return  val.stringValue
                }else{
                    return val as! String == "" ? NullReplaceValue : val as! String
                }
            }
        }
        return NullReplaceValue
    }
    
    func valuForKeyWithNullWithPlaseString(Key stKey: String,NullReplaceValue:String) -> String {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return NullReplaceValue
            } else{
                if (val as? NSNumber) != nil {
                    if Int(truncating: val as! NSNumber) > 0{
                        return  "+" + val.stringValue
                    }
                }else{
                    if Int(val as! String) ?? 0 > 0{
                        return val as! String == "" ? NullReplaceValue : "+" + (val as! String)
                    }else{
                        return val as! String == "" ? NullReplaceValue : val as! String
                    }
                }
            }
        }
        return NullReplaceValue
    }
    
    func valuForKeyArray(_ stKey: String) -> Array<Any> {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return []
            } else if val is NSArray{
                return val as! Array<Any>
            } else if val is String{
                return [val] as Array<Any>
            }else {
                return val as! Array<Any>
            }
        }
        return []
    }
    
    /// dic
    /// - Parameter stKey: <#stKey description#>
    func valuForKeyDic(_ stKey: String) -> JSONDictionary {
        let dict: JSONDictionary = (self as AnyObject) as! JSONDictionary
        if let val = dict[stKey] {
            if val is NSNull{
                return JSONDictionary()
            } else if ((val as? JSONDictionary) != nil){
                return val as! JSONDictionary
            }
        }
        return JSONDictionary()
    }
    
    func valueForKeyInt( _ any:String) -> Int {
        return valueForKeyInt(any,nullValue: 0)
    }
    
    
    func valueForKeyInt( _ any:String,nullValue :Int) -> Int {
        var iValue: Int = 0
        let dict: JSONDictionary = self as! JSONDictionary
        if let val = dict[any] {
            if val is NSNull {
                return 0
            }
            else {
                if val is Int {
                    iValue = val as! Int
                }
                else if val is Double {
                    iValue = Int(val as! Double)
                }
                else if val is String {
                    let stValue: String = val as! String
                    iValue = (stValue as NSString).integerValue
                }
                else if val is Float {
                    iValue = Int(val as! Float)
                }else{
                    let error = NSError(domain:any,
                                        code: 100,
                                        userInfo:dict)
                }
            }
        }
        return iValue
    }
}

//MARK: - UITableView setup
extension UITableView{
    
    func setDataSourceDelegate(datasourceAndDelegate : NSObject, tableCellIdentifier : String? = "", tableCell : AnyClass?){
        datasourceAndDelegate.TableView = self
        if let datasource = datasourceAndDelegate as? UITableViewDataSource{
            self.dataSource = datasource
        }
        
        if let delegate = datasourceAndDelegate as? UITableViewDelegate{
            self.delegate = delegate
        }
        
        if tableCellIdentifier != "" {
            self.register(tableCell, forCellReuseIdentifier: tableCellIdentifier!)
        }
    }
    
    func getDataSourceandDeleget() -> NSObject{
        return self.dataSource as! NSObject
    }
}


private var AssociatedObjectHandle: UInt8 = 0
var TableObejctHandel = "TABLEVIEWHANDAL"

extension NSObject {
    
    var CollectionView: UICollectionView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? UICollectionView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var TableView: UITableView? {
        get {
            return objc_getAssociatedObject(self, &TableObejctHandel) as? UITableView
        }
        set {
            objc_setAssociatedObject(self, &TableObejctHandel, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIView{
    /// provide parent view controller of given view return first view controller from views
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}

extension UIView {
    func makeSecure() {
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            self.addSubview(field)
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }
}

class SecureView: UIView {
    
    // placeholder will become visible when user try to capture screenshot
    // or try to record the screen
    private(set) var placeholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    // add your content in this view
    // it will be secure
    private(set) var contentView: UIView = {
        let hiddenView = UIView()
        hiddenView.makeSecure()
        hiddenView.translatesAutoresizingMaskIntoConstraints = false
        return hiddenView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        
        self.addSubview(placeholderView)
        self.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            placeholderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            placeholderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            placeholderView.topAnchor.constraint(equalTo: self.topAnchor),
            placeholderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
