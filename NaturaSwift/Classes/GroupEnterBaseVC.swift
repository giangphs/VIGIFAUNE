//
//  GroupEnterBaseVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/18/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class GroupEnterBaseVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad();
        self.addMainNav("MainNavMUR");
        //set Title
        let subview: MainNavigationBaseView = navigation.viewNavigation1.viewWithTag(TAG_MAIN_NAV_VIEW) as! MainNavigationBaseView;
        subview.myTitle.text = str(strGROUPES);
        //Change background color
        subview.backgroundColor = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
        //setup tabbar
        setupTabBar(.TABBAR_TOP,target: .ISGROUP);

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated);
    }
}