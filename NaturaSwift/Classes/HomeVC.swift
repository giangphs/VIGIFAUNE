//
//  HomeVC.swift
//  NaturaSwift
//
//  Created by Manh on 6/23/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class HomeVC: UIViewController {
    
    @IBOutlet var btnMur:UIButton?
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: false);
    }
    
    @IBAction func onClickHomeItem(sender: UIButton)
    {

        switch (sender.tag - 10) {
        case 0:
            let vc:MurVC = MurVC(nibName: String(MurVC), bundle: nil);
            pushVC(vc);
            break;
            
        case 1:
            let vc:MapGlobalVC = MapGlobalVC(nibName: String(MapGlobalVC), bundle: nil);
            pushVC(vc);
            break;
            
        case 3:
            let vc:GroupMesVC = GroupMesVC(nibName: String(GroupMesVC), bundle: nil);
            vc.expectTarget = .ISGROUP;
            pushVC(vc);
            break;
            
        case 4:
            let vc:ChassesMurVC = ChassesMurVC(nibName: String(ChassesMurVC), bundle: nil);
            vc.expectTarget = .ISLOUNGE;

            pushVC(vc);
            break;

        case 9:
            
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.loadLoginView()
            break
            
            
        default:
            break;
        }
    }
    
    func pushVC(vc: UIViewController) {
        let navigationController: MainNavigationController = self.navigationController as! MainNavigationController
        navigationController.pushViewController(vc, animated: true) {
        }
    }
    
}