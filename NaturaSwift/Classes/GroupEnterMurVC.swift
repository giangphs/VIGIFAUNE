//
//  GroupEnterMurVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/18/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class GroupEnterMurVC: GroupEnterBaseVC {
    //MARK: - OUTLET
   @IBOutlet var btnCreateEnterGroup: UIButton!;
    @IBOutlet var lbMessage: UILabel!;
    @IBOutlet var viewContent: UIView!;
    //MARK: - VARIABLE
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    var murView: MurView!;
    var str_Id: String = "";
    var publicGroupArray: NSMutableArray = NSMutableArray();
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        if GroupEnterOBJ.sharedInstance.dictionaryGroup != nil {
            
            str_Id = String(GroupEnterOBJ.sharedInstance.dictionaryGroup.objectForKey("id") as! Int);
        }
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
        //
        getGroupPublications();
    }
    //MARK: - ACTION
    func getGroupPublications() {
       var strMykind: String  = "";
        if self.expectTarget == ISSCREEN.ISGROUP {
            strMykind = "groups";
        }
        else
        {
            strMykind = "hunts";
        }
        let api:WebServiceAPI = WebServiceAPI();
        //FILTER OFF
        api.fnGET_GROUP_PUBLICATION_ACITON(str_Id, limit: "10", offset: "0", myKind: strMykind) { (complete, code) in
            print(complete);
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if let arrGroups = response["publications"] as? NSArray
            {
                self.publicGroupArray.removeAllObjects();
                self.publicGroupArray.addObjectsFromArray(arrGroups as [AnyObject]);
                
//                let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(self.sender_id)", str2: FILE_GROUP_MUR_SAVE));
//                self.publicGroupArray.writeToFile(strPath, atomically: true);
                self.murView.fnSetDataPublication(self.publicGroupArray);
            }

        }


    }
}