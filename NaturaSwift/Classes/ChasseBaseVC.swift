//
//  ChasseBaseVC.swift
//  NaturaSwift
//
//  Created by Giang on 7/19/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation

class ChasseBaseVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad();
        self.addMainNav("MainNavMUR");
        //set Title
        let subview: MainNavigationBaseView = navigation.viewNavigation1.viewWithTag(TAG_MAIN_NAV_VIEW) as! MainNavigationBaseView;
        subview.myTitle.text = str(strCHANTIERS);
        //Change background color
        subview.backgroundColor = UIColorFromRGB(CHASSES_MAIN_BAR_COLOR);
        //setup tabbar
        setupTabBar(.TABBAR_TOP,target: .ISLOUNGE);

        initRefreshControl()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
}
