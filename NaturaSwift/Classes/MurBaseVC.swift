//
//  MurBaseVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/5/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class MurBaseVC: BaseVC {
    override func viewDidLoad() {
        super.viewDidLoad();
        addMainNav(String(MainNavMUR));
        let mainView: MainNavigationBaseView = navigation.viewNavigation1.viewWithTag(TAG_MAIN_NAV_VIEW) as! MainNavigationBaseView;
        mainView.myTitle.text = "MUR";
        mainView.backgroundColor = UIColorFromRGB(MUR_MAIN_BAR_COLOR);
        //setup tabbar
        setupTabBar(.TABBAR_TOP,target: .ISMUR);
    }

}