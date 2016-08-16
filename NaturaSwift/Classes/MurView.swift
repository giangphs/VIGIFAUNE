//
//  MurVC.swift
//  NaturaSwift
//
//  Created by Manh on 6/23/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
import OKAlertController
let MediaCellIDMur = "MediaCell";

class MurView: BaseView {
    //MARK:- VARIABLE
    @IBOutlet weak var contentView: UIView!;
    var publicationArray: NSMutableArray!;
    var expectTarget: ISSCREEN = ISSCREEN.ISMUR;
    var isLiveHunt =  false;
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    var parentVC: BaseVC!;
    var callback: ((type: VIEW_ACTION_TYPE, arrData: NSArray) ->())!
    //MARK: - INIT
    func instanceWithParent(vc: BaseVC, expect: ISSCREEN)
    {
        publicationArray = NSMutableArray();
        tableControl.registerNib(UINib.init(nibName: String(MediaCell), bundle: nil), forCellReuseIdentifier: MediaCellIDMur);
        expectTarget = expect;
        parentVC = vc;
        
    }
    //MARK: - DATA
    func fnSetDataPublication(arrPublication: NSArray)  {
        publicationArray = arrPublication.mutableCopy() as! NSMutableArray;
        self.tableControl.reloadData();
    }
    func fnPublicationNew(arrPublication: NSArray) {
        let beforeContentSize: CGSize = self.tableControl.contentSize;
        publicationArray = arrPublication.mutableCopy() as! NSMutableArray;
        self.tableControl.reloadData();
        let afterContentSize: CGSize = self.tableControl.contentSize;
        let afterContentOffset: CGPoint = self.tableControl.contentOffset;
        let newContentOffset: CGPoint = CGPointMake(afterContentOffset.x, afterContentOffset.y +  afterContentSize.height - beforeContentSize.height);
        self.tableControl.contentOffset = newContentOffset;
    }
    //MARK: - CONTRAINT
    func addContraintSupview(viewSuper: UIView) {
        let view: UIView = self;
        self.translatesAutoresizingMaskIntoConstraints =  false;
        view.frame = viewSuper.frame;
        viewSuper.addSubview(view);
        viewSuper.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[view]-(0)-|", options:[], metrics: nil, views: ["view": view]));
        viewSuper.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[view]-(0)-|", options:[], metrics: nil, views: ["view": view]));

    }
    //MARK: - TABLE DELEGATE
    override func insertRowAtTop() {
        if callback != nil {
            callback(type: VIEW_ACTION_TYPE.VIEW_ACTION_REFRESH_TOP, arrData: publicationArray);
        }
    }
    override func insertRowAtBottom() {
        if callback != nil {
            callback(type: VIEW_ACTION_TYPE.VIEW_ACTION_REFRESH_BOTTOM, arrData: publicationArray);
        }
    }
     func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return publicationArray.count;
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: MediaCell = tableView.dequeueReusableCellWithIdentifier(MediaCellIDMur, forIndexPath: indexPath) as! MediaCell;
        self.configureCell(cell, forRowAtIndexPath: indexPath);
        return cell;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (cellTmp is MediaCell) {
            let cell: MediaCell = cellTmp as! MediaCell;
            if let dic: NSDictionary = publicationArray[indexPath.row] as? NSDictionary {
                if self.isLiveHunt == true {
                    cell.setThemeWithFromScreen(ISSCREEN.ISLIVEMAP);
                }
                else
                {
                    cell.setThemeWithFromScreen(ISSCREEN.ISMUR);
                    
                }
                
                var strImage: String!;
                if let owner = dic["owner"] {
                    if let profilepicture = owner["profilepicture"] as? String {
                        strImage = "\(IMAGE_ROOT_API)\(profilepicture )";
                    }
                    else if let photo = owner["photo"]
                    {
                        strImage = "\(IMAGE_ROOT_API)\(photo as! String)";

                    }
                }
                
                var url: NSURL = NSURL(string: strImage)!;
                let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
                cell.imageProfile.sd_setImageWithURL(url, placeholderImage: placeholder_avatar, completed: { (image, error, cachetype, url) in
                });
                if let media =  dic["media"] as? NSDictionary, let type = media["type"] as? NSNumber {
                    let strVideo: String = "\(type)";
                    if (strVideo == "101") {
                        strImage = "\(IMAGE_ROOT_API)\(media["path"] as! String)";
                        strImage = strImage.stringByReplacingOccurrencesOfString(".qt", withString: ".jpeg");
                        strImage = strImage.stringByReplacingOccurrencesOfString(".mp4", withString: ".jpeg");
                        strImage = strImage.stringByReplacingOccurrencesOfString(".mp4.mp4", withString: ".jpeg");
                        strImage = strImage.stringByReplacingOccurrencesOfString(".jpeg.jpeg", withString: ".mp4.jpeg");
                        cell.imgIcon.hidden = false;
                        
                    }
                    else
                    {
                        cell.imgIcon.hidden = true;
                        strImage = "\(IMAGE_ROOT_API)\(media["path"] as! String)\(".jpeg")";
                        strImage = strImage.stringByReplacingOccurrencesOfString(".jpeg.jpeg", withString: ".jpeg");
                        
                    }
                    url =  NSURL(string: strImage)!;
                    cell.imageContent.tag = indexPath.row;
                    cell.imageContent.sd_setImageWithURL(url, placeholderImage: placeholder_avatar, completed: { (image, error, cachetype, url) in
                        if image != nil
                        {
                            cell.imageContent.image = self.fnResizeFixWidth(image, wWidth: Float(cell.imageContent.bounds.size.width));
                        }
                        else
                        {
                            cell.imageContent.image = self.fnResizeFixWidth(placeholder_avatar, wWidth: Float(cell.imageContent.bounds.size.width));
                        }
                        if self.tableControl.visibleCells.contains(cell) && self.tableControl.indexPathForCell(cell) == indexPath && cell.imageContent.tag == indexPath.row
                        {
                                    // update some UI
                                    self.tableControl.reloadData();
                        }
                    })
                    cell.imageContent.indexPath = indexPath.row;
                    cell.imageContent.fnOncallback({ (index) in
                        if let dic = self.publicationArray.objectAtIndex(index) as? NSDictionary
                        {
                            self.displayCommentVC(dic);
                        }
                    })

                }
                else
                {
                    cell.imageContent.image = nil;
                    cell.imgIcon.hidden = true;
                    cell.imageContent.fnRemoveClick();
                }
                cell.assignValues(dic);
                
                cell.btnTitle.tag = indexPath.row;
                cell.btnTitle .addTarget(self, action: #selector(userProfileFromTheirNameAction), forControlEvents: UIControlEvents.TouchUpInside);
                
                cell.btnProfile.tag = indexPath.row;
                cell.btnProfile.addTarget(self, action: #selector(userProfileFromTheirNameAction), forControlEvents: UIControlEvents.TouchUpInside);

                cell.location .addTarget(self, action: #selector(locationButtonAction), forControlEvents: UIControlEvents.TouchUpInside);
                cell.location.tag = indexPath.row + LOCATIONBUTTONTAG;
                
                cell.btnTextComment .addTarget(self, action: #selector(commentViewAction), forControlEvents: UIControlEvents.TouchUpInside);
                
                cell.btnComment.addTarget(self, action: #selector(commentViewAction), forControlEvents: UIControlEvents.TouchUpInside);
                
                cell.btnLike.addTarget(self, action: #selector(likeButtonAction), forControlEvents: UIControlEvents.TouchUpInside);
                cell.btnSetting.addTarget(self, action: #selector(settingAction), forControlEvents: UIControlEvents.TouchUpInside);
                cell.btnSetting.tag = indexPath.row + 100;
                
                cell.btnLikesList.addTarget(self, action: #selector(displayLikesList), forControlEvents: UIControlEvents.TouchUpInside);
                cell.btnLikesList.tag = indexPath.row + 110;
                
                cell.btnLike.tag = indexPath.row + LIKETAG;
                cell.btnComment.tag = indexPath.row + COMMENTBUTTONTAG;
                cell.btnTextComment.tag = indexPath.row +  COMMENTBUTTONTAG;
                
                if let owner = dic["owner"], let id_owner = owner["id"]{
                    if Int(id_owner as! NSNumber) == sender_id {
                        cell.createMenuList([str(strModifier),str(strSupprimer)]);
                    }
                    else
                    {
                        cell.createMenuList([str(strSignaler), str(strMenu_item_Blacklister)]);
                    }
                }
                cell.selectionStyle = UITableViewCellSelectionStyle.None;
                cell.layoutIfNeeded();

            }
        }
    }
    //MARK: - RESIZE IMAGE
    func fnResizeFixWidth(img: UIImage , wWidth: Float) ->UIImage {
        var actualHeight: Float = Float(img.size.height);
        var actualWidth: Float = Float(img.size.width);
        var imgRatio = actualHeight/actualWidth;
        let fixWidth: Float = wWidth;
        imgRatio = fixWidth/actualWidth;
        actualHeight = imgRatio*actualHeight;
        actualWidth = fixWidth;
        let rect: CGRect = CGRectMake(0, 0, CGFloat(actualWidth), CGFloat(actualHeight));
        UIGraphicsBeginImageContext(rect.size);
        img.drawInRect(rect);
        let returnImg: UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return returnImg;
    }
    //MARK: - ACTION
    @IBAction func displayLikesList(sender: UIButton)
    {
        
    }
    @IBAction func settingAction(sender: UIButton)
    {
        let index: Int = sender.tag - 100;
        var parent: UIView! = sender.superview! as UIView;
        while !(parent is MediaCell) {
            parent = parent.superview;
        }
        let cell: MediaCell = parent as! MediaCell;
        switch self.expectTarget {
        case ISSCREEN.ISGROUP:
            cell.viewMenu.backgroundColor = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
            cell.imgBackGroundSetting.image = UIImage(named: "group_ic_bg_setting");
            cell.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
            cell.imgSettingNormal.image = UIImage(named: "group_ic_setting");

            break;
        case ISSCREEN.ISLOUNGE:
            if self.isLiveHunt {
                cell.viewMenu.backgroundColor = UIColorFromRGB(LIVE_MAP_MAIN_BAR_COLOR);
                cell.imgBackGroundSetting.image = UIImage(named: "live_bg_setting");
                cell.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
                cell.imgSettingNormal.image = UIImage(named: "live_ic_setting");

            }
            else
            {
                cell.viewMenu.backgroundColor = UIColorFromRGB(CHASSES_MAIN_BAR_COLOR);
                cell.imgBackGroundSetting.image = UIImage(named: "chasse_bg_setting");
                cell.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
                cell.imgSettingNormal.image = UIImage(named: "ic_chasse_setting_active");
            }
            
            break;
        default:
            break;
        }
        cell.show();
        cell.CallBackGroup = {(ind: NSInteger) in
            let dic: NSDictionary = self.publicationArray[index] as! NSDictionary;
            if Int(dic["owner"]!["id"] as! NSNumber) == self.sender_id {
                switch ind {
                case 0:
                    self.editerAction(index);
                    break;
                case 1:
                    // Create alert controller as usual
                    let alert = OKAlertController(title: str(strMessage24), message: str(strMessage23))
                    
                    // Fill with reqired actions
                    alert.addAction(str(strOui), style: .Default) { _ in
                        self.deletePublicationAction(index);
                    }
                    
                    alert.addAction(str(strNon), style: .Cancel, handler: nil) // Ignore cancel action handler
                    
                    // Setup alert controller to conform design
                    
                    alert.show(fromController: self.parentVC.navigationController!, animated: true)

                    break;
                default:
                    break;
                }
            }
            else
            {
                switch ind {
                case 0:
                    self.signalerAction(index);
                    break;
                case 1:
                    self.blackListerAction(index);
                    break;
                default:
                    break;
                }
            }
        };
        
    }
    @IBAction func deletePublicationAction(iTag: Int)
    {
        let api:WebServiceAPI = WebServiceAPI();
        api.fnDELETE_PUBLICATION_ACTION("20") { (complete, code) in
            if let dic: NSDictionary = complete as? NSDictionary, let success: Bool =  dic["success"] as? Bool where success == true
            {
                //update db
                //remove in list publication
                self.publicationArray.removeObjectAtIndex(iTag);
            }
        }

    }
    @IBAction func signalerAction(iTag: Int)
    {
        
    }
    @IBAction func blackListerAction(iTag: Int)
    {
        
    }
    @IBAction func editerAction(iTag: Int)
    {
        
    }
    @IBAction func likeButtonAction(sender: UIButton)
    {
        
    }
    @IBAction func commentViewAction(sender: UIButton)
    {
        let index: Int = sender.tag - COMMENTBUTTONTAG;
        if let dic = publicationArray.objectAtIndex(index) as? NSDictionary
        {
            self.displayCommentVC(dic);
        }
    }
    @IBAction func locationButtonAction(sender: UIButton)
    {
        
    }
    @IBAction func userProfileAction(sender: UIButton)
    {
    
    }
    @IBAction func userProfileFromTheirNameAction(sender: UIButton)
    {


    }
    func displayCommentVC(dic: NSDictionary)
    {
        let vc:CommentDetailVC = CommentDetailVC(nibName: String(CommentDetailVC), bundle: nil);
        vc.commentDic = dic;
        parentVC.pushVC(vc, expectTarget: expectTarget, isChildTarget: false, iAmParent: true, animate: true);
    }

    
}