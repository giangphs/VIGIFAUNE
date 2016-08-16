//
//  MediaCell.swift
//  NaturaSwift
//
//  Created by Manh on 6/23/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class MediaCell: CellBase {
    @IBOutlet var ongNhom: UIImageView!;
    //    @property (nonatomic, copy) onClickText cbClickText;
    //
    @IBOutlet var tempView: UIView!;
    
    @IBOutlet var imgLocation: UIImageView!;
    
    @IBOutlet var imgSetting: UIImageView!;
    
    @IBOutlet var imageProfile: UIImageView!;
    
    @IBOutlet var btnProfile: UIButton!;
    
    @IBOutlet var btnTitle: UIButton!;
    
    @IBOutlet var title: UILabel!;
    
    @IBOutlet var time: UILabel!;
    
    @IBOutlet var alt: UILabel!;
    
    @IBOutlet var lat: UILabel!;
    
    @IBOutlet var longtitude: UILabel!;
    
    @IBOutlet var location: UIButton!;
    
    @IBOutlet var locationTxt: UILabel!;
    
    @IBOutlet var constraintHeightObservationIcon: NSLayoutConstraint!;
    
    @IBOutlet var obs_label_static: UILabel!;
    
    @IBOutlet var obs_tree_content: UILabel!;
    
    @IBOutlet var imageLeftIndice: UIView!;
    
    @IBOutlet var imgIcon: UIImageView!;
    
    @IBOutlet var viewArrowComment: UIView!;
    
    @IBOutlet var numLike: UILabel!;
    
    @IBOutlet var numComment: UILabel!;
    
    @IBOutlet var btnLike: UIButton!;
    
    @IBOutlet var btnComment: UIButton!;
    
    @IBOutlet var btnTextComment: UIButton!;
    
    @IBOutlet var lbComment: UILabel!;
    
    @IBOutlet var btnLikesList: UIButton!;
    
    @IBOutlet var btnIconLike: UIButton!;
    
    @IBOutlet var myContent: UILabel!;
    
    @IBOutlet var shareType: UILabel!;
    
    @IBOutlet var observation: UILabel!;
    
    @IBOutlet var imageContent: ImageViewAction!;
    
    @IBOutlet var btnInfo: UIButton!;
    
    var iWhoIamI: ISSCREEN = ISSCREEN.ISMUR;
    override func awakeFromNib() {
        super.awakeFromNib();
        self.mainView.layer.masksToBounds = true;
        self.mainView.layer.cornerRadius = 4.0;
        self.mainView.layer.borderWidth = 0.5;
        self.mainView.layer.borderColor = UIColor.lightGrayColor().CGColor;
        
        self.imageProfile.layer.masksToBounds = true;
        self.imageProfile.layer.cornerRadius = self.imageProfile.frame.size.height/2;
        self.imageProfile.layer.borderWidth = 0;
        
        //Reverse
        self.viewArrowComment.hidden =  true;
        self.btnInfo.hidden = true;
        //
        self.imgBackGroundSetting.image = UIImage(named: "bg_setting_post");
        self.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
        self.imgSettingNormal.image = UIImage(named: "mur_ic_action_setting_post");
        
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        self.contentView.layoutIfNeeded();
        self.imageContent.layoutIfNeeded();
        self.imageContent.preferredFocusedView
    }
    func assignValues(publicationDic: NSDictionary) {
        //set color
        var color: UIColor = UIColor();
        switch self.iWhoIamI {
        case ISSCREEN.ISLOUNGE:
            color = UIColorFromRGB(CHASSES_MAIN_BAR_COLOR);
            break;
        case ISSCREEN.ISGROUP:
            color = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
            break;
        case ISSCREEN.ISLIVEMAP:
            color = UIColorFromRGB(LIVE_MAP_MAIN_BAR_COLOR);
            break;
        default:
            color = UIColorFromRGB(MUR_MAIN_BAR_COLOR);
            break;
        }
        
        //name
        if let owner = publicationDic["owner"] as? NSDictionary  {
            let strUserName: String = "\(owner["firstname"] as! String) \(owner["lastname"] as! String)";
            self.title.text = strUserName ;
        }
        
        //like
        if let like = publicationDic["likes"] as? Int {
            let strLikes: String = "\(like)";
            numLike.text = strLikes;
        }

        //count comment
        var commentsCount: NSInteger = 0;
        if let totalComment = publicationDic["totalComments"] as? NSInteger {
            commentsCount = totalComment;
        }
        else if let totalComment = publicationDic["comments"] as? NSDictionary, total = totalComment["total"] as? NSInteger
        {
            commentsCount = total ;
        }
        
        let strComment = "\(commentsCount)";
        
        numComment.text = strComment;
        if (commentsCount > 1) {
            lbComment.text = "commentaires";
        }
        else
        {
            lbComment.text = "commentaire";
        }
        
        //timer
        let inputFormatter: NSDateFormatter = ASSharedTimeFormatter.sharedFormatter.inputFormatter();
        let outputFormatterBis: NSDateFormatter = ASSharedTimeFormatter.sharedFormatter.timeFormatter();
        ASSharedTimeFormatter.checkFormatString("yyyy-MM-dd'T'HH:mm:ssZZZZ", forFormatter: inputFormatter);
        ASSharedTimeFormatter.checkFormatString("dd-MM-yyyy H:mm", forFormatter: outputFormatterBis);
        if let relativeTime = publicationDic["created"]
        {
            let inputDate: NSDate = inputFormatter.dateFromString(relativeTime as! String)!;
            let outputString: String = outputFormatterBis.stringFromDate(inputDate);
            self.time.text = outputString;
        }
        //share
        if let dicShare = publicationDic["sharing"] {
            var iShare: NSInteger = 0;
            if let valShare = dicShare["share"] {
                iShare = valShare as! NSInteger
            }
            var strShare: String! = String();
            switch (iShare) {
            case 0:
                strShare = str(strMoi);
                break;
            case 1:
                strShare = str(strAAmis);
                break;
            case 3:
                strShare = str(strTous_les_natiz);
                break;
            default:
                break;
            }
            //Involve group/chasse
            let arrGroupsName: NSMutableArray! = NSMutableArray();
            let strGroupsName: String;
            if let arrG = publicationDic["groups"] {
                for gDic in (arrG as! NSArray) {
                    arrGroupsName.addObject(gDic["name"] as! String);
                }
            }
            let attString: NSMutableAttributedString = NSMutableAttributedString();
            attString.appendAttributedString(NSAttributedString(string: strShare));
            if (arrGroupsName.count > 0) {
                attString.appendAttributedString(NSAttributedString(string: "\n"));
                strGroupsName = arrGroupsName.componentsJoinedByString(", ");
                let mGroup: NSMutableAttributedString = NSMutableAttributedString(string: "Groupe: ");
                mGroup.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(13.0), range: NSMakeRange(0, 7));
                mGroup.appendAttributedString(NSAttributedString(string: strGroupsName));
                attString.appendAttributedString(mGroup);
            }
            //Chasse
            let arrChassesName: NSMutableArray = NSMutableArray();
            var strChassesName: String = String();
            if let arrH = publicationDic["hunts"] {
                for gDic in (arrH as! NSArray) {
                    arrGroupsName.addObject(gDic["name"] as! String);
                }
            }
            if(arrChassesName.count > 0)
            {
                attString.appendAttributedString(NSAttributedString(string: "\n"));
                strChassesName = arrChassesName.componentsJoinedByString(", ");
                let mHunt: NSMutableAttributedString = NSMutableAttributedString(string: "Chasses: ");
                mHunt.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(13.0), range: NSMakeRange(0, 7));
                mHunt.appendAttributedString(NSAttributedString(string: strChassesName));
                attString.appendAttributedString(mHunt);
                
            }
            //Receiver & Observation
            if let arrObservation = publicationDic["observations"], let dicObservation: NSDictionary = arrObservation.firstObject as? NSDictionary {
                var arrSharingReciever: NSArray! = NSArray();
                if let arrSR = dicObservation["sharing_receiver"] {
                    arrSharingReciever = arrSR as! NSArray;
                }
                //Receiver
                let arrReceiverName: NSMutableArray = NSMutableArray();
                var strReceiverName: String = String();
                
                for gDic in arrSharingReciever {
                    if let name = gDic["name"] {
                        arrReceiverName.addObject(name as! String);
                    }
                }
                if (arrReceiverName.count > 0) {
                    attString.appendAttributedString(NSAttributedString(string: "\n"));
                    strReceiverName = arrReceiverName.componentsJoinedByString(", ");
                    let mReceiver: NSMutableAttributedString = NSMutableAttributedString(string: "Sentinelle: ");
                    mReceiver.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(13.0), range: NSMakeRange(0, 7));
                    mReceiver.appendAttributedString(NSAttributedString(string: strReceiverName));
                    attString.appendAttributedString(mReceiver);
                }
                
                //observation tree
                self.observation.textColor = color;
                var arrTree: NSArray! = NSArray();
                if let arrT = dicObservation["tree"] {
                    arrTree = arrT as! NSArray;
                }
                let mutString: NSMutableString = NSMutableString();
                if arrTree.count > 0 {
                    for i in 0...(arrTree.count - 1) {
                        let strName: String = arrTree[i] as! String;
                        mutString.appendString(strName);
                        if (i != arrTree.count - 1) {
                            mutString.appendString(" / ");
                        }
                    }
                }
                self.constraintHeightObservationIcon.constant = 15;
                self.observation.text = mutString as String;
                self.obs_label_static.hidden =  false;
                self.ongNhom.hidden = false;
                self.obs_label_static.hidden = false;
                self.obs_tree_content.text = "";
                self.imageLeftIndice.hidden = true;
                if let arrAttachment = (dicObservation["attachements"] as? NSArray){
                    
                    if arrAttachment.count > 0 {
                        let mAttach: NSMutableAttributedString = NSMutableAttributedString();
                        for i in 0...(arrAttachment.count - 1) {
                            
                            let attchDic: NSDictionary? = arrAttachment[i] as? NSDictionary;
                            let attrs: [String: AnyObject] = [NSForegroundColorAttributeName: UIColor.blackColor()];
                            let strLabel: String = "\(attchDic!["label"]): ";
                            let mLabel: NSMutableAttributedString = NSMutableAttributedString(string: strLabel, attributes: attrs);
                            //Add label
                            mAttach.appendAttributedString(mLabel);
                            let attrsVal: [String: AnyObject] = [NSForegroundColorAttributeName: color];
                            let mValue: NSMutableAttributedString = NSMutableAttributedString(string: "");
                            if (attchDic!["value"] is String) {
                                mValue.appendAttributedString(NSAttributedString(string: attchDic!["value"] as! String));
                            }
                            else if(attchDic!["values"] is NSArray)
                            {
                                let mArr: NSArray = attchDic!["values"] as! NSArray;
                                for i in 0...(mArr.count - 1) {
                                    let str: String = attchDic!["values"]![i] as! String;
                                    mValue.appendAttributedString(NSAttributedString(string: str));
                                    if (mArr.count > 1 && i < mArr.count - 1) {
                                        mValue.appendAttributedString(NSAttributedString(string: ", "));
                                    }
                                }
                            }
                            let strValue: NSMutableAttributedString = NSMutableAttributedString(string: mValue.string, attributes: attrsVal);
                            mAttach.appendAttributedString(strValue);
                            if (i != arrAttachment.count - 1) {
                                mAttach.appendAttributedString(NSAttributedString(string: "\n"));
                            }
                        }
                        self.obs_tree_content.attributedText = mAttach;
                        self.imageLeftIndice.hidden = false;
                        
                    }
                    else
                    {
                        self.obs_tree_content.text = "";
                        self.imageLeftIndice.hidden = true;
                    }
                }
                if (arrTree.count == 0) {
                    self.ongNhom.hidden = true;
                    self.obs_label_static.hidden = true;
                }

            }
            else
            {
                self.constraintHeightObservationIcon.constant = 0;
                self.obs_label_static.hidden = true;
                self.imageLeftIndice.hidden = true;
                self.obs_label_static.hidden = true;
                self.ongNhom.hidden = true;
                self.observation.text = "";
                self.obs_tree_content.text = "";
            }
            self.shareType.attributedText = attString;
        }
        //geo location
        if let geo = publicationDic["geolocation"] as? NSDictionary, let lat = geo["latitude"] as? String, let long = geo["longitude"] as? String{
            //
            self.lat.text = String(format: "Lat. %.5f", Float(lat)!)
            self.longtitude.text = String(format: "Lng. %.5f", Float(long)!)
            
            if let alt = geo["latitude"] as? String{
                self.alt.text = String(format: "Alt. %.5f", Float(alt)!)
                
            }
            else
            {
                self.alt.text = "";
            }
            if let address = geo["address"] as? String
            {
                self.locationTxt.text = address;
                self.imgLocation.hidden = false;
                
            }
            else
            {
                self.locationTxt.text = "";
                self.imgLocation.hidden = true;
            }
        }
        else
        {
            self.lat.text = "";
            self.longtitude.text = "";
            self.alt.text = "";
            self.locationTxt.text = "";
            self.imgLocation.hidden = true;
        }
        //description
        if let content = publicationDic["content"] {
            let messageContent: String = "\(content as! String)";
            self.myContent.text = messageContent;
            //        NSMutableAttributedString* attrStr = [self.myContent.attributedText mutableCopy];
            //        [attrStr modifyParagraphStylesWithBlock:^(OHParagraphStyle *paragraphStyle) {
            //            paragraphStyle.textAlignment = kCTJustifiedTextAlignment;
            //            paragraphStyle.lineBreakMode = kCTLineBreakByWordWrapping;
            //            paragraphStyle.paragraphSpacing = 0.f;
            //            paragraphStyle.lineSpacing = 0.0f;
            //            }];
            //
            //        if ([messageContent hasSubString:@"<a href="]) {
            //            self.myContent.attributedText = [OHASBasicHTMLParser attributedStringByProcessingMarkupInAttributedString:attrStr];
            //        } else {
            //            self.myContent.attributedText = attrStr;
            //        }
            //
            //        self.myContent.automaticallyAddLinksForType = NSTextCheckingTypeDate|NSTextCheckingTypeAddress|NSTextCheckingTypeLink|NSTextCheckingTypePhoneNumber;
            
        }
        self.btnLike.selected = false;
        self.btnIconLike.selected =  false;
        if let userLike = publicationDic["isUserLike"] {
            if userLike as? NSInteger == 1 {
                self.btnLike.selected = true;
                self.btnIconLike.selected =  true;
            }
        }

    }
    func setThemeWithFromScreen(isScreen: ISSCREEN) {
        self.iWhoIamI = isScreen;
        var color: UIColor = UIColor();
        switch isScreen {
        case ISSCREEN.ISLOUNGE:
            color = UIColorFromRGB(CHASSES_MAIN_BAR_COLOR);
            self.btnIconLike.setImage(UIImage(named: "chasse_ic_like"), forState: UIControlState.Selected)
            self.imgSetting.image = UIImage(named: "ic_chasse_setting_active");
            self.btnInfo.setBackgroundImage(UIImage(named: "ic_chasse_info"), forState: UIControlState.Normal)
            break;
        case ISSCREEN.ISGROUP:
            color = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
            self.btnIconLike.setImage(UIImage(named: "group_ic_like"), forState: UIControlState.Selected)
            self.imgSetting.image = UIImage(named: "ic_group_setting_info");
            self.btnInfo.setBackgroundImage(UIImage(named: "ic_group_setting_active"), forState: UIControlState.Normal)
            break;
        case ISSCREEN.ISLIVEMAP:
            color = UIColorFromRGB(LIVE_MAP_MAIN_BAR_COLOR);
            self.btnIconLike.setImage(UIImage(named: "live_ic_like"), forState: UIControlState.Selected)
            self.imgSetting.image = UIImage(named: "live_ic_setting");
            self.btnInfo.setBackgroundImage(UIImage(named: "ic_chasse_info"), forState: UIControlState.Normal)
            break;
        default:
            color = UIColorFromRGB(MUR_MAIN_BAR_COLOR);
            self.btnIconLike.setImage(UIImage(named: "mur_ic_post_like"), forState: UIControlState.Selected)
            self.btnInfo.setBackgroundImage(UIImage(named: "mur_ic_info"), forState: UIControlState.Normal)
            break;
        }
        
        self.btnIconLike.setImage(UIImage(named: "mur_ic_post_unlike"), forState: UIControlState.Normal)
        self.title.tintColor = color;
        self.location.setTitleColor(color, forState: UIControlState.Normal)
        self.btnLike.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        self.btnLike.setTitleColor(color, forState: UIControlState.Selected);
        
    }
}