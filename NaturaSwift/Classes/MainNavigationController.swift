//
//  MainNavigationController.swift
//  NaturaSwift
//
//  Created by Manh on 7/5/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class MainNavigationController: UINavigationController, UINavigationControllerDelegate {
    //MARK: - VARIABLE
    var completionBlock: dispatch_block_t!;
    var pushedVC: UIViewController!;
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.delegate = self;
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController);
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if completionBlock != nil && pushedVC == viewController {
            completionBlock();
        }
        self.completionBlock = nil;
        self.pushedVC = nil;
    }
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if self.pushedVC != viewController {
            self.pushedVC = nil;
            self.completionBlock = nil;
        }
    }
    func pushViewController(viewController: UIViewController, animated: Bool, completion: dispatch_block_t) {
        self.pushedVC = viewController;
        self.completionBlock = completion;
        self.pushViewController(viewController, animated: animated);
    }
}