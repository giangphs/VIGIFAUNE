//
//  GroupCreateOBJ.swift
//  NaturaSwift
//
//  Created by Manh on 7/21/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class GroupCreateOBJ: NSObject {
    static let sharedInstance = GroupCreateOBJ()
    
    var   group_id:String!;
    var   imgData:NSData!;
    var   strName:String!;
    var   strComment:String!;
    var   accessKind:ACCESS_KIND!;
    var   isModifi:Bool = false;
    var   listHuntAdmin:NSArray!;
    var   allow_add:Bool!;
    var   allow_show:Bool!;
    
    override init() {
        super.init();
    }
    func resetParams() {
        self.imgData        = nil;
        self.group_id       = "";
        self.strName        = "";
        self.strComment     = "";
        self.isModifi       = false;
        self.listHuntAdmin  = nil;
        self.allow_add      = false;
        self.allow_show     = false;
    }
    func modifiGroupWithVC(viewcontroller: UIViewController) {
        
    }
}