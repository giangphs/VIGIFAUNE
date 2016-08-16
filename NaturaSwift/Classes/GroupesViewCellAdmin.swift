//
//  GroupesViewCellAdmin.swift
//  NaturaSwift
//
//  Created by Manh on 7/15/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class GroupesViewCellAdmin: GroupesViewBaseCell {
    override func awakeFromNib() {
        super.awakeFromNib();
        let tmpV: UIView = viewWithTag(POP_MENU_VIEW_TAG2)!;
        tmpV.backgroundColor = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
        self.imgBackGroundSetting.image = UIImage(named: "group_ic_bg_setting");
        self.imgSettingSelected.image = UIImage(named: "ic_admin_setting");
        self.imgSettingNormal.image = UIImage(named: "group_ic_setting");

    }
}