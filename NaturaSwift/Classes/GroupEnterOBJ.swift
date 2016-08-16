//
//  GroupEnterOBJ.swift
//  NaturaSwift
//
//  Created by Manh on 7/18/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class GroupEnterOBJ: NSObject {
    var dictionaryGroup: NSDictionary!;
    static let sharedInstance = GroupEnterOBJ()
    override init() {
        super.init();
    }
    func resetParams()  {
        dictionaryGroup = nil;
    }
}