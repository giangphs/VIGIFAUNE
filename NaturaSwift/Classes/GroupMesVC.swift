//
//  GroupMesVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/15/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import SwiftyJSON
let GroupesCellAdmin: String = "GroupesViewCellAdmin";
let GroupesCellID1: String = "GroupesViewCellID1";
let GroupesCellNormal: String = "GroupesViewCellNormal";
let GroupesCellID2: String = "GroupesViewCellID2";

class GroupMesVC: GroupBaseVC {
    //MARK: - OUTLET
    @IBOutlet var lbTitle: UILabel!;
    @IBOutlet var toussearchBar: UISearchBar!;
    @IBOutlet var btnCreateGroup: UIButton!;
    @IBOutlet var lbMessage: UILabel!;
    //MARK: - VARIABLE
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    var groupsActionArray:NSMutableArray = NSMutableArray();
    var groupsActionArrayTmp:NSMutableArray = NSMutableArray();
    var groupsActionArraySearch:NSMutableArray = NSMutableArray();
    var shouldBeginEditing: Bool = false;
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        lbTitle.text = str(strMESGROUPES);
        lbMessage.text = EMPTY_GROUP_MES;
        toussearchBar.placeholder = str(strSearchGroup);
        toussearchBar.tintColor = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
        //init tableviewcell
        tableControl.registerNib(UINib.init(nibName: String(GroupesCellAdmin), bundle: nil), forCellReuseIdentifier: GroupesCellID1);
        tableControl.registerNib(UINib.init(nibName: String(GroupesCellNormal), bundle: nil), forCellReuseIdentifier: GroupesCellID2);
        
        let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(sender_id)", str2: FILE_GROUP_MUR_SAVE));
        if let arrTmp: NSArray = NSArray(contentsOfFile: strPath)
        {
            if arrTmp.count > 0 {
                groupsActionArray.addObjectsFromArray(arrTmp as [AnyObject]);
                if !shouldBeginEditing {
                    groupsActionArrayTmp = groupsActionArray.mutableCopy() as! NSMutableArray;
                }
                tableControl.reloadData();
            }
        }

        insertRowAtTop();
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
    //MARK: FUNC
    func checkEmpty(arr: NSMutableArray, msg: String) {
        if arr.count > 0 {
            self.lbMessage.hidden =  true;
        }
        else
        {
            lbMessage.text = msg;
            lbMessage.setNeedsDisplay();
            lbMessage.hidden = false;
            view.bringSubviewToFront(lbMessage);
        }
    }
    func goLoungesSearchURL(encodeString: String, offset: String) {
        let api:WebServiceAPI = WebServiceAPI();
        api.fnGET_MYGROUP_ACITON(encodeString, limit: "20", offset: offset) { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if let arrGroups = response["groups"] as? NSArray
            {
                if Int(offset) == 0
                {
                    self.groupsActionArraySearch.removeAllObjects();
                }
                for dicGroup in arrGroups
                {
                    self.groupsActionArraySearch.addObject(dicGroup);
                }
                self.groupsActionArray = self.groupsActionArraySearch.mutableCopy() as! NSMutableArray;
            }
            else
            {
                // show KSToastView
            }
            
        }

    }
    func getItemWithKind(myid: String)  {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        let api:WebServiceAPI = WebServiceAPI();
        api.fnGET_ITEM_WITH_KIND("groups", myKind: myid) { (complete, code) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if let dicGroup = response["group"] as? NSDictionary
            {
                var i: Int = 0;
                for dic in self.groupsActionArray
                {
                    if dicGroup["id"]?.integerValue == dic["id"]?!.integerValue
                    {
                        self.groupsActionArray.replaceObjectAtIndex(i, withObject: dicGroup);
                        if !self.shouldBeginEditing
                        {
                            self.groupsActionArrayTmp = self.groupsActionArray.mutableCopy() as! NSMutableArray;
                        }
                        let indexArray: NSArray = self.tableControl.indexPathsForVisibleRows!;
                        self.tableControl.reloadRowsAtIndexPaths(indexArray as! [NSIndexPath], withRowAnimation: .None);
                    }
                    i = i + 1;
                }
            }
        }

    }
    @IBAction func onMakePublication(sender: UIButton)
    {
        GroupCreateOBJ.sharedInstance.resetParams();
        let viewcontroller1: GroupCreate_Step1 = GroupCreate_Step1(nibName: "GroupCreate_Step1", bundle: nil);
        self.pushVC(viewcontroller1, expectTarget: self.expectTarget, isChildTarget: false, iAmParent: false, animate: true);
    }
    //MARK: - TABLE
    override func insertRowAtTop() {
        let api:WebServiceAPI = WebServiceAPI();
        api.fnGET_MYGROUP_ACITON("", limit: "10", offset: "0") { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if let arrGroups = response["groups"] as? NSArray
            {
                self.groupsActionArray.removeAllObjects();
                self.groupsActionArray.addObjectsFromArray(arrGroups as [AnyObject]);
                if !self.shouldBeginEditing {
                    self.groupsActionArrayTmp = self.groupsActionArray.mutableCopy() as! NSMutableArray;
                }
                self.tableControl.reloadData();
                
                let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(self.sender_id)", str2: FILE_GROUP_MUR_SAVE));
                self.groupsActionArray.writeToFile(strPath, atomically: true);
            }
            self.checkEmpty(self.groupsActionArray, msg: EMPTY_GROUP_MES);

        }


    }
    override func insertRowAtBottom() {
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return groupsActionArray.count;
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let dic = JSON(groupsActionArray[indexPath.section])["connected"];
        var m_userKind: USER_KIND = USER_KIND.USER_NORMAL;
        
        if let access: Int = dic["access"].intValue where access == 3
        {
            m_userKind = USER_KIND.USER_ADMIN;
        }
        
        if m_userKind ==  USER_KIND.USER_ADMIN {
            let cell: GroupesViewCellAdmin = tableView.dequeueReusableCellWithIdentifier(GroupesCellID1, forIndexPath: indexPath) as! GroupesViewCellAdmin;
            configureCell(cell, forRowAtIndexPath: indexPath);
            return cell;
        }
        else
        {
            let cell: GroupesViewCellNormal = tableView.dequeueReusableCellWithIdentifier(GroupesCellID2, forIndexPath: indexPath) as! GroupesViewCellNormal;
            configureCell(cell, forRowAtIndexPath: indexPath);
            return cell;

        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {

    }
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (cellTmp is GroupesViewBaseCell) {
            let cell: GroupesViewBaseCell = cellTmp as! GroupesViewBaseCell;
            let dic = JSON(groupsActionArray[indexPath.section]);
            let accessType: Int = dic["access"].intValue;
            let strDescription: String = dic["description"].stringValue;
            let strName = dic["name"].stringValue;
            let nbPending = dic["nbPending"].intValue;
            let nbSubscribers = dic["nbSubscribers"].intValue;
            let strOwner: String = String(format: "%@ %@", dic["owner"]["firsname"].stringValue,dic["owner"]["lastname"].stringValue);
            var strPhotoUrl = dic["photo"].stringValue;
            var m_userKind: USER_KIND = USER_KIND.USER_NORMAL;
            if let connectedDict:[String:JSON] = dic["connected"].dictionaryValue {
                switch connectedDict["access"]!.intValue {
                case 0:
                    m_userKind = USER_KIND.USER_INVITED;
                    break;
                case 1:
                    m_userKind = USER_KIND.USER_WAITING_APPROVE;
                    break;
                case 2:
                    m_userKind = USER_KIND.USER_NORMAL;
                    break;
                case 3:
                    m_userKind = USER_KIND.USER_ADMIN;
                    break;
                default:
                    break;
                }
            }
            
            var attStrAdminGroup: NSMutableAttributedString = NSMutableAttributedString();
            let str1: NSMutableAttributedString = NSMutableAttributedString(string: String(format: "%@ ", str(strAdministre_par)));
            let str2: NSMutableAttributedString = NSMutableAttributedString(string: "Vous ");
            let str3: NSMutableAttributedString = NSMutableAttributedString(string: "et ");
            let str4: NSMutableAttributedString = NSMutableAttributedString(string: strOwner);
            
            str1.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12.0), range: NSMakeRange(0, str1.length - 1));
            str2.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12.0), range: NSMakeRange(0, str2.length - 1));
            str3.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12.0), range: NSMakeRange(0, str3.length - 1));
            str4.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(12.0), range: NSMakeRange(0, str4.length - 1));
            if m_userKind == USER_KIND.USER_ADMIN {
                str1.appendAttributedString(str2);
            }
            else
            {
                str1.appendAttributedString(str4);
            }
            attStrAdminGroup = str1;
            
            if m_userKind == USER_KIND.USER_ADMIN {
                //Enter
                cell.btnEnterGroup.tag = 1000 + indexPath.section;
                cell.btnEnterGroup.addTarget(self, action: #selector(enterGroupMurAction), forControlEvents: .TouchUpInside);
                
                cell.btnLabel.tag = 1000 + indexPath.section;
                cell.btnLabel.addTarget(self, action: #selector(enterGroupMurAction), forControlEvents: .TouchUpInside);
                //btn Validation
                cell.btnValidation.tag = 4000 + indexPath.section;
                cell.btnValidation.addTarget(self, action: #selector(enterGroupValidationAction), forControlEvents: .TouchUpInside);
                //btn admin
                cell.btnAdminstrator.tag = 3100 + indexPath.section;
                cell.btnAdminstrator.addTarget(self, action: #selector(enterGroupInfoAction), forControlEvents: .TouchUpInside);
                //btn email notify
                cell.btnEmailNotify.tag = 4100 + indexPath.section;
                cell.btnEmailNotify.addTarget(self, action: #selector(doEmailNotify), forControlEvents: .TouchUpInside);
                
                if dic["connected"]["mailable"].intValue == 1 {
                    cell.checkbox.selected = true;
                    cell.btnEmailNotify.selected = true;
                }
                else
                {
                    cell.checkbox.selected = false;
                    cell.btnEmailNotify.selected = false;
                }
                cell.checkbox.setTypeCheckBox(UI_TYPE.UI_GROUP_MUR_ADMIN);
                cell.createMenuList([str(strAdministrer), str(strFermer_le_groupe)]);
                cell.btnSetting.tag = 5000 + indexPath.section;
                cell.btnSetting.addTarget(self, action: #selector(showMenuPopOver), forControlEvents: .TouchUpInside);
                cell.lblAdminGroup.attributedText = attStrAdminGroup;
                cell.txtDescription.text = strDescription;
                cell.layoutIfNeeded();
                cell.lblName.text = strName;
                if nbPending > 0 {
                    cell.lblNbPending.hidden = false;
                    cell.imgMember.hidden = false;
                    cell.btnValidation.hidden = false;
                }
                else
                {
                    cell.lblNbPending.hidden = true;
                    cell.imgMember.hidden = true;
                    cell.btnValidation.hidden = true;

                }
                if nbPending == 0 {
                    cell.lblNbPending.hidden = true;
                }
                else if (nbPending > 1)
                {
                    cell.lblNbPending.text = String(format:"%d %@",nbPending,str(strPersonnes_en_attente_de_validation));
                }
                else
                {
                    cell.lblNbPending.text = String(format:"%d %@",nbPending,str(strPersonne_en_attente_de_validation));
                }
                
                if accessType == 0 {
                    cell.lblAccess.text = str(strAccessPrivate);
                }
                else if(accessType == 1)
                {
                    cell.lblAccess.text = str(strAccessSemiPrivate);

                }
                else if(accessType == 2)
                {
                    cell.lblAccess.text = str(strAccessPublic);
                }
                strPhotoUrl = strPhotoUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
                let url: NSURL = NSURL(string: strPhotoUrl)!;
                
                let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
                cell.imgViewAvatar.kf_setImageWithURL(url, placeholderImage: placeholder_avatar, optionsInfo:nil, progressBlock: { (receivedSize, totalSize) in
                    
                    }, completionHandler: { (image, error, cacheType, imageURL) in
                        
                })
                cell.fnSettingCell(UI_TYPE.UI_GROUP_MUR_ADMIN);

            }
            else
            {
                //Enter
                cell.btnEnterGroup.tag = 1000 + indexPath.section;
                cell.btnEnterGroup.addTarget(self, action: #selector(enterGroupMurAction), forControlEvents: .TouchUpInside);
                
                cell.btnLabel.tag = 1000 + indexPath.section;
                cell.btnLabel.addTarget(self, action: #selector(enterGroupMurAction), forControlEvents: .TouchUpInside);
                //leave / un-subscribe
                cell.btnUnsubscribe.tag = 3000 + indexPath.section;
                cell.btnUnsubscribe.addTarget(self, action: #selector(unSubscribeGroupAction), forControlEvents: .TouchUpInside);
                //btn email notify
                cell.btnEmailNotify.tag = 4100 + indexPath.section;
                cell.btnEmailNotify.addTarget(self, action: #selector(doEmailNotify), forControlEvents: .TouchUpInside);
                if dic["connected"]["mailable"].intValue == 1 {
                    cell.checkbox.selected = true;
                    cell.btnEmailNotify.selected = true;
                }
                else
                {
                    cell.checkbox.selected = false;
                    cell.btnEmailNotify.selected = false;
                }
                cell.checkbox.setTypeCheckBox(UI_TYPE.UI_GROUP_MUR_ADMIN);

//                cell.lblAdminGroup.attributedText = attStrAdminGroup;
                cell.txtDescription.text = strDescription;
                cell.layoutIfNeeded();
                cell.lblName.text = strName;
                if accessType == 0 {
                    cell.lblAccess.text = str(strAccessPrivate);
                }
                else if(accessType == 1)
                {
                    cell.lblAccess.text = str(strAccessSemiPrivate);
                    
                }
                else if(accessType == 2)
                {
                    cell.lblAccess.text = str(strAccessPublic);
                }
                strPhotoUrl = strPhotoUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
                let url: NSURL = NSURL(string: strPhotoUrl)!;
                
                let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
                cell.imgViewAvatar.kf_setImageWithURL(url, placeholderImage: placeholder_avatar, optionsInfo:nil, progressBlock: { (receivedSize, totalSize) in
                    
                    }, completionHandler: { (image, error, cacheType, imageURL) in
                        
                })
                cell.fnSettingCell(UI_TYPE.UI_GROUP_MUR_NORMAL);

            }
            if nbSubscribers == 1 {
                cell.lblNbSubcribers.text = String(format: "%d %@", nbSubscribers,str(strMMembre));
            }
            else
            {
                cell.lblNbSubcribers.text = String(format: "%d %@s", nbSubscribers,str(strMMembre));
            }
            
        }
    }
    @IBAction func enterGroupMurAction(sender: UIButton)
    {
        let tag: Int = sender.tag;
        var index: Int = 0;
        //admin
        if tag < 2000 {
            index = tag - 1000;
        }
        //normal
        else
        {
            index = tag - 2000;
        }

        let vc:GroupEnterMurVC = GroupEnterMurVC(nibName: String(GroupEnterMurVC), bundle: nil);
        vc.expectTarget = ISSCREEN.ISGROUP;
        
        GroupEnterOBJ.sharedInstance.resetParams();
        if let dic = groupsActionArray.objectAtIndex(index) as? NSDictionary
        {
            GroupEnterOBJ.sharedInstance.dictionaryGroup = dic;
        }
        
        self.pushVC(vc, expectTarget: ISSCREEN.ISGROUP, isChildTarget: true, iAmParent: false, animate: true);
    }
    @IBAction func enterGroupValidationAction(sender: UIButton)
    {
        
    }
    @IBAction func enterGroupInfoAction(sender: UIButton)
    {
        
    }
    @IBAction func doEmailNotify(sender: UIButton)
    {
        
    }
    @IBAction func showMenuPopOver(sender: UIButton)
    {
        
    }
    @IBAction func unSubscribeGroupAction(sender: UIButton)
    {
        
    }
}