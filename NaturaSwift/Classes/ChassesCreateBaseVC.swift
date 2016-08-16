//
//  ChassesCreateBaseVC.swift
//  NaturaSwift
//
//  Created by Giang on 7/22/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation


class ChassesCreateBaseVC: BaseVC {

    var needChangeMessageAlert: Bool!
    var myTypeView: AGENDA_CREATE_ADD_VIEW!

    @IBOutlet var btnSuivant:UIButton!;
    
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        self.addMainNav("MainNavMUR");
        //set Title
        let subview: MainNavigationBaseView = navigation.viewNavigation1.viewWithTag(TAG_MAIN_NAV_VIEW) as! MainNavigationBaseView;
        subview.myTitle.text = str(strGROUPES);
        //Change background color
        subview.backgroundColor = UIColorFromRGB(CHASSES_MAIN_BAR_COLOR);
        //setup tabbar
        setupTabBar(.TABBAR_PRE,target: .ISLOUNGE);
        
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