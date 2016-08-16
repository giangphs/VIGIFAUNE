//
//  MapDataDownloader.swift
//  NaturaSwift
//
//  Created by Manh on 5/26/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import FMDB
typealias callBackDone = (result: AnyObject?, code: Int)->Void;
class MapDataDownloader: NSObject {
    var operationQueue: NSOperationQueue = NSOperationQueue();
    var CallBack: callBackDone = {_,_ in };
    static var isFinish = false;
    override init() {
        super.init()
        operationQueue = NSOperationQueue()
        MapDataDownloader.isFinish = true
    }
    
    static let sharedInstance = MapDataDownloader()
    
    
    func doOperation(myArrType: NSArray) {
        
        DatabaseManager.sharedInstance.queue.inTransaction {
            (db, rollback) in
            
            do {
                let strQuerry: String = String.init(format: "SELECT version FROM tb_db_version ORDER BY version DESC LIMIT 1")
                let set_querry: FMResultSet =  try db!.executeQuery(strQuerry, values: nil)
                var strMaxVersion: String = "0"
                
                while(set_querry.next())
                {
                    strMaxVersion = set_querry.stringForColumn("version")
                }
                
                let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
                
                var strCUPDATEDPublication: String = "0"
                var strCUPDATEDShape: String = "0"
                var strCUPDATEDDistribution: String = "0"
                var strCUPDATEDGroup: String = "0"
                var strCUPDATEDHunt: String = "0"
                var strCUPDATEDFavPublication: String = "0"
                
                
                //has c_updated
                
                let set_querry1: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_updated from tb_carte WHERE c_user_id=\(sender_id) ORDER BY c_updated DESC LIMIT 1"), values: nil)
                
                while(set_querry1.next())
                {
                    strCUPDATEDPublication = (set_querry1.stringForColumn("c_updated") != nil ? set_querry1.stringForColumn("c_updated") : "0")
                }
                
                //DISTRIBUTION
                let set_querry2: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_updated from tb_distributor ORDER BY c_updated DESC LIMIT 1"), values: nil)
                
                while(set_querry2.next())
                {
                    strCUPDATEDDistribution = (set_querry2.stringForColumn("c_updated") != nil ? set_querry2.stringForColumn("c_updated") : "0")
                }
                
                
                //DISTRIBUTION
                let set_querry3: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_updated from tb_shape WHERE c_user_id=\(sender_id) ORDER BY c_updated DESC LIMIT 1"), values: nil)
                
                while(set_querry3.next())
                {
                    strCUPDATEDShape = (set_querry3.stringForColumn("c_updated") != nil ? set_querry3.stringForColumn("c_updated") : "0")
                }
                
                //GROUP
                let set_querry4: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_updated from tb_group WHERE c_user_id=\(sender_id) ORDER BY c_updated DESC LIMIT 1"), values: nil)
                
                while(set_querry4.next())
                {
                    strCUPDATEDGroup = (set_querry4.stringForColumn("c_updated") != nil ? set_querry4.stringForColumn("c_updated") : "0")
                }
                
                //HUNT
                let set_querry5: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_updated from tb_hunt WHERE c_user_id=\(sender_id) ORDER BY c_updated DESC LIMIT 1"), values: nil)
                
                while(set_querry5.next())
                {
                    strCUPDATEDHunt = (set_querry5.stringForColumn("c_updated") != nil ? set_querry5.stringForColumn("c_updated") : "0")
                }
                
                //favorite publication
                let set_querry6: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_updated from tb_favorite WHERE c_user_id=\(sender_id) ORDER BY c_updated DESC LIMIT 1"), values: nil)
                
                while(set_querry6.next())
                {
                    strCUPDATEDFavPublication = (set_querry6.stringForColumn("c_updated") != nil ? set_querry6.stringForColumn("c_updated") : "0")
                }

                //get IDS with update=0
                
                var strCID:String = ""
                
                let set_querry7: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_id FROM tb_carte  WHERE c_user_id=\(sender_id) AND c_updated=0"), values: nil)
                
                while(set_querry7.next())
                {
                    strCID = (set_querry7.stringForColumn("c_id") != nil ? set_querry7.stringForColumn("c_id") : "0")
                }
                
                
                //2
                var strCIDGroup:String = ""
                
                let set_querry8: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_id FROM tb_group  WHERE c_user_id=\(sender_id) AND c_updated=0"), values: nil)
                
                while(set_querry8.next())
                {
                    strCIDGroup = (set_querry8.stringForColumn("c_id") != nil ? set_querry8.stringForColumn("c_id") : "0")
                }
                
                //3
                var strCIDHunt:String = ""
                
                let set_querry9: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_id FROM tb_hunt  WHERE c_user_id=\(sender_id) AND c_updated=0"), values: nil)
                
                while(set_querry9.next())
                {
                    strCIDHunt = (set_querry9.stringForColumn("c_id") != nil ? set_querry9.stringForColumn("c_id") : "0")
                }
                
                //4
                var strCIDFavPublication:String = ""
                
                let set_querry10: FMResultSet = try db!.executeQuery(String.init(format: "SELECT c_id FROM tb_favorite  WHERE c_user_id=\(sender_id) AND c_updated=0"), values: nil)
                
                while(set_querry10.next())
                {
                    strCIDFavPublication = (set_querry10.stringForColumn("c_id") != nil ? set_querry10.stringForColumn("c_id") : "0")
                }
                
                //setting param
                var param = [String: AnyObject]()
                
                var pushToken = NSUserDefaults.standardUserDefaults().objectForKey("DEVICETOKEN") as? String
                
                if(pushToken == nil)
                {
                    pushToken = "1e7da48ebacb6f1e8b8e73937ffc91520029efc6d1982f499907faf743c7381d"
                }
                
                param["identifier"] = pushToken
                param["version"] = ["version": strMaxVersion]

                for str in myArrType{
                    
                    switch (str as! String)
                    {
                    case kSQL_publication:
                        
                        param["publication"] = ["ids":strCID, "updated": strCUPDATEDPublication]
                        
                    case kSQL_shape:
                        param["shape"] = ["updated": strCUPDATEDShape]
                        
                    case kSQL_group:
                        param["group"] = ["ids":strCIDGroup, "updated": strCUPDATEDGroup]
                        
                    case kSQL_hunt:
                        param["hunt"] = ["ids":strCIDHunt, "updated": strCUPDATEDHunt]
                        
                    case kSQL_distributor:
                        param["distributor"] = ["updated": strCUPDATEDDistribution]
                        
                    case kSQL_address:
                        param["address"] = ["reload": "1"]
                        
                    case kSQL_favorite:
                        param["favorite"] = ["ids":strCIDFavPublication, "updated": strCUPDATEDFavPublication]
                        
                    case kSQL_breed:
                        param["breed"] = ["reload": "1"]
                    case kSQL_type:
                        param["type"] = ["reload": "1"]
                    case kSQL_brand:
                        param["brand"] = ["reload": "1"]
                    case kSQL_calibre:
                        param["calibre"] = ["reload": "1"]
                        
                    default: break
                    }
                    
                }

                let api:WebServiceAPI = WebServiceAPI();
                
                api.PUT_SQLITE_ALL_POINTS_IN_MAP_WITHPARAM(param, complete: { (response, code) in
                    print(response);
                    
                    guard let arrVersions = response["versions"] as? NSArray else{
                        
                        print("err")
                        return
                    }
                    
                    //update version database
                    DatabaseManager.sharedInstance.queue.inTransaction {
                        (db, rollback) in
                        
                        for mDic in arrVersions
                        {
                            print("\(mDic)")
                            
                            for cmd in mDic["sqlite"] as! NSArray
                            {
                                do{
                                    try db.executeUpdate(cmd as! String  , values: nil)
                                }
                                catch {
                                    print(error)
                                }
                                print("update column")
                                
                            }
                            
                            do{
                                try db.executeUpdate("INSERT INTO `tb_db_version`(`version`) VALUES ('\(mDic["version"] as! String ) ');"  , values: nil)
                            }
                            catch {
                                print(error)
                            }
                        }
                        
                    }
                    
                    guard let sql = response["sqlite"] as? [String: AnyObject], let arrSqlPublications = sql["publications"] as? NSArray else{
                        
                        print("err")
                        return
                    }
                    
                    DatabaseManager.sharedInstance.queue.inTransaction {
                        (db, rollback) in
                        
                        for str in arrSqlPublications
                        {
                            print("update data")
                            
                            
                            do{
                                try db.executeUpdate(str as! String  , values: nil)
                            }
                            catch {
                                print(error)
                            }
                            
                        }
                        
                        
                    }
                })
                //
            } catch {
                print(error)
            }
        }
        
        
    }
    
    func resetParam() {
        MapDataDownloader.isFinish = true;
    }
    
    func fnGetSqliteForAllPointsInMap(myArrType: NSArray) {
        if MapDataDownloader.isFinish {
            MapDataDownloader.isFinish = false;
            
            doOperation(myArrType)
            
            //            self.performSelector(#selector(MapDataDownloader.resetParam), withObject: nil, afterDelay: 180);
            //                operationQueue.addOperationWithBlock({
            //
            //                });
        }
    }
    
}