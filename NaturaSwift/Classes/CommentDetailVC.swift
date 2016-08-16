//
//  CommentDetailVC.swift
//  NaturaSwift
//
//  Created by Manh on 6/30/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import IDMPhotoBrowser
import AVKit
let commentCustomCellID = "commentCustomCellID";
let MediaCellID = "MediaCell";

class CommentDetailVC: BaseVC, IDMPhotoBrowserDelegate {
    //MARK: - IBAUTLET
    @IBOutlet var messageView: UIView!;
    @IBOutlet var btnSend: UIButton!;
    @IBOutlet var logoMsg: UIImageView!;
    @IBOutlet var textView: UITextView!;

    @IBOutlet var constraintMessageView: NSLayoutConstraint!;
    @IBOutlet var constraintMessageHeight: NSLayoutConstraint!;
    //MARK: - VARIABLE
    let isLiveHuntDetail: Bool! = false;
    var commentViewGetArray: NSMutableArray = NSMutableArray();
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    var commentDic: NSDictionary!;
    override func viewDidLoad() {
        super.viewDidLoad();
        addMainNav(String(MainNavMUR));
        let mainView: MainNavigationBaseView = navigation.viewNavigation1.viewWithTag(TAG_MAIN_NAV_VIEW) as! MainNavigationBaseView;
        mainView.myTitle.text = "MUR";
        mainView.backgroundColor = UIColorFromRGB(MUR_MAIN_BAR_COLOR);

        tableControl.registerNib(UINib.init(nibName: String(MediaCell), bundle: nil), forCellReuseIdentifier: MediaCellID);
        tableControl.registerNib(UINib.init(nibName: String(CommentCustomCell), bundle: nil), forCellReuseIdentifier: commentCustomCellID);
        self.tableControl.reloadData();
        self.doGetCommentViewURL(false);
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
    }
    //MARK: - API
    func doGetCommentViewURL(isScroll: Bool) {
        if let publication_id = self.commentDic["id"] as? Int
        {
            let api:WebServiceAPI = WebServiceAPI();
            api.fnGET_PUBLICATION_COMMENT(String(publication_id), complete: { (complete, code) in
                if complete is NSDictionary
                {
                    let tempDic: NSMutableDictionary = NSMutableDictionary(dictionary: self.commentDic);
                    tempDic.setValue(complete["loaded"], forKey: "totalComments");
                    if let comment: NSArray = complete["comments"] as? NSArray
                    {
                        let descriptor: NSSortDescriptor = NSSortDescriptor(key: "created", ascending: true);
                      self.commentViewGetArray = NSMutableArray(array:  comment.sortedArrayUsingDescriptors([descriptor]));
                        self.commentViewGetArray = NSMutableArray(array:comment);
                    }
                    self.tableControl.reloadData();
                }
                if isScroll
                {
                    
                    let numberOfRows: NSInteger = self.tableControl.numberOfRowsInSection(1);
                    if numberOfRows > 0
                    {
                        self.tableControl.scrollToRowAtIndexPath(NSIndexPath(forItem: numberOfRows - 1, inSection: 1), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true);
                    }
                }
            });
        }
    }
    //MARK: - TABLEVIEW DELEGATE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0 {
            if commentDic != nil {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        return commentViewGetArray.count;
    }
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        if indexPath.section == 0 {
            let cell: MediaCell = tableView.dequeueReusableCellWithIdentifier(MediaCellID, forIndexPath: indexPath) as! MediaCell;
            self.configureCellHeader(cell);
            return cell;
 
        }
        else
        {
            let cell: CommentCustomCell = tableView.dequeueReusableCellWithIdentifier(commentCustomCellID, forIndexPath: indexPath) as! CommentCustomCell;
            self.configureCell(cell, forRowAtIndexPath: indexPath);
            return cell;

        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    //MARK: - CONFIGURE CELL
    func configureCellHeader(cellTmp: UITableViewCell) {
        if (cellTmp is MediaCell) {
            let cell: MediaCell = cellTmp as! MediaCell;
            if let dic: NSDictionary = commentDic {
                if (self.isLiveHuntDetail == true) {
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
                    cell.imageContent.sd_setImageWithURL(url, placeholderImage: placeholder_avatar, completed: { (image, error, cachetype, url) in
                        if image != nil
                        {
                            cell.imageContent.image = self.fnResizeFixWidth(image, wWidth: Float(cell.imageContent.bounds.size.width));
                        }
                        else
                        {
                            cell.imageContent.image = self.fnResizeFixWidth(placeholder_avatar, wWidth: Float(cell.imageContent.bounds.size.width));
                        }
                        if self.tableControl.visibleCells.contains(cell)
                        {
                            // update some UI
                            self.tableControl.reloadData();
                        }
                    })
                    cell.imageContent.indexPath = 0;
                    cell.imageContent.fnOncallback({ (index) in
                        self.commentDetailAction();
                    })
                    
                }
                else
                {
                    cell.imageContent.image = nil;
                    cell.imgIcon.hidden = true;
                    cell.imageContent.fnRemoveClick();
                }
                cell.assignValues(dic);
                
                cell.btnTitle .addTarget(self, action: #selector(userProfileFromTheirNameAction), forControlEvents: UIControlEvents.TouchUpInside);
                
                cell.btnProfile.addTarget(self, action: #selector(userProfileFromTheirNameAction), forControlEvents: UIControlEvents.TouchUpInside);
                
                cell.location .addTarget(self, action: #selector(locationButtonAction), forControlEvents: UIControlEvents.TouchUpInside);
                
                
                
                cell.btnLike.addTarget(self, action: #selector(likeButtonAction), forControlEvents: UIControlEvents.TouchUpInside);
                cell.btnSetting.addTarget(self, action: #selector(settingAction), forControlEvents: UIControlEvents.TouchUpInside);
                
                cell.btnLikesList.addTarget(self, action: #selector(displayLikesList), forControlEvents: UIControlEvents.TouchUpInside);
                
                
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
    func configureCell(cellTmp: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (cellTmp is CommentCustomCell) {
            let cell: CommentCustomCell = cellTmp as! CommentCustomCell;
            if isLiveHuntDetail == true {
                cell.iAmScreen = ISSCREEN.ISLIVEMAP;
            }
            else
            {
                cell.iAmScreen = self.expectTarget;
            }
            if let dic: NSDictionary = commentViewGetArray.objectAtIndex(indexPath.row) as? NSDictionary
            {
                cell.assignValuesHeaderSection(dic);
                cell.likeButton.addTarget(self, action: #selector(commentLikeAction), forControlEvents: UIControlEvents.TouchUpInside);
                cell.likeButton.tag = indexPath.row;
                cell.btnSetting.tag = indexPath.row + 100;
                if let owner = dic["owner"] as? NSDictionary, let id_owner = owner["id"]{
                    if Int(id_owner as! NSNumber) == sender_id {
                        cell.createMenuList([str(strModifier),str(strSupprimer)]);
                        cell.likeButton.addTarget(self, action: #selector(settingCommentAction), forControlEvents: UIControlEvents.TouchUpInside);
                        cell.imgSettingNormal.hidden = false;
                    }
                    else
                    {
                        cell.imgSettingNormal.hidden = true;
                        cell.likeButton.removeTarget(self, action: #selector(settingCommentAction), forControlEvents: UIControlEvents.TouchUpInside);
                    }
                }

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
    @IBAction func commentLikeAction(sender: UIButton)
    {
    }
    @IBAction func settingCommentAction(sender: UIButton)
    {
    }
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
            if (self.isLiveHuntDetail != nil) {
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
            let dic: NSDictionary = self.commentDic;
            if Int(dic["owner"]!["id"] as! NSNumber) == self.sender_id {
                switch ind {
                case 0:
                    self.editerAction(index);
                    break;
                case 1:
                    self.deletePublicationAction(index);
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
    func commentDetailAction()
    {
        if let media = commentDic["media"] as? NSDictionary{
            let strVideo = media["type"] as! Int
            //Video 101
            if strVideo == 101 {
                var strVideoURL = "\(IMAGE_ROOT_API)\(media["path"] as! String)";
                strVideoURL = strVideoURL.stringByReplacingOccurrencesOfString("videos/resize", withString: "videos/mp4");
                strVideoURL = strVideoURL.stringByReplacingOccurrencesOfString(".qt", withString: ".mp4");
                strVideoURL = strVideoURL.stringByReplacingOccurrencesOfString(".jpeg", withString: ".mp4");
                let videoURL: NSURL = NSURL(string: strVideoURL)!;
                let moviePlayer = AVPlayerViewController();
                //enable connect network
                let player: AVPlayer = AVPlayer(URL: videoURL);
                moviePlayer.player = player;
                //off connect network
                NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(moviePlayBackDidFinish), name: AVPlayerItemDidPlayToEndTimeNotification, object: moviePlayer);
                self.presentViewController(moviePlayer, animated: true) {
                    moviePlayer.player!.play()
                }
            }
            //photo 100
            else
            {
                let photos: NSMutableArray = NSMutableArray();
                var strImage = "\(IMAGE_ROOT_API)\(media["path"] as! String)";
                    strImage = strImage.stringByReplacingOccurrencesOfString(".qt", withString: ".jpeg");
                    strImage = strImage.stringByReplacingOccurrencesOfString(".mp4", withString: ".jpeg");
                    strImage = strImage.stringByReplacingOccurrencesOfString(".jpeg.jpeg", withString: ".jpeg");
                    strImage = strImage.stringByReplacingOccurrencesOfString("resize", withString: "original");
                let urlImage: NSURL = NSURL(string: strImage)!;
                
                let aphoto: IDMPhoto!
                //enable connect network
                aphoto = IDMPhoto(URL: urlImage);
                //disable connect network
                
                
                let inputFormatter: NSDateFormatter = ASSharedTimeFormatter.sharedFormatter.inputFormatter();
                let outputFormatterBis: NSDateFormatter = ASSharedTimeFormatter.sharedFormatter.timeFormatter();
                ASSharedTimeFormatter.checkFormatString("yyyy-MM-dd'T'HH:mm:ssZZZZ", forFormatter: inputFormatter);
                ASSharedTimeFormatter.checkFormatString("dd-MM-yyyy H:mm", forFormatter: outputFormatterBis);
                if let relativeTime = commentDic["created"]
                {
                    let inputDate: NSDate = inputFormatter.dateFromString(relativeTime as! String)!;
                    let outputString: String = outputFormatterBis.stringFromDate(inputDate);
                    aphoto.caption = outputString;

                }
                photos.addObject(aphoto);
                let browser: IDMPhotoBrowser = IDMPhotoBrowser(photos: photos as [AnyObject]);
                browser.delegate = self;
                self.presentViewController(browser, animated: true, completion: nil);

            }
        }
        
    }
    func photoBrowser(photoBrowser: IDMPhotoBrowser!, didDismissAtPageIndex index: UInt) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    @IBAction func fnBack(sender: AnyObject) {
        
        self.navigationController? .popViewControllerAnimated(true)
    }
    //MARK: - NOTIFIACTION CENTER
    func moviePlayBackDidFinish(notification: NSNotification) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil)
    }
}