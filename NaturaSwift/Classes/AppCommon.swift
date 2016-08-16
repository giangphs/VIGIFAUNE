//
//  AppCommon.swift
//  NaturaSwift
//
//  Created by Manh on 5/26/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class AppCommon: NSObject {
    static var countNetworkIssue: Int = 0;
    static func common() ->AppCommon
    {
        
        struct Static
        {
            static var  once: dispatch_once_t = 0;
            static var instance: AppCommon? = nil;
        }
        dispatch_once(&Static.once)
        {
            Static.instance = AppCommon();
            countNetworkIssue = 0;
        }
        return Static.instance!;
    }
    
    func getUserId() -> String {
        var strUserId: String = "";
        if NSUserDefaults.standardUserDefaults().valueForKey("sender_id") != nil {
            strUserId = "\(NSUserDefaults.standardUserDefaults().valueForKey("sender_id"))";
        }
        return strUserId;
        
    }
    
    
}
