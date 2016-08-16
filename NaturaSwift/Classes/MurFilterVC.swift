//
//  MurFilterVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/6/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import SwiftyJSON
let identifierSection1 = "MyTableViewCell1";
let identifierSection2 = "MyTableViewCell2";
let identifierSection3 = "MyTableViewCell3";
let OBJECT_FILTER      = "OBJECT_FILTER"
class MurFilterVC: MurBaseVC {
    //MARK: - IBOUTLET
   @IBOutlet var swFilterControl: UISwitch!;
   @IBOutlet var lbTitle: UILabel!;
    //MARK: - VARIABLE
    var mesArr: NSMutableArray! = NSMutableArray();
    var sharingGroupsArray: NSMutableArray! = NSMutableArray();
    var sharingHuntsArray: NSMutableArray! =  NSMutableArray();
    var iSharing: Int = 0;
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int

    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        lbTitle.text = str(strFILTRE);
        self.tableControl.registerNib(UINib.init(nibName: "SlideCustomCell", bundle: nil), forCellReuseIdentifier: identifierSection1);
        self.tableControl.registerNib(UINib.init(nibName: "SlideCustomCell", bundle: nil), forCellReuseIdentifier: identifierSection2)
        self.tableControl.registerNib(UINib.init(nibName: "SlideCustomCell", bundle: nil), forCellReuseIdentifier: identifierSection3)
        let dic1: [String: AnyObject] = ["categoryName":str(strMOI),"categoryImage":"mon_icon"];
        let dic2: [String: AnyObject] = ["categoryName":str(strMYFRIEND),"categoryImage":"mes2_icon"]
        let dic3: [String: AnyObject] = ["categoryName":str(strMEMBER),"categoryImage":"naturepass"]
        mesArr = [dic1,dic2,dic3];
        if let dicA: NSDictionary = NSUserDefaults.standardUserDefaults().objectForKey(OBJECT_FILTER) as? NSDictionary {
            iSharing = (dicA["isFilter"]?.integerValue)!;
        }
        else
        {
            iSharing = 3;
        }
        shouldUpdate();
        loadDatabase();
    }
    //MARK: - DATABASE
    func loadDatabase() {
        DatabaseManager.sharedInstance.queue.inTransaction {
            (db, rollback) in
            //list shared mes groups
            var strPath: String = FileHelper.pathForApplicationDataFile(concatstring(String(format: "%d",self.sender_id), str2: SHARE_MES_GROUP_SAVE))
            let arrTmp: NSArray = NSArray(contentsOfFile: strPath)!;
            let strQuerry: String = String(format: " SELECT * FROM tb_group WHERE (c_admin=1 OR c_allow_show=1) AND c_user_id=%d ", self.sender_id);
            do
            {
                let set_querry1 = try db.executeQuery(strQuerry, values: nil);
                
                while(set_querry1.next())
                {
                    let strID: Int =  set_querry1.longForColumn("c_id");
                    for kDic in arrTmp
                    {
                        if kDic["groupID"]?!.integerValue == strID
                        {
                            self.sharingGroupsArray.addObject(kDic);
                            break;
                        }
                    }
                }
            }
            catch let error as NSError
            {
                NSLog("%@", error);
            }
            
            //list shared mes chasses
             strPath = FileHelper.pathForApplicationDataFile(concatstring(String(format: "%d",self.sender_id), str2: SHARE_MES_GROUP_SAVE))
            let arrTmpHunt: NSArray = NSArray(contentsOfFile: strPath)!;
            let strQuerryHunt: String = String(format: " SELECT * FROM tb_hunt WHERE (c_admin=1 OR c_allow_show=1) AND c_user_id=%d ", self.sender_id);
            do
            {
                let set_querry1 = try db.executeQuery(strQuerryHunt, values: nil);
                
                while(set_querry1.next())
                {
                    let strID: Int =  set_querry1.longForColumn("c_id");
                    for kDic in arrTmpHunt
                    {
                        if kDic["huntID"]?!.integerValue == strID
                        {
                            self.sharingHuntsArray.addObject(kDic);
                            break;
                        }
                    }
                }
            }
            catch let error as NSError
            {
                NSLog("%@", error);
            }
            //reload
            self.tableControl.reloadData();
        }

    }
    //MARK: - ACTION
    func shouldUpdate() {
        swFilterControl.onTintColor = UIColorFromRGB(ON_SWITCH);
        swFilterControl.transform = CGAffineTransformMakeScale(0.75, 0.75);
        swFilterControl.setOn(bFilterON, animated: true);
        switchValueChanged(swFilterControl);
    }
    @IBAction func switchValueChanged(sender: UISwitch)
    {
        bFilterON = sender.on;
        if bFilterON == false {
            NSUserDefaults.standardUserDefaults().setBool(bFilterON, forKey: "isCategoryON");
        }
        //save bFilter Only
        var dicA: NSMutableDictionary = NSMutableDictionary();
        if NSUserDefaults.standardUserDefaults().objectForKey(OBJECT_FILTER) != nil {
            dicA = NSUserDefaults.standardUserDefaults().objectForKey(OBJECT_FILTER)?.mutableCopy() as! NSMutableDictionary
            
        }
        dicA.setValue(bFilterON, forKey: "isFilter");
        NSUserDefaults.standardUserDefaults().setObject(dicA, forKey: OBJECT_FILTER);
        NSUserDefaults.standardUserDefaults().synchronize();
        if bFilterON {
            self.tableControl.hidden = false;
        }
        else
        {
            self.tableControl.hidden = true;
        }
        self.updateStatusNavControls();
    }
    //MARK: - TABLE DELEGATE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section {
        case 0:
            return mesArr.count;
        case 1:
            return sharingGroupsArray.count;
        case 2:
            return sharingHuntsArray.count;
        default: break;
            
        }
        return 0;
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 36;
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: NSInteger) -> CGFloat {
        if section == 0 {
            return 15;
        }
        else
        {
            return 50;
        }
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sectionView: UIView? = nil;
        if section == 0 {
            sectionView = UIView(frame: CGRectMake(0,0,320,15));
        }
        else if (section == 1)
        {
            sectionView = UIView(frame: CGRectMake(0,0,320,50));
            let headerLabel: UILabel = UILabel(frame: CGRectMake(12,15,200,29));
            headerLabel.textColor = UIColor.blackColor();
            headerLabel.numberOfLines = 2;
            headerLabel.backgroundColor = UIColor.clearColor();
            headerLabel.font = UIFont.boldSystemFontOfSize(17);
            headerLabel.text = str(strMesGroupes);
            sectionView?.addSubview(headerLabel);
        }
        else
        {
            sectionView = UIView(frame: CGRectMake(0,0,320,50));
            let headerLabel: UILabel = UILabel(frame: CGRectMake(12,15,200,29));
            headerLabel.textColor = UIColor.blackColor();
            headerLabel.numberOfLines = 2;
            headerLabel.backgroundColor = UIColor.clearColor();
            headerLabel.font = UIFont.boldSystemFontOfSize(17);
            headerLabel.text = str(strMesChantier);
            sectionView?.addSubview(headerLabel);

        }
        sectionView?.backgroundColor = UIColor.whiteColor();
        
        let dividerImage: UIImageView = UIImageView(frame: CGRectMake(18, 10, 255, 1));
        dividerImage.image = UIImage(named: "divider4.png");
        dividerImage.alpha = 1;
        sectionView?.addSubview(dividerImage);
        return sectionView;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell: SlideCustomCell? = nil;
        if indexPath.section == 0 {
            cell = self.tableControl.dequeueReusableCellWithIdentifier(identifierSection1, forIndexPath: indexPath) as? SlideCustomCell;
        }
        else if indexPath.section == 1 {
            cell = self.tableControl.dequeueReusableCellWithIdentifier(identifierSection2, forIndexPath: indexPath) as? SlideCustomCell;
        }
        else {
            cell = self.tableControl.dequeueReusableCellWithIdentifier(identifierSection3, forIndexPath: indexPath) as? SlideCustomCell;
        }
        cell?.backgroundColor = UIColor.whiteColor();
        if indexPath.section == 0 {
            let json = JSON(mesArr);
            cell?.tickButton.hidden = false;
            if let title = json[indexPath.row]["categoryName"].string
                {
                    cell?.setListLabel(title);
                }
            if let image = json[indexPath.row]["categoryImage"].string
            {
                cell?.setListImages(image);
            }
            cell?.tickButton.tag = indexPath.row + 10;
            cell?.tickButton.selected = false;
            switch iSharing {
            case -1:
                cell?.tickButton.selected = false;
                break;
            case 0:
                if indexPath.row == 0 {
                    cell?.tickButton.selected = true;
                }
                else
                {
                    cell?.tickButton.selected = false;
                }
                break;
            case 1:
                if indexPath.row == 1 {
                    cell?.tickButton.selected = true;
                }
                else
                {
                    cell?.tickButton.selected = false;
                }
                break;
            case 3:
                if indexPath.row == 2 {
                    cell?.tickButton.selected = true;
                }
                else
                {
                    cell?.tickButton.selected = false;
                }
                break;
            default:
                break;
            }
            cell?.tickButton.addTarget(self, action: #selector(selectTickAction), forControlEvents: .TouchUpInside)
        }
        else if (indexPath.section == 1)
        {
            let json = JSON(sharingGroupsArray.objectAtIndex(indexPath.row));
            
            if let title = json[indexPath.row]["categoryName"].string
            {
                cell?.setListLabel(title);
            }
                cell?.setListImages("sharechamp");
            cell?.tickButton.tag = indexPath.row + 100;
            if let num = json["isSelected"].bool where num == true
            {
                cell?.tickButton.selected = true;
            }
            else
            {
                cell?.tickButton.selected =  false;
            }
            cell?.tickButton.addTarget(self, action: #selector(selectTickActionMesGroup), forControlEvents: .TouchUpInside)

        }
        else if (indexPath.section == 2 )
        {
            let json = JSON(sharingHuntsArray.objectAtIndex(indexPath.row));
            
            if let title = json[indexPath.row]["categoryName"].string
            {
                cell?.setListLabel(title);
            }
            cell?.setListImages("sharechamp");
            cell?.tickButton.tag = indexPath.row + 100;
            if let num = json["isSelected"].bool where num == true
            {
                cell?.tickButton.selected = true;
            }
            else
            {
                cell?.tickButton.selected =  false;
            }
            cell?.tickButton.addTarget(self, action: #selector(selectTickActionMesHunt), forControlEvents: .TouchUpInside)

        }
        cell?.selectionStyle = .None;
        return cell!;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    @IBAction func selectTickAction(sender: UIButton)
    {
        let iTag: Int = sender.tag - 10;
        if sender.selected {
            iSharing = -1;
        }
        else
        {
            switch (iTag) {
            case 0:
                iSharing = 0;
                break;
            case 1:
                iSharing = 1;
                break;
            case 2:
                iSharing = 3;
                break;
                
            default:
                break;
            }
        }
        //save bFilter Only
        var dicA: NSMutableDictionary = NSMutableDictionary();
        if NSUserDefaults.standardUserDefaults().objectForKey(OBJECT_FILTER) != nil {
            dicA = NSUserDefaults.standardUserDefaults().objectForKey(OBJECT_FILTER)?.mutableCopy() as! NSMutableDictionary
        }
        dicA.setValue(bFilterON, forKey: "isFilter");
        NSUserDefaults.standardUserDefaults().setObject(dicA, forKey: OBJECT_FILTER);
        NSUserDefaults.standardUserDefaults().synchronize();
        self.tableControl.reloadData();
    }
    @IBAction func selectTickActionMesGroup(sender: UIButton)
    {
        let index: Int = sender.tag - 100;
        let dic: NSMutableDictionary = sharingGroupsArray.objectAtIndex(index) as! NSMutableDictionary;
        if sender.selected {
            dic.setValue(false, forKey: "isSelected");
        }
        else
        {
            dic.setValue(true, forKey: "isSelected");
        }
        sharingGroupsArray.replaceObjectAtIndex(index, withObject: dic);
        self.tableControl.reloadData();
    }
    @IBAction func selectTickActionMesHunt(sender: UIButton)
    {
        let index: Int = sender.tag - 100;
        let dic: NSMutableDictionary = sharingHuntsArray.objectAtIndex(index) as! NSMutableDictionary;
        if sender.selected {
            dic.setValue(false, forKey: "isSelected");
        }
        else
        {
            dic.setValue(true, forKey: "isSelected");
        }
        sharingHuntsArray.replaceObjectAtIndex(index, withObject: dic);
        self.tableControl.reloadData();

    }
}