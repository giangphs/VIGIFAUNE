//
//  LoginVC.swift
//  NaturaSwift
//
//  Created by Giang on 6/24/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginVC: UIViewController, MPGTextFieldDelegate, UITextFieldDelegate {
    
    var listSuggestion : NSMutableArray = []
    
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfUsername: MPGTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tfUsername.delegate = self
        
        if let arr = NSUserDefaults.standardUserDefaults().objectForKey("userinfo") {
            self.listSuggestion = arr as! NSMutableArray
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func dataForPopoverInTextField(textField: MPGTextField!) -> [AnyObject]! {
        return self.listSuggestion as [AnyObject]
    }
    
    func textFieldShouldSelect(textField: MPGTextField!) -> Bool {
        return true
    }
    
    func textField(textField: MPGTextField!, didEndEditingWithSelection result: [NSObject : AnyObject]!) {
        if let str = result["pwd"] where str.length > 0{
            tfPassword.text = result["pwd"] as? String
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fnLogin(sender: AnyObject) {
        
        let strPassword: String = "\(SHA1_KEY)\(tfPassword.text!)"
        let api:WebServiceAPI = WebServiceAPI();
        api.fnGET_REAL_LOGIN( tfUsername.text!, password: strPassword.SHA1() , pushToken: "1e7da48ebacb6f1e8b8e73937ffc91520029efc6d1982f499907faf743c7381d") { (responseData, code) in
            
            
            print("\(responseData)")
            
            guard let dicUser = responseData as? NSDictionary else{
                
                print("err")
                return
            }
            
            print(dicUser["user"]!["id"])
            if let u1 = dicUser["user"], u2 = u1["id"]!{
                
                let mutDic: NSMutableDictionary = u1.mutableCopy() as! NSMutableDictionary

                let localArr : NSMutableArray = []
                
                mutDic["pwd"] = self.tfPassword.text
                
                localArr.addObject(mutDic)
                
                NSUserDefaults.standardUserDefaults().setObject(localArr, forKey: "userinfo")
                NSUserDefaults.standardUserDefaults().synchronize()
                
//                if let arr = NSUserDefaults.standardUserDefaults().objectForKey("userinfo") {
//                    self.listSuggestion.arrayByAddingObjectsFromArray(arr as! [AnyObject])
//                    
//                }
                
                NSUserDefaults.standardUserDefaults().setObject(u2, forKey: "userID")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.gotoApplication()
                
                
            }
            
        }
        
    }
    
    
}
