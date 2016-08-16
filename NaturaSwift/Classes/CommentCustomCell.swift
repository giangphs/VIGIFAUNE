//
//  CommentCustomCell.swift
//  NaturaSwift
//
//  Created by Manh on 6/30/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
class CommentCustomCell: CellBase {
    //MARK: - VARIABLE
    @IBOutlet var likeButton: UIButton!;
    @IBOutlet var commentTitleLabel: UILabel!;
    @IBOutlet var iconLike: UIImageView!;
    @IBOutlet var commentUserImage: UIImageView!;
    @IBOutlet var commentdateLabel: UILabel!;
    @IBOutlet var commentCountView: UIView!;
    @IBOutlet var commentLabel: UILabel!;
    var iAmScreen: ISSCREEN = ISSCREEN.ISMUR;
    override func awakeFromNib() {
        super.awakeFromNib();
        self.imgBackGroundSetting.image = UIImage(named: "bg_setting_post");
        self.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
        self.imgSettingNormal.image = UIImage(named: "mur_ic_action_setting_post");

    }
    func assignValuesHeaderSection(dic: NSDictionary)  {
        var strIconLike: String!;
        var strColor: UInt;
        likeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
        switch iAmScreen {
        case ISSCREEN.ISLOUNGE:
            strIconLike = "chasse_ic_like";
            strColor = CHASSES_MAIN_BAR_COLOR;
            self.imgBackGroundSetting.image = UIImage(named: "chasse_bg_setting");
            self.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
            self.imgSettingNormal.image = UIImage(named: "ic_chasse_setting_active");

            break;
        case ISSCREEN.ISGROUP:
            strIconLike = "group_ic_like";
            strColor = GROUP_MAIN_BAR_COLOR;
            self.imgBackGroundSetting.image = UIImage(named: "group_ic_bg_setting");
            self.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
            self.imgSettingNormal.image = UIImage(named: "group_ic_setting");
            break;
        case ISSCREEN.ISLIVEMAP:
            strIconLike = "live_ic_like";
            strColor = LIVE_MAP_MAIN_BAR_COLOR;
            self.imgBackGroundSetting.image = UIImage(named: "live_bg_setting");
            self.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
            self.imgSettingNormal.image = UIImage(named: "live_ic_setting");

            break;
        default:
            strIconLike = "mur_ic_post_like";
            strColor = MUR_MAIN_BAR_COLOR;
            self.imgBackGroundSetting.image = UIImage(named: "bg_setting_post");
            self.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
            self.imgSettingNormal.image = UIImage(named: "mur_ic_action_setting_post");
            break;
        }
        if self.viewMenu != nil {
            self.viewMenu.backgroundColor = UIColorFromRGB(strColor);
        }
        //color title
        self.commentTitleLabel.textColor = UIColorFromRGB(strColor);
        //like
        likeButton.setTitleColor(UIColorFromRGB(strColor), forState: UIControlState.Selected);
        //name
        if let owner = dic["owner"] as? NSDictionary  {
            let strUserName = "\(owner["firstname"] as! String) \(owner["lastname"] as! String)";
            commentTitleLabel.text = strUserName;
        }
        //time
        if let relativeTime = dic["created"] as? String
        {
            let outputString: String = NSDate.convertNSStringDateToNSDateX1(relativeTime)!.timeAgo();
            commentdateLabel.text = outputString;
        }
        //content
        if let content = dic["content"] as? String {
            commentLabel.text = content;
        }
        //profile
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
        
        let url: NSURL = NSURL(string: strImage)!;
        let placeholder_avatar: UIImage = UIImage(named: "placeholder_photo")!;
        self.commentUserImage.sd_setImageWithURL(url, placeholderImage: placeholder_avatar, completed: { (image, error, cachetype, url) in
        });
        //like
        self.likeButton.selected = false;
        self.iconLike.image = UIImage(named: "mur_ic_post_unlike");
        if let userLike = dic["isUserLike"] {
            if userLike as? NSInteger == 1 {
                self.likeButton.selected = true;
                self.iconLike.image = UIImage(named: strIconLike);
            }
        }

    }

}