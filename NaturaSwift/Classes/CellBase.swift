//
//  CellBase.swift
//  NaturaSwift
//
//  Created by Manh on 6/24/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit

//typealias callBackGroup = (index: Int) ->()

typealias callBackDismiss = (index: Int) ->()

class CellBase: UITableViewCell {
    
    
    var CallBackGroup: callBackGroup!
    var CallBackdDismiss: callBackDismiss!

    @IBOutlet var mainView: UIView!;
    @IBOutlet var btnHideMenu: UIButton!;
    @IBOutlet var imgBackGroundSetting: UIImageView!;
    @IBOutlet var imgSettingSelected: UIImageView!;
    @IBOutlet var imgSettingNormal: UIImageView!;
    @IBOutlet var btnSetting: UIButton!;
    
    var viewMenu: UIView!;

    override func awakeFromNib() {
        super.awakeFromNib();
        if (imgBackGroundSetting != nil) {
            self.imgBackGroundSetting.hidden = true;
        }
    }
    func createMenuList(arr: NSArray) {
        if (self.viewMenu != nil) {
            self.hide();
        }
        self.viewMenu = nil;
        if arr.count == 1 {
            self.viewMenu = self.viewWithTag(POP_MENU_VIEW_TAG1);
            let item1: UIButton = self.viewMenu.viewWithTag(MENU_ITEM_TAG1) as! UIButton;
            item1.setTitle(arr[0] as? String, forState: UIControlState.Normal);
            item1.addTarget(self, action: #selector(dismissMenuItem) , forControlEvents: UIControlEvents.TouchUpInside);

        }
        else
        {
            self.viewMenu = self.viewWithTag(POP_MENU_VIEW_TAG2);
            let item1: UIButton = self.viewMenu.viewWithTag(MENU_ITEM_TAG1) as! UIButton;
            let item2: UIButton = self.viewMenu.viewWithTag(MENU_ITEM_TAG2) as! UIButton;
            
            item1.setTitle(arr[0] as? String, forState: UIControlState.Normal);
            item2.setTitle(arr[1] as? String, forState: UIControlState.Normal);

            item1.addTarget(self, action: #selector(dismissMenuItem) , forControlEvents: UIControlEvents.TouchUpInside);
            item2.addTarget(self, action: #selector(dismissMenuItem) , forControlEvents: UIControlEvents.TouchUpInside);

        }
        self.viewMenu.layer.masksToBounds = true;
        self.viewMenu.layer.cornerRadius = 4;
        self.btnHideMenu.addTarget(self, action: #selector(hideMenu), forControlEvents: UIControlEvents.TouchUpInside);
    }
    func show() {
        self.viewMenu.hidden = false;
        self.imgBackGroundSetting.hidden = false;
        self.imgSettingNormal.hidden = true;
        self.imgSettingSelected.hidden = false;
        self.btnHideMenu.hidden = false;
        self.btnHideMenu.bringSubviewToFront(self);
    }
    func hide() {
        self.viewMenu.hidden = true;
        self.imgBackGroundSetting.hidden = true;
        self.imgSettingNormal.hidden = false;
        self.imgSettingSelected.hidden = true;
        self.btnHideMenu.hidden = true;
    }
    @IBAction func hideMenu(sender: UIButton)
    {
        self.hide();
    }
    @IBAction func dismissMenuItem(sender: UIButton)
    {
        let index: Int = sender.tag;
        if (CallBackGroup != nil ) {
            if index == 11 {
                CallBackGroup(index: 1);
            }
            else if(index == 10)
            {
                CallBackGroup(index: 0);
            }
        }
        self.hide();
    }
    override func prepareForReuse() {
        super.prepareForReuse();
        if (self.viewMenu != nil) {
            self.hide();
        }
    }
}
