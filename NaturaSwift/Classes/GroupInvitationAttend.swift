//
//  GroupInvitationAttend.swift
//  NaturaSwift
//
//  Created by Manh on 7/20/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import SwiftyJSON
let GroupesCellID: String = "GroupesViewCellID";
class GroupInvitationAttend: GroupBaseVC {
    //MARK: - OUTLET
    @IBOutlet var lbZeroInvitaionGroup: UILabel!;
    //MARK: - VARIABLE
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int;
    var arrCategories: NSArray!;
    var arrGroupsIsAdmin: NSMutableArray  = NSMutableArray();
    var arrGroupsIsNormal: NSMutableArray = NSMutableArray();
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        lbZeroInvitaionGroup.text = str(strZeroInvitaionGroup);
        lbZeroInvitaionGroup.hidden = true;
        arrCategories = [str(strPersonnesEnAttenteDeVotreValidation), str(strVosDemandesDaccesEnAttent)];
        tableControl.registerNib(UINib.init(nibName: String(CellKind15), bundle: nil), forCellReuseIdentifier: GroupesCellID);
        //LOAD CACHE
        let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(sender_id)", str2: "GROUP_INVITATION_SAVE"));
        if let dicTmp: NSDictionary = NSDictionary(contentsOfFile: strPath)
        {
            if dicTmp.allKeys.count > 0 {
                if let arrValidations = dicTmp["validations"] as? NSArray
                {
                    self.arrGroupsIsAdmin.addObjectsFromArray(arrValidations as [AnyObject]);
                    
                }
                if let arrAccess = dicTmp["access"] as? NSArray
                {
                    self.arrGroupsIsNormal.addObjectsFromArray(arrAccess as [AnyObject]);
                }
                self.tableControl.reloadData();
                self.checkEmtry(self.arrGroupsIsAdmin.count + self.arrGroupsIsNormal.count);
            }
        }
        //LOAD API
        self.insertRowAtTop();

    }
    //MARK: - API
    func refreshGroupInvition() {
        let api:WebServiceAPI = WebServiceAPI();
        api.fnV2_GET_GROUP_INVITATION_ACITON() { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            self.arrGroupsIsAdmin.removeAllObjects();
            self.arrGroupsIsNormal.removeAllObjects();

            if let arrValidations = response["validations"] as? NSArray
            {
                self.arrGroupsIsAdmin.addObjectsFromArray(arrValidations as [AnyObject]);

            }
            if let arrAccess = response["access"] as? NSArray
            {
                self.arrGroupsIsNormal.addObjectsFromArray(arrAccess as [AnyObject]);
            }

            //SAVE CACHE
            if response.allKeys.count > 0
            {
                let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(self.sender_id)", str2: "GROUP_INVITATION_SAVE"));
                response.writeToFile(strPath, atomically: true);
            }

            self.tableControl.reloadData();
            self.checkEmtry(self.arrGroupsIsAdmin.count + self.arrGroupsIsNormal.count);
        }

    }
    //MARK: - FUNC
    override func insertRowAtTop() {
        self .refreshGroupInvition();
    }
    override func insertRowAtBottom() {
        self .refreshGroupInvition();
    }
    func checkEmtry(count: Int)  {
        if (count > 0) {
            lbZeroInvitaionGroup.hidden = true;
            
        }
        else
        {
            lbZeroInvitaionGroup.hidden = false;
        }
    }
    @IBAction func adminAcceptJoin(sender: UIButton)
    {
        let index: Int = sender.tag - 1;
        let dic = JSON(arrGroupsIsAdmin[index]);
        let api:WebServiceAPI = WebServiceAPI();
        var mykind: String = "";
        if self.expectTarget == ISSCREEN.ISGROUP {
            mykind = MYGROUP
        }
        else
        {
            mykind = MYCHASSE
        }
        api.fnPUT_JOIN_KIND_ACITON(mykind, mykind_id: dic["group"]["id"].stringValue, strUserID: dic["user"]["id"].stringValue) { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            
            if ((response["subscriber"] as? NSDictionary) != nil)
            {
                self.insertRowAtTop();
            }
        }

    }
    @IBAction func adminCancelJoin(sender: UIButton)
    {
        let index: Int = sender.tag - 2;
        let dic = JSON(arrGroupsIsAdmin[index]);
        let api:WebServiceAPI = WebServiceAPI();
        var mykind: String = "";
        if self.expectTarget == ISSCREEN.ISGROUP {
            mykind = MYGROUP
        }
        else
        {
            mykind = MYCHASSE
        }
        api.fnDELETE_JOIN_KIND_ACITON(mykind, mykind_id: dic["group"]["id"].stringValue, strUserID: dic["user"]["id"].stringValue) { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            
            if let success = response["success"] as? Int where success == 1
            {
                self.insertRowAtTop();
            }
        }
    }
    @IBAction func acceptJoin(sender: UIButton)
    {
        let index: Int = sender.tag - 1;
        let dic = JSON(arrGroupsIsNormal[index]);
        let api:WebServiceAPI = WebServiceAPI();
        var mykind: String = "";
        if self.expectTarget == ISSCREEN.ISGROUP {
            mykind = MYGROUP
        }
        else
        {
            mykind = MYCHASSE
        }
        api.fnPUT_GROUP_ACCEPT_INVITATION_ACITON(mykind, mykind_id: dic["id"].stringValue, strUserID: "\(sender_id)") { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            
            if let success = response["success"] as? Int where success == 1
            {
                let vc:GroupEnterMurVC = GroupEnterMurVC(nibName: String(GroupEnterMurVC), bundle: nil);
                vc.expectTarget = ISSCREEN.ISGROUP;
                
                GroupEnterOBJ.sharedInstance.resetParams();
                if let dic = self.arrGroupsIsAdmin.objectAtIndex(index) as? NSDictionary
                {
                    GroupEnterOBJ.sharedInstance.dictionaryGroup = dic;
                }
                
                self.pushVC(vc, expectTarget: ISSCREEN.ISGROUP, isChildTarget: true, iAmParent: false, animate: true);
            }
        }
        
    }
    @IBAction func cancelJoin(sender: UIButton)
    {
        let index: Int = sender.tag - 2;
        let dic = JSON(arrGroupsIsNormal[index]);
        let api:WebServiceAPI = WebServiceAPI();
        var mykind: String = "";
        if self.expectTarget == ISSCREEN.ISGROUP {
            mykind = MYGROUP
        }
        else
        {
            mykind = MYCHASSE
        }
        api.fnDELETE_GROUP_INVITATION_ACITON(mykind, mykind_id: dic["id"].stringValue, strUserID:"\(sender_id)") { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            
            if let success = response["success"] as? Int where success == 1
            {
                self.insertRowAtTop();
            }
        }
    }
    //MARK: - TABLE DELEGATE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            return arrGroupsIsAdmin.count;
        }
        else
        {
            return arrGroupsIsNormal.count;
        }
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if  (section == 0 && arrGroupsIsAdmin.count > 0) ||
            (section == 1 && arrGroupsIsNormal.count > 0){
            return 50;
        }
        return 0.0001;
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if  (section == 0 && arrGroupsIsAdmin.count > 0) ||
            (section == 1 && arrGroupsIsNormal.count > 0){
            let sectionView: UIView = UIView(frame: CGRectMake(0,0,320,50));
            sectionView.backgroundColor = UIColorFromRGB(MAIN_COLOR);
            let headerLabel: UILabel = UILabel(frame: CGRectMake(12,15,320,29));
            headerLabel.textColor = UIColor.blackColor();
            headerLabel.numberOfLines = 2;
            headerLabel.font = FONT_HELVETICANEUE_MEDIUM(12);
            headerLabel.text = arrCategories[section] as? String;
            sectionView.addSubview(headerLabel);
            return sectionView;
        }
        return nil;
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CellKind15 = tableView.dequeueReusableCellWithIdentifier(GroupesCellID, forIndexPath: indexPath) as! CellKind15;
        configureCell(cell, forRowAtIndexPath: indexPath);
        return cell;
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (cellTmp is CellKind15) {
            let cell: CellKind15 = cellTmp as! CellKind15;
            let dic: JSON!;
            var isAdmin: Bool = false;
            let index: Int = indexPath.row;
            if indexPath.section == 0 {
                isAdmin = true;
                let dicGroup = JSON(arrGroupsIsAdmin[index]);
                dic = JSON(dicGroup["group"].dictionary!);
                cell.nameGroup.text = dic["user"]["fullname"].stringValue;
                cell.contentGroup.text = "";
                cell.lbNameGroupAdmin.text = dic["name"].stringValue;
            }
            else
            {
                isAdmin = false;
                dic = JSON(arrGroupsIsNormal[index]);
                cell.nameGroup.text = dic["name"].stringValue;
                cell.contentGroup.text = dic["description"].stringValue;
                cell.lbNameGroupAdmin.text = "";

            }
            let accessType: NSString = dic["access"].stringValue;
            switch ACCESS_KIND(rawValue: Int(accessType as String)!)! {
            case ACCESS_KIND.ACCESS_PRIVATE:
                cell.accessType.text = str(strAccessPrivate);
                break;
            case ACCESS_KIND.ACCESS_SEMIPRIVATE:
                cell.accessType.text = str(strAccessSemiPrivate);
                break;
            case ACCESS_KIND.ACCESS_PUBLIC:
                cell.accessType.text = str(strAccessPublic);
                break;
            }
            if dic["nbSubscribers"].intValue == 1 {
                cell.numberMember.text = String(format: "%@ %@", dic["nbSubscribers"].stringValue,str(strMMembre));
            }
            else
            {
                cell.numberMember.text = String(format: "%@ %@s", dic["nbSubscribers"].stringValue,str(strMMembre));

            }
            
            if isAdmin {
                cell.btnValid.addTarget(self, action: #selector(adminAcceptJoin), forControlEvents: .TouchUpInside);
                cell.btnRefuse.addTarget(self, action: #selector(adminCancelJoin), forControlEvents: .TouchUpInside);
                
                cell.btnValid.hidden = false;
                cell.btnRefuse.hidden = false;
                cell.btnValid.setTitle(str(strValider), forState: .Normal);
                cell.btnRefuse.setTitle(str(strRefuser), forState: .Normal);

            }
            else
            {
                cell.btnValid.addTarget(self, action: #selector(acceptJoin), forControlEvents: .TouchUpInside);
                cell.btnRefuse.addTarget(self, action: #selector(cancelJoin), forControlEvents: .TouchUpInside);
                if dic["connected"]["access"].intValue == 0 {
                    cell.btnValid.hidden = false;
                    cell.btnRefuse.hidden = false;
                    cell.btnValid.setTitle(str(strValider), forState: .Normal);
                    cell.btnRefuse.setTitle(str(strRefuser), forState: .Normal);

                }
                else
                {
                    cell.btnValid.hidden = true;
                    cell.btnRefuse.hidden = false;
                    cell.btnRefuse.setTitle(str(strAnuler), forState: .Normal);

                }
            }
            cell.btnValid.tag  = indexPath.row + 1;
            cell.btnRefuse.tag = indexPath.row + 2;
        
            var strPhotoUrl = String(format: "%@%@", IMAGE_ROOT_API,dic["photo"].stringValue);
            strPhotoUrl = strPhotoUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
            let url: NSURL = NSURL(string: strPhotoUrl)!;
            
            let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
            cell.imgProfile.kf_setImageWithURL(url, placeholderImage: placeholder_avatar, optionsInfo:nil, progressBlock: { (receivedSize, totalSize) in
                
                }, completionHandler: { (image, error, cacheType, imageURL) in
                    
            })

            
        }
    }

}