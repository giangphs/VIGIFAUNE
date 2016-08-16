//
//  GroupCreateBaseVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/21/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class GroupCreateBaseVC: BaseVC {
    //MARK: - OUTLET
    @IBOutlet var btnSuivant:UIButton!;
    //MARK: - VARIABLE
    var needChangeMessageAlert: Bool!;
    var myTypeView:GROUP_CREATE_ADD_VIEW!;
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        self.addMainNav("MainNavMUR");
        //set Title
        let subview: MainNavigationBaseView = navigation.viewNavigation1.viewWithTag(TAG_MAIN_NAV_VIEW) as! MainNavigationBaseView;
        subview.myTitle.text = str(strGROUPES);
        //Change background color
        subview.backgroundColor = UIColorFromRGB(GROUP_MAIN_BAR_COLOR);
        //setup tabbar
        setupTabBar(.TABBAR_PRE, target: .ISGROUP);

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
    override func onSubNavClick(index: Int) {
        switch index {
        case 0: // PRECEDENT
            self.gotoback();
            break;
        case 1: // ANULER
            break;
        default:
            break;
        }

    }
}