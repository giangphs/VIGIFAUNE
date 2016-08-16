//
//  GroupSearchVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/19/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import SwiftyJSON
import OKAlertController
let ToutesCellID: String = "ToutesID";

class GroupSearchVC: GroupBaseVC {
    //MARK: - OUTLET
    @IBOutlet var toussearchBar: UISearchBar!;
    @IBOutlet var lbTitle: UILabel!;
    //MARK: - VARIABLE
    var searchLoungesArray:NSMutableArray   = NSMutableArray();
    var loungesArray:NSMutableArray         = NSMutableArray();
    var tourMemberArray:NSMutableArray      = NSMutableArray();
    var shouldBeginEditing: Bool            = false;
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        //remove
        removeTopBarItem([String(GroupInvitationAttend)]);
        tableControl.registerNib(UINib.init(nibName: String(GroupToutesCell), bundle: nil), forCellReuseIdentifier: ToutesCellID);
        lbTitle.text = str(strTOUS_LES_GROUPES);
        toussearchBar.placeholder = str(strSearchGroup);
        toussearchBar.tintColor = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
        //CACHE
        let strPath: String = FileHelper.pathForApplicationDataFile("CACHE_GROUP_SEARCH");
        if let arrTmp: NSArray = NSArray(contentsOfFile: strPath)
        {
            if arrTmp.count > 0 {
                loungesArray.addObjectsFromArray(arrTmp as [AnyObject]);
                tableControl.reloadData();
            }
        }
        //API
        insertRowAtTop();
    }
    //MARK: - API
    func GETGROUPTOUTES(filter: String,limit: String, offset: String, isLoadTop: Bool) {
        let api:WebServiceAPI = WebServiceAPI();
        api.fnGET_GROUP_TOUTES_ACITON(filter, limit: limit, offset: offset) { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if isLoadTop
            {
                if (self.shouldBeginEditing) {
                    self.searchLoungesArray.removeAllObjects();
                }
                else{
                    self.loungesArray.removeAllObjects();
                }
            }
            if let arrGroups = response["groups"] as? NSArray
            {
                if (self.shouldBeginEditing) {
                    self.searchLoungesArray.addObjectsFromArray(arrGroups as [AnyObject]);
                }
                else{
                    self.loungesArray.addObjectsFromArray(arrGroups as [AnyObject]);
                    //SAVE CACHE
                    let strPath: String = FileHelper.pathForApplicationDataFile("CACHE_GROUP_SEARCH");
                    self.loungesArray.writeToFile(strPath, atomically: true);
                }
            }
            self.tableControl.reloadData();
            
        }

    }
    //MARK: - FUNC
    override func insertRowAtTop() {
        if self.shouldBeginEditing {
            GETGROUPTOUTES(toussearchBar.text!, limit: "20", offset: "0", isLoadTop: true);
        }
        else{
            GETGROUPTOUTES("", limit: "20", offset: "0", isLoadTop: true);
        }
        
    }
    override func insertRowAtBottom() {
        if self.shouldBeginEditing {
            let offset: String = String(format: "%@", searchLoungesArray.count)
            GETGROUPTOUTES(toussearchBar.text!, limit: "20", offset: offset, isLoadTop: false);
        }
        else{
            let offset: String = String(format: "%@", loungesArray.count)
            GETGROUPTOUTES("", limit: "20", offset: offset, isLoadTop: false);
        }
    }
    @IBAction func rejoindreCommitAction(sender: UIButton)
    {
        toussearchBar.resignFirstResponder();
        // Create alert controller as usual
        let alert = OKAlertController(title: str(strTitle_app), message: str(strVous_avez_ete_invite_dans_ce_group))
        // Fill with reqired actions
        alert.addAction(str(strValider), style: .Default) { _ in
            
            var arrData: NSMutableArray = NSMutableArray();
            if self.shouldBeginEditing {
                arrData = self.searchLoungesArray.mutableCopy() as! NSMutableArray;
            }
            else
            {
                arrData = self.loungesArray.mutableCopy() as! NSMutableArray;
                
            }
            let index: Int = sender.tag - 2;
            var dic = JSON(arrData[index]);
            let strLoungeID = dic["id"].stringValue;
            let accessType = dic["access"].stringValue;
            let strNameGroup = dic["name"].intValue;
            var desc: String  = "";
            switch ACCESS_KIND(rawValue: Int(accessType as String)!)! {
            case ACCESS_KIND.ACCESS_PRIVATE:
                desc = String(format: str(strRejoindre_un_group), strNameGroup);
                break;
            case ACCESS_KIND.ACCESS_SEMIPRIVATE:
                desc = String(format: str(strRejoindre_un_group), strNameGroup);
                break;
            case ACCESS_KIND.ACCESS_PUBLIC:
                desc = String(format: str(strRejoindre_un_group_public), strNameGroup);
                break;
            }
            let api:WebServiceAPI = WebServiceAPI();
            api.fnPUT_GROUP_USER_JOIN_ACITON(strLoungeID, user_id: "\(self.sender_id)") { (complete, code) in
                let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
                if let success = response["success"] as? Bool where success == true
                {
                    dic["connected"]["access"] = 2;
                    if self.shouldBeginEditing
                    {
                        self.searchLoungesArray.replaceObjectAtIndex(index, withObject: dic.rawValue);
                    }
                    else
                    {
                        self.loungesArray.replaceObjectAtIndex(index, withObject: dic.rawValue);
                        
                    }
                    self.fnGotoGroup(index);
                }
                // Create alert controller as usual
                let alert = OKAlertController(title: str(strTitle_app), message: desc)
                // Fill with reqired actions
                alert.addAction(str(strOui), style: .Default) { _ in
                }
                alert.show(fromController: self.navigationController!, animated: true)
                self.tableControl.reloadData();
                
            }

            


        }
        alert.addAction(str(strAnuler), style: .Cancel, handler: nil) // Ignore cancel action handler
        // Setup alert controller to conform design
        alert.show(fromController: navigationController!, animated: true)
    }
    @IBAction func gotoGroup(sender: UIButton)
    {
        let index = sender.tag - 2;
        self.fnGotoGroup(index);

    }
    func fnGotoGroup(index: Int) {
        var arrData: NSMutableArray = NSMutableArray();
        if self.shouldBeginEditing {
            arrData = self.searchLoungesArray.mutableCopy() as! NSMutableArray;
        }
        else
        {
            arrData = self.loungesArray.mutableCopy() as! NSMutableArray;
            
        }
        let vc:GroupEnterMurVC = GroupEnterMurVC(nibName: String(GroupEnterMurVC), bundle: nil);
        vc.expectTarget = ISSCREEN.ISGROUP;
        
        GroupEnterOBJ.sharedInstance.resetParams();
        if let dic = arrData.objectAtIndex(index) as? NSDictionary
        {
            GroupEnterOBJ.sharedInstance.dictionaryGroup = dic;
        }
        
        self.pushVC(vc, expectTarget: ISSCREEN.ISGROUP, isChildTarget: true, iAmParent: false, animate: true);
        
    }
    @IBAction func cellRejoindre(sender: UIButton)
    {
        toussearchBar.resignFirstResponder();
        // Create alert controller as usual
        let alert = OKAlertController(title: str(strTitle_app), message: str(strVous_avez_ete_invite_dans_ce_group))
        // Fill with reqired actions
        alert.addAction(str(strValider), style: .Default) { _ in
            
            var arrData: NSMutableArray = NSMutableArray();
            if self.shouldBeginEditing {
                arrData = self.searchLoungesArray.mutableCopy() as! NSMutableArray;
            }
            else
            {
                arrData = self.loungesArray.mutableCopy() as! NSMutableArray;
                
            }
            
            let index: Int = sender.tag - 2;
            var dic = JSON(arrData[index]);
            let strLoungeID = dic["id"].stringValue;
            let accessType = dic["access"].intValue;
            let strNameGroup = dic["name"].stringValue;
            var desc: String  = "";
            switch ACCESS_KIND(rawValue: accessType)! {
            case ACCESS_KIND.ACCESS_PRIVATE:
                desc = String(format: str(strRejoindre_un_group), strNameGroup);
                break;
            case ACCESS_KIND.ACCESS_SEMIPRIVATE:
                desc = String(format: str(strRejoindre_un_group), strNameGroup);
                break;
            case ACCESS_KIND.ACCESS_PUBLIC:
                desc = String(format: str(strRejoindre_un_group_public), strNameGroup);
                break;
            }
            let api:WebServiceAPI = WebServiceAPI();
            api.fnPOST_GROUP_USER_JOIN_ACITON(strLoungeID, user_id: "\(self.sender_id)") { (complete, code) in
                let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
                if let access = response["access"] as? Int
                {
                    dic["connected"]["access"] = JSON(access);
                    
                    if self.shouldBeginEditing
                    {
                        self.searchLoungesArray.replaceObjectAtIndex(index, withObject: dic.rawValue);
                    }
                    else
                    {
                        self.loungesArray.replaceObjectAtIndex(index, withObject: dic.rawValue);
                        
                    }
                    self.tableControl.reloadData();
                }
                // Create alert controller as usual
                let alert = OKAlertController(title: str(strTitle_app), message: desc)
                // Fill with reqired actions
                alert.addAction(str(strOui), style: .Default) { _ in
                }
                self.tableControl.reloadData();
                
            }
            
            
            
            
        }
        alert.addAction(str(strAnuler), style: .Cancel, handler: nil) // Ignore cancel action handler
        // Setup alert controller to conform design
        alert.show(fromController: navigationController!, animated: true)

    }
    @IBAction func MemberButtonAction(sender: UIButton)
    {
        toussearchBar.resignFirstResponder();
        let index: Int = sender.tag - 1;
        var arrData: NSMutableArray = NSMutableArray();
        if self.shouldBeginEditing {
            arrData = self.searchLoungesArray.mutableCopy() as! NSMutableArray;
        }
        else
        {
            arrData = self.loungesArray.mutableCopy() as! NSMutableArray;
        }
        let dic = JSON(arrData[index]);
        let strLoungeID = dic["id"].stringValue;
        
        let api:WebServiceAPI = WebServiceAPI();
        api.fnGET_GROUP_SUBSCRIBERFRIEND_ACITON(strLoungeID) { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if let arrMembers = response["subscribers"] as? NSMutableArray
            {
                for dicM in arrMembers
                {
                    let dicMembers = JSON(dicM);
                    if dicMembers["user"]["id"].intValue == self.sender_id
                    {
                        arrMembers.removeObject(dicM);
                    }
                }
                self.showPopupMembers(arrMembers);
            }
            
        }

    }
    func showPopupMembers(arrMembers: NSArray) {
        let viewcontroller1: AlertViewMembers = AlertViewMembers(nibName: "AlertViewMembers", bundle: nil);
        viewcontroller1.arrMembers = NSMutableArray(array: arrMembers);
        viewcontroller1.expectTarget = ISSCREEN.ISGROUP;
        self.presentViewController(viewcontroller1, animated: true, completion: nil);
    }
    //MARK: - SEARCH BAR
    func processLoungesSearchingURL()
    {
        var strSearchValues = toussearchBar.text;
        strSearchValues = strSearchValues!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet());
        toussearchBar.text = strSearchValues;
        //api
        GETGROUPTOUTES(toussearchBar.text!, limit: "20", offset: "0", isLoadTop: true);
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if self.shouldBeginEditing {
            searchBar.setShowsCancelButton(true, animated: true);
        }
        NSObject.cancelPreviousPerformRequestsWithTarget(self);
        self.performSelector(#selector(processLoungesSearchingURL), withObject: nil, afterDelay: 1.0);
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        searchBar.text = "";
        searchBar.setShowsCancelButton(false, animated: true);
        searchBar.resignFirstResponder();
        self.shouldBeginEditing = false;
        self.tableControl.reloadData();
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true);
        var strSearchValues = toussearchBar.text;
        strSearchValues = strSearchValues!.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet());
        toussearchBar.text = strSearchValues;
        //api
        GETGROUPTOUTES(toussearchBar.text!, limit: "20", offset: "0", isLoadTop: true);
        searchBar.resignFirstResponder();
    }
    func searchBarTextDidBeginEditing(searchBar: UISearchBar)
    {
        searchBar.setShowsCancelButton(true, animated: true);
        shouldBeginEditing = true;
        tourMemberArray.removeAllObjects();
        searchLoungesArray.removeAllObjects();
        self.tableControl.reloadData();
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
    
    //MARK: - TABLE DELEGATE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.shouldBeginEditing {
            return searchLoungesArray.count;
        }
        else
        {
            return loungesArray.count;
        }
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
            let cell: GroupToutesCell = tableView.dequeueReusableCellWithIdentifier(ToutesCellID, forIndexPath: indexPath) as! GroupToutesCell;
            configureCell(cell, forRowAtIndexPath: indexPath);
            return cell;
            
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (cellTmp is GroupToutesCell) {
            let cell: GroupToutesCell = cellTmp as! GroupToutesCell;
            var arrData: NSMutableArray = NSMutableArray();
            if self.shouldBeginEditing {
                arrData = searchLoungesArray.mutableCopy() as! NSMutableArray;
            }
            else
            {
                arrData = loungesArray.mutableCopy() as! NSMutableArray;

            }
            
            let dic = JSON(arrData[indexPath.row]);
            
            var strName = dic["name"].stringValue;
            if strName == "(null)"
            {
                strName = dic["lounge"]["name"].stringValue;
            }
            var strDescription: String = dic["description"].stringValue;
            if strDescription == "(null)"
            {
                strDescription = dic["lounge"]["description"].stringValue;
            }
            cell.titleNameLabel.text=strName;
            cell.descLabel.text=strDescription;


            //Enter
            cell.btnRejoindre.tag = 2 + indexPath.section;
            cell.btnRejoindre.removeTarget(self, action: #selector(rejoindreCommitAction), forControlEvents: .TouchUpInside);
            cell.btnRejoindre.removeTarget(self, action: #selector(gotoGroup), forControlEvents: .TouchUpInside);
            cell.btnRejoindre.removeTarget(self, action: #selector(cellRejoindre), forControlEvents: .TouchUpInside);
            cell.btnRejoindre.colorEnable = UIColorFromRGB(GROUP_TOUS_COLOR);
            
            if let connectedDict:[String:JSON] = dic["connected"].dictionaryValue {
                var access = 4;
                if connectedDict["access"] != nil {
                    access = connectedDict["access"]!.intValue;
                }
                switch USER_KIND(rawValue: access)! {
                case USER_KIND.USER_INVITED:
                    cell.btnRejoindre.setTitle(str(strTo_Commit), forState: .Normal);
                    cell.btnRejoindre.enabled = true;
                    cell.btnRejoindre.addTarget(self, action: #selector(rejoindreCommitAction), forControlEvents: .TouchUpInside);
                    break;
                case USER_KIND.USER_WAITING_APPROVE:
                    cell.btnRejoindre.setTitle(str(strOn_hold), forState: .Normal);
                    cell.btnRejoindre.enabled = false;
                    break;
                case USER_KIND.USER_NORMAL:
                    cell.btnRejoindre.setTitle(str(strAAccess), forState: .Normal);
                    cell.btnRejoindre.enabled = true;
                    cell.btnRejoindre.addTarget(self, action: #selector(gotoGroup), forControlEvents: .TouchUpInside);
                    break;
                case USER_KIND.USER_ADMIN:
                    cell.btnRejoindre.setTitle(str(strAAccess), forState: .Normal);
                    cell.btnRejoindre.enabled = true;
                    cell.btnRejoindre.addTarget(self, action: #selector(gotoGroup), forControlEvents: .TouchUpInside);
                    break;
                default:
                    cell.btnRejoindre.setTitle(str(strSinscrire), forState: .Normal);
                    cell.btnRejoindre.enabled = true;
                    cell.btnRejoindre.addTarget(self, action: #selector(cellRejoindre), forControlEvents: .TouchUpInside);
                    break;
                }
            }
            
            
            var accessType: NSString = dic["access"].stringValue;
            
            if accessType == "(null)" {
                accessType = dic["lounge"]["access"].stringValue;
            }
            
            switch ACCESS_KIND(rawValue: Int(accessType as String)!)! {
            case ACCESS_KIND.ACCESS_PRIVATE:
                cell.publicAccessLabel.text = str(strAccessPrivate);
                break;
            case ACCESS_KIND.ACCESS_SEMIPRIVATE:
                cell.publicAccessLabel.text = str(strAccessSemiPrivate);
                break;
            case ACCESS_KIND.ACCESS_PUBLIC:
                cell.publicAccessLabel.text = str(strAccessPublic);
                break;
            }
            var strPhotoUrl = dic["photo"].stringValue;
            strPhotoUrl = strPhotoUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
            let url: NSURL = NSURL(string: strPhotoUrl)!;
            
            let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
            cell.usericonImages.kf_setImageWithURL(url, placeholderImage: placeholder_avatar, optionsInfo:nil, progressBlock: { (receivedSize, totalSize) in
                
                }, completionHandler: { (image, error, cacheType, imageURL) in
                    
            })
            cell.btnMember.tag = 1 + indexPath.row;
            cell.btnMember.colorEnable = UIColorFromRGB(GROUP_TOUS_COLOR);
            cell.btnMember.setTitle(str(strMMembres), forState: .Normal);
            cell.btnMember.addTarget(self, action: #selector(MemberButtonAction), forControlEvents: .TouchUpInside);
            cell.fnSettingCell(UI_TYPE.UI_GROUP_TOUTE);
            cell.layoutIfNeeded();
            cell.selectionStyle = .None;
            
        }
    }

}