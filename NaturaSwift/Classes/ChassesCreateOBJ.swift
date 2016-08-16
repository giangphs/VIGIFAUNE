//
//  ChassesCreateOBJ.swift
//  NaturaSwift
//
//  Created by Giang on 7/22/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class ChassesCreateOBJ: NSObject {
    static let sharedInstance = ChassesCreateOBJ()
    
    
    var   strName:NSString!
    var   strComment:NSString!
    var   strFin:NSString!
    var   strDebut:NSString!
    var   imgData:NSData!
    var   strID:NSString!
    var   accessKind:ACCESS_KIND!
    var    isModifi:Bool!
    var    isMurPass:Bool!
    
    var   latitude:NSString!
    var   longitude:NSString!
    var   address:NSString!
    var   listGroupAdmin:NSArray!
    var   attachment:NSDictionary!
    
    //id of group to involve join
    var   group_id_involve:NSString!
    
    var   allow_add:Bool!
    var   allow_show:Bool!
    
    var   allow_chat_add:Bool!
    var   allow_chat_show:Bool!
    
    override init() {
        super.init();
    }
    
    func resetParams() {
        imgData             = nil;
        strID               = "";
        strName             = "";
        strComment          = "";
        isModifi            = false;
        strFin              = ""
        strDebut            = ""
        isMurPass           = false
        latitude            = ""
        longitude           = ""
        address             = ""
        attachment          = nil
        listGroupAdmin      = nil;
        allow_add           = false;
        allow_show          = false;
        allow_chat_add      = false;
        allow_chat_show     = false;
        
    }
    func modifiChassesWithVC(viewcontroller: UIViewController) {
        
    }
    
    func fnSetData(dic:NSDictionary) {
    }
}