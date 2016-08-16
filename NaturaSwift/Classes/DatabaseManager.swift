//
//  DatabaseManager.swift
//  NaturaSwift
//
//  Created by Manh on 5/26/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import FMDB
class DatabaseManager: NSObject {
    static let sharedInstance = DatabaseManager()

    var queue: FMDatabaseQueue = FMDatabaseQueue();
    
    let BatabaseQueue: NSOperationQueue = NSOperationQueue();
    

    override init() {
        super.init();
        
        let bundlePath = NSBundle.mainBundle().pathForResource("NaturaDB", ofType: "db")
        
        FileHelper.sharedInstance.copyFileFrom(bundlePath!, to: "NaturaDB.db")
        
         let path1 = FileHelper.sharedInstance.documentDir!.stringByAppendingPathComponent("NaturaDB.db")
        print("\(path1)")
        
        queue = FMDatabaseQueue.init(path: path1);
    }
    
    
    
}