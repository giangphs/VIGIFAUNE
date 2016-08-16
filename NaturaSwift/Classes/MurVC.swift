//
//  MurVC.swift
//  NaturaSwift
//
//  Created by Manh on 6/27/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class MurVC: MurBaseVC {
    //MARK: - VARIABLE
    @IBOutlet var viewContent: UIView!;
    @IBOutlet var lbMessage: UILabel!;
    @IBOutlet var warning: UILabel!;
    var publicationArray: NSMutableArray!;
    var isLiveHunt =  false;
    
    
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int

    
//    var sender_id:Int = Int(NSUserDefaults.standardUserDefaults().valueForKey("sender_id") as! NSNumber)
    var murView: MurView!;
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        publicationArray = NSMutableArray();        
        //add view mur
        murView = MurView.loadFromNibNamed("MurView") as? MurView;
        murView.instanceWithParent(self, expect: self.expectTarget);
        murView.callback = {
            (type: VIEW_ACTION_TYPE, arrData: NSArray) in
            
            switch type {
            case VIEW_ACTION_TYPE.VIEW_ACTION_REFRESH_TOP:
                //insert top
                break;
            case VIEW_ACTION_TYPE.VIEW_ACTION_REFRESH_BOTTOM:
                //insert bottom
                break;
            case VIEW_ACTION_TYPE.VIEW_ACTION_UPDATE_DATA:
                //update data
                break;
            }
        }
        murView.addContraintSupview(self.viewContent);
        self.fnOperationDoTop();
        

    }
    
    //MARK: - DATA
    func fnOperationDoTop() {
        let api:WebServiceAPI = WebServiceAPI();
        //FILTER OFF
        api.fnGET_PUBLICATION_FILTEROFF_WITHLIMIT("20", offset: "0") { (complete, code) in
            print(complete);
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if(response["publications"] is NSArray)
            {
                self.publicationArray.addObjectsFromArray(response["publications"] as! [AnyObject]);
                self.murView.fnSetDataPublication(self.publicationArray);
            }
        }
        //FILTER ON
//        api.fnGET_PUBLICATION_ACTIONS("50", offset: "0", strShareType: "", strGroupAppend: "") { (complete, code) in
//            
//        }
    }
}