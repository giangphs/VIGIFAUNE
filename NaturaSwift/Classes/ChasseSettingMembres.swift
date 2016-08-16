//
//  ChasseSettingMembres.swift
//  NaturaSwift
//
//  Created by Giang on 7/22/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation

import Foundation

import SwiftyJSON

//let TypeCell1ID: String = "TypeCell1ID";

class ChasseSettingMembres: ChasseBaseVC {
    //MARK: - OUTLET
    @IBOutlet var lbTitle: UILabel!;
    @IBOutlet var btnCreateGroup: UIButton!;
    @IBOutlet var lbMessage: UILabel!;
    
    //MARK: - VARIABLE
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    var groupsActionArray:NSMutableArray = NSMutableArray();
    
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        
        lbTitle.text = str(strMESGROUPES);
        
        lbMessage.text = EMPTY_CHASSE_MES;
        
        //init tableviewcell
        tableControl.registerNib(UINib.init(nibName: String(TypeCell1), bundle: nil), forCellReuseIdentifier: TypeCell1ID);
        
        let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(sender_id)", str2: FILE_CHASSE_MUR_SAVE));
        
        if let arrTmp: NSArray = NSArray(contentsOfFile: strPath)
        {
            if arrTmp.count > 0 {
                groupsActionArray.addObjectsFromArray(arrTmp as [AnyObject]);
                
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
    
    //MARK: - TABLE
    override func insertRowAtTop() {
        
        let api:WebServiceAPI = WebServiceAPI();
        
        api.fnGETUSERLOUNGESACTION_API( "10", offset: "0") { (complete, code) in
            
            self.stopRefreshControl()
            
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            
            if let arrGroups = response["lounges"] as? NSArray {
                
                self.groupsActionArray.removeAllObjects();
                self.groupsActionArray.addObjectsFromArray(arrGroups as [AnyObject]);
                
                self.tableControl.reloadData();
                
                let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(self.sender_id)", str2: FILE_CHASSE_MUR_SAVE));
                self.groupsActionArray.writeToFile(strPath, atomically: true);
            }
            self.checkEmpty(self.groupsActionArray, msg: EMPTY_GROUP_MES);
            
        }
        
    }
    
    override func insertRowAtBottom() {
        let strPageCount = self.groupsActionArray.count
        
        if strPageCount == 0 {
            stopRefreshControl()
            return
        }
        
        let api:WebServiceAPI = WebServiceAPI();
        
        api.fnGETUSERLOUNGESACTION_API( "10", offset: "\(strPageCount)") { (complete, code) in
            
            self.stopRefreshControl()
            
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            
            if let arrGroups = response["lounges"] as? NSArray {
                if (arrGroups.count > 0 ){
                    //check if exist... abort.
                    
                    for mDic in arrGroups{
                        
                        if (self.groupsActionArray.containsObject(mDic)){
                            continue
                        }
                        
                        //else
                        self.groupsActionArray.addObject(mDic)
                    }
                }
                
                self.tableControl.reloadData();
                
                let strPath: String = FileHelper.pathForApplicationDataFile(concatstring("\(self.sender_id)", str2: FILE_CHASSE_MUR_SAVE));
                self.groupsActionArray.writeToFile(strPath, atomically: true);
            }
            self.checkEmpty(self.groupsActionArray, msg: EMPTY_GROUP_MES);
            
        }
        
    }
    
    func getItemWithKind(myid: String)  {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        let api:WebServiceAPI = WebServiceAPI();
        api.fnGET_ITEM_WITH_KIND("lounges", myKind: myid) { (complete, code) in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            if let dicGroup = response["lounge"] as? NSDictionary
            {
                var i: Int = 0;
                for dic in self.groupsActionArray
                {
                    if dicGroup["id"]?.integerValue == dic["id"]?!.integerValue
                    {
                        self.groupsActionArray.replaceObjectAtIndex(i, withObject: dicGroup);
                        let indexArray: NSArray = self.tableControl.indexPathsForVisibleRows!;
                        self.tableControl.reloadRowsAtIndexPaths(indexArray as! [NSIndexPath], withRowAnimation: .None);
                    }
                    i = i + 1;
                }
            }
        }
        
    }
    
    //MARK:- TABLEVIEW
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsActionArray.count;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: TypeCell1 = tableView.dequeueReusableCellWithIdentifier(TypeCell1ID, forIndexPath: indexPath) as! TypeCell1;
        
        
        configureCell(cell, forRowAtIndexPath: indexPath)
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        let cell: TypeCell1 = cellTmp as! TypeCell1;
        
        let dic = JSON(groupsActionArray[indexPath.section]);
        
        var m_userKind: USER_KIND = .USER_NORMAL;
        
        if let connectedDict:[String:JSON] = dic["connected"].dictionaryValue {
            switch connectedDict["access"]!.intValue {
            case 0:
                m_userKind = .USER_INVITED;
                break
            case 1:
                m_userKind = .USER_WAITING_APPROVE;
                break
            case 2:
                m_userKind = .USER_NORMAL;
                break
            case 3:
                m_userKind = .USER_ADMIN;
                break
            default:
                break
            }
        }
        
        //
        
        cell.label11.text = dic["owner"]["fullname"].string
        
        //
        switch dic["connected"]["participation"].intValue {
        case 0:
            cell.Img4.image = UIImage.init(named: "ic_not_participate")
            break
        case 1:
            cell.Img4.image = UIImage.init(named: "ic_participate")
            break
            
        case 2:
            cell.Img4.image = UIImage.init(named: "ic_pre_participate")
            break
            
        default:
            break
        }
        
        //
        cell.label1.text = dic["name"].stringValue
        
        //
        cell.label10.text = dic["description"].stringValue
        
        let strAccess = dic["access"].intValue
        if strAccess == 0{
            cell.label2.text = str(strAccessPrivate)
        }else if strAccess == 1 {
            cell.label2.text = str(strAccessSemiPrivate)
            
        }else if strAccess == 2 {
            cell.label2.text = str(strAccessPublic)
        }
        
        
        //
        if dic["nbParticipants"].intValue > 1 {
            cell.label3.text = "\(dic["nbParticipants"].intValue) participants"
        }else{
            cell.label3.text = "\(dic["nbParticipants"].intValue) participant"
        }
        
        if dic["meetingDate"].string == nil {
            cell.label5.text = ""
        }else{
            cell.label5.text = self.convertDate(dic["meetingDate"].stringValue)
        }
        
        
        if dic["nbPending"].intValue == 0 {
            cell.label12.hidden = true
        }else if dic["nbPending"].intValue == 1 {
            cell.label3.text = "\(dic["nbPending"].intValue) \(str(strPersonne_en_attente_de_validation))"
        }else{
            cell.label3.text = "\(dic["nbPending"].intValue) \(str(strPersonnes_en_attente_de_validation))"
            
        }
        
        
        if dic["meetingAddress"]["address"].string != "" {
            cell.label9.text = dic["meetingAddress"]["address"].string
        }else{
            cell.label9.text = String.init(format: "Lat. %.5f Lng. %.5f", dic["meetingAddress"]["latitude"].floatValue,dic["meetingAddress"]["longitude"].floatValue )
        }
        
        //
        if dic["endDate"].string == nil {
            cell.label7.text = ""
        }else{
            cell.label7.text = self.convertDate(dic["endDate"].stringValue)
            
        }
        
        //
        cell.button1.addTarget(self, action: #selector(enterChasesWall), forControlEvents: UIControlEvents.TouchUpInside)
        
        cell.btnLabel.addTarget(self, action: #selector(enterChasesWall), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        //Check address... enable click...
        
        cell.btnLocation.addTarget(self, action: #selector(locationButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        cell.btnLocation.tag = indexPath.row + 100;
        
        //
        
        if dic["connected"]["access"].intValue == 3 {
            cell.fnSettingCell (.UI_CHASSES_MUR_ADMIN)
            
            if dic["nbPending"].intValue > 0 {
                
                cell.button4.addTarget(self, action: #selector(friendRequestAction), forControlEvents: UIControlEvents.TouchUpInside)
                
                cell.view4.hidden = false
                cell.constraintHeight2.constant = 20
            }else{
                cell.view4.hidden=true;
                cell.constraintHeight2.constant = 0;
                
            }
        } else  if dic["connected"]["access"].intValue == 2 {
            cell.fnSettingCell (UI_TYPE.UI_CHASSES_MUR_NORMAL)
            
        }
        
        
        if dic["connected"]["access"].intValue == 3 {
            
            //
            cell.button2 .removeTarget(self, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.button2.addTarget(self, action: #selector(enterChassesInfoAction), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.Img6.image = UIImage.init(named: "ic_admin_setting")
            cell.button2.setTitle("ADMINISTRER", forState: UIControlState.Normal)
            
            cell.button2.setBackgroundImage(UIImage.init(named: "btn_chasse_bg"), forState: UIControlState.Normal)
            cell.createMenuList(["Administrer", "Fermer l'événement"])
            
            
            cell.btnSetting.tag = 5000+indexPath.row;
            
            cell.btnSetting.addTarget(self, action: #selector(showMenuPopOver), forControlEvents: UIControlEvents.TouchUpInside)
            
            
            cell.Img3.hidden = false;
            cell.label3.hidden = false;
            
        } else {
            
            cell.button2 .removeTarget(self, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.button2.addTarget(self, action: #selector(deleteJoinAction), forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.Img6.image = UIImage.init(named: "ic_close")
            cell.button2.setTitle("SE DESINSCRIRE", forState: UIControlState.Normal)
            
            cell.button2.setBackgroundImage(UIImage.init(named: "btn_chasse_orange_bg"), forState: UIControlState.Normal)
            cell.createMenuList(["Administrer", "Fermer l'événement"])
            
            cell.btnSetting .removeTarget(self, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
            
            
            
            cell.btnSetting.tag = 5000+indexPath.row;
            
            cell.btnSetting.addTarget(self, action: #selector(showMenuPopOver), forControlEvents: UIControlEvents.AllEvents)
            
            
            cell.imgBackGroundSetting.hidden = true;
            cell.imgSettingSelected.hidden = true;
            cell.imgSettingNormal.hidden = true;
            cell.Img3.hidden = true;
            cell.label3.hidden = true;
            
        }
        
        cell.button5.addTarget(self, action: #selector(participateEventAction), forControlEvents: UIControlEvents.TouchUpInside)
        cell.button5.tag=indexPath.row+5;
        //tag
        cell.button1.tag=indexPath.row+1;
        cell.btnLabel.tag=indexPath.row+1;
        
        
        cell.button2.tag=indexPath.row+2;
        //        cell.button3.tag=indexPath.row+3;
        cell.button4.tag=indexPath.row+4;
        cell.label12.tag=indexPath.row+12;
        
        //
        let strPhotoUrl = dic["photo"].stringValue;
        
        let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
        let url: NSURL = NSURL(string: strPhotoUrl)!;
        
        cell.Img1.kf_setImageWithURL(url, placeholderImage: placeholder_avatar, optionsInfo:nil, progressBlock: { (receivedSize, totalSize) in
            
            }, completionHandler: { (image, error, cacheType, imageURL) in
                
        })
        
    }
    
    
    //MARK:- FUNCTIONS
    func friendRequestAction(sender: AnyObject) -> Void {
        
        let iIndex = sender.tag - 4
        
        let vc:ChasseSettingMembres = ChasseSettingMembres(nibName: String(ChasseSettingMembres), bundle: nil);
        vc.expectTarget = .ISGROUP;
        
        GroupEnterOBJ.sharedInstance.resetParams();
        
        if let dic = groupsActionArray[iIndex] as? NSDictionary
        {
            GroupEnterOBJ.sharedInstance.dictionaryGroup = dic;
        }
        
        self.pushVC(vc, expectTarget: .ISLOUNGE, isChildTarget: true, iAmParent: false, animate: true);
        
        
    }
    
    func participateEventAction() -> Void {
        
    }
    
    func locationButtonAction() -> Void {
        
    }
    
    func enterChasesWall() -> Void {
        
    }
    
    
    func enterChassesInfoAction() -> Void {
        
    }
    
    func deleteJoinAction() -> Void {
        
    }
    
    
    @IBAction func enterGroupMurAction(sender: UIButton) {
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
    
    @IBAction func enterGroupValidationAction(sender: UIButton) {
        
    }
    
    @IBAction func enterGroupInfoAction(sender: UIButton) {
        
    }
    
    @IBAction func doEmailNotify(sender: UIButton) {
        
    }
    
    @IBAction func showMenuPopOver(sender: UIButton) {
        
    }
    
    @IBAction func unSubscribeGroupAction(sender: UIButton) {
        
    }
}
