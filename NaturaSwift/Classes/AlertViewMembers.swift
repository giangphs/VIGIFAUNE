//
//  AlertViewMembers.swift
//  NaturaSwift
//
//  Created by Manh on 7/19/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import OKAlertController
let identifier: String = "CellKind12ID";
typealias callBackAlert = (index: Int) ->()
class AlertViewMembers: UIViewController {
    @IBOutlet var tableControl: UITableView!;
    @IBOutlet var viewHearder:  UIView!;
    var imgAdd: UIImage!;
    var expectTarget:           ISSCREEN = ISSCREEN.ISMUR;
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    var arrMembers: NSMutableArray = NSMutableArray();
    var CallBack: callBackAlert!;

    override func viewDidLoad() {
        super.viewDidLoad();
        var strImg: String = "";
        var color: UInt = 0;
        switch expectTarget {
        case ISSCREEN.ISMUR:
            strImg = "mur_ic_amis_add_friend";
            color = MUR_MAIN_BAR_COLOR;
            break;
        case ISSCREEN.ISCARTE:
            color = CARTE_MAIN_BAR_COLOR;
            break;
        case ISSCREEN.ISDISCUSS:
            color = DISCUSSION_MAIN_BAR_COLOR;
            break;
        case ISSCREEN.ISGROUP:
            strImg = "ic_add_member_group";
            color = GROUP_MAIN_BAR_COLOR;
            break;
        case ISSCREEN.ISLOUNGE:
            strImg = "chasse_ic_add_friend";
            color = CHASSES_MAIN_BAR_COLOR;
            break;
        case ISSCREEN.ISAMIS:
            color = AMIS_MAIN_BAR_COLOR;
            break;
        case ISSCREEN.ISPARAMTRES:
            color = PARAM_MAIN_BAR_COLOR;
            break;
        default:
            break;
        }
        viewHearder.backgroundColor = UIColorFromRGB(color);
        imgAdd = UIImage(named: strImg);
        tableControl.registerNib(UINib.init(nibName: String(MembersCell), bundle: nil), forCellReuseIdentifier: identifier);

    }
    //MARK: - TABLE DELEGATE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {

        return arrMembers.count;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: MembersCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MembersCell;
        configureCell(cell, forRowAtIndexPath: indexPath);
        return cell;
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let index: Int = indexPath.row;
        if (CallBack != nil) {
            self.dismissViewControllerAnimated(true, completion: nil);
            CallBack(index: index);
        }
    }
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (cellTmp is MembersCell) {
            let cell: MembersCell = cellTmp as! MembersCell;
            
            let dic = JSON(arrMembers[indexPath.row]);
            
            cell.label1.text = dic["user"]["fullname"].stringValue;
            cell.label1.textColor = UIColor.blackColor();
            cell.label1.font = FONT_HELVETICANEUE_MEDIUM(15);
            
            var strPhotoUrl = "";
            if dic["user"]["profilepicture"] != nil {
                strPhotoUrl = String(format: "%@%@", IMAGE_ROOT_API,dic["user"]["profilepicture"].stringValue)
            }
            else
            {
                strPhotoUrl = String(format: "%@%@", IMAGE_ROOT_API,dic["user"]["photo"].stringValue)
            }
            strPhotoUrl = strPhotoUrl.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
            let url: NSURL = NSURL(string: strPhotoUrl)!;
            
            let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
            cell.imageIcon.kf_setImageWithURL(url, placeholderImage: placeholder_avatar, optionsInfo:nil, progressBlock: { (receivedSize, totalSize) in
                
                }, completionHandler: { (image, error, cacheType, imageURL) in
                    
            })

            var isAddFriendHide: Bool = true;
            if dic["user"]["id"].intValue == self.sender_id {
                isAddFriendHide = true;
            }
            else
            {
                if dic["isFriend"].dictionary != nil {
                    isAddFriendHide = true;
                }
                else
                {
                    isAddFriendHide = false;
                }
            }
            if isAddFriendHide {
                cell.btnAddFriend.hidden = true;
                cell.imgAddFriend.hidden = true;
                cell.btnAddFriend.removeTarget(self, action: #selector(fnAddFriend), forControlEvents: .TouchUpInside);
            }
            else
            {
                cell.btnAddFriend.hidden = false;
                cell.imgAddFriend.hidden = false;
                cell.btnAddFriend.addTarget(self, action: #selector(fnAddFriend), forControlEvents: .TouchUpInside);
  
            }
            cell.btnAddFriend.tag = indexPath.row;
            cell.imgAddFriend.image =  imgAdd;
            cell.backgroundColor = UIColor.whiteColor();
            cell.selectionStyle = .None;
        }
    }
    func fnAddFriend(sender: UIButton) {
        let index: Int = sender.tag;
        var dic = JSON(self.arrMembers[index]);
        let user_id = dic["user"]["id"].stringValue;
        let api:WebServiceAPI = WebServiceAPI();
        api.fnPOST_USER_FRIENDSHIP_ACITON(user_id) { (complete, code) in
            let response: NSDictionary = NSDictionary(dictionary: complete as! [NSObject : AnyObject]);
            // Create alert controller as usual
            let alert = OKAlertController(title: str(strTitle_app), message: str(strREQUESTSENT))
            // Fill with reqired actions
            alert.addAction(str(strOui), style: .Default) { _ in
            }
            alert.show(fromController: self.navigationController!, animated: true)

            if ((response["relation"] as? NSDictionary) != nil)
            {
                dic["isFriend"] = ["state": 1, "way": 2];
                var i: Int = 0;
                for dicM in self.arrMembers
                {
                    let dicMembers = JSON(dicM);
                    if dicMembers["user"]["id"].intValue == dic["user"]["id"].intValue
                    {
                        self.arrMembers.replaceObjectAtIndex(i, withObject: dicM);
                        break;
                    }
                    i = i + 1;
                }

            }
            let indexArray: NSArray = self.tableControl.indexPathsForVisibleRows!;
            self.tableControl.reloadRowsAtIndexPaths(indexArray as! [NSIndexPath], withRowAnimation: .None);
            
        }

    }
    @IBAction func fnDismiss(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}