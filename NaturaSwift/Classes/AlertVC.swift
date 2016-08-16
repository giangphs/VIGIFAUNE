
//
//  AlertVC.swift
//  NaturaSwift
//
//  Created by Manh on 7/22/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
typealias  AlertVCCallback = (index: BUTTON_ALERT)->()
enum BUTTON_ALERT: Int
{
    case BUTTON_CANCEL = 0
    case BUTTON_OK
    case BUTTON_OTHER
};
class AlertVC: UIView {
    //MARK: - OUTLET
    @IBOutlet var     subAlertView:UIView!;
    @IBOutlet var     lbTitle:UILabel!;
    @IBOutlet var     lbDescriptions:UILabel!;
    @IBOutlet var     cancelButton:UIButton!;
    @IBOutlet var     otherButton:UIButton!;
    var callback: AlertVCCallback!;
    //MARK: - FUNC
    class func showAlert(title: String, message:  String, tapBlock: AlertVCCallback) {
        //set text
        
        //add view
        let app:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        let view: AlertVC = UIView.loadFromNibNamed(String(AlertVC))! as! AlertVC;
        view.callback = tapBlock;
        view.lbTitle.text = title;
        view.lbDescriptions.text = message;
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2);
        view.frame = (app.window?.frame)!;
        app.window?.addSubview(view);
        //add contraint
        let strContraintV: String = "V:|-(0)-[view]-(0)-|";
        app.window!.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(strContraintV, options: [], metrics: nil, views:["view" : view]));
        let strContraintH: String = "H:|[view]|";
        app.window!.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(strContraintH, options: [], metrics: nil, views:["view" : view]))


    }
    @IBAction func closeAction(sender: UIButton)
    {
        self.removeFromSuperview();
        if (callback != nil) {
            callback(index: .BUTTON_CANCEL);
        }

    }
    @IBAction func OUIAction(sender: UIButton)
    {
        self.removeFromSuperview();
        if (callback != nil) {
            callback(index: .BUTTON_OK);
        }
    }
}