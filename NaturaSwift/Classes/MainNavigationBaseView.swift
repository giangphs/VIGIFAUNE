//
//  MainNavigationBaseView.swift
//  NaturaSwift
//
//  Created by Manh on 7/5/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
typealias callBackMainNav = (button: UIButton) ->()
class MainNavigationBaseView: UIView {
    @IBOutlet var myTitle: UILabel!;
    @IBOutlet var uploadConstraintWidth: NSLayoutConstraint!;
    @IBOutlet var imgUpload: UIImageView!;
    var myMainNavCallBack: callBackMainNav!;
    
    @IBAction func fnMainNavClick(sender: UIButton) {
        if self.myMainNavCallBack != nil {
            self.myMainNavCallBack(button: sender);
        }
    }
    func badgingBtn(img: UIImageView , iCount: Int) {
        img.fnbadgeView().font = UIFont.boldSystemFontOfSize(10.0);
        img.fnbadgeView().badgeValue = iCount;
        img.fnbadgeView().outlineWidth = 1.0;
        img.fnbadgeView().postion = MGBadePosition.MGBadgePositionTopRight;
        img.fnbadgeView().outlineColor = UIColor.whiteColor();
        img.fnbadgeView().badgeColor = UIColor.redColor();
        img.fnbadgeView().textColor = UIColor.whiteColor();

    }
}