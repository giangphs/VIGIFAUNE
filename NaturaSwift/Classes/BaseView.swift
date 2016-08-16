//
//  BaseView.swift
//  NaturaSwift
//
//  Created by Manh on 6/27/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
}

class BaseView: UIView {
    @IBOutlet var tableControl: UITableView!;
    
    func initRefreshControl() {
        tableControl.addPullToRefreshWithActionHandler { 
            self.insertRowAtTop()
        }
        
        tableControl.addInfiniteScrollingWithActionHandler { 
            self.insertRowAtBottom()
        }
    }
    
    func startRefreshControl() {
        tableControl.triggerPullToRefresh()
    }
    
    func moreRefreshControl() {
        tableControl.triggerInfiniteScrolling()
    }
    func stopRefreshControl() {
        tableControl.pullToRefreshView.stopAnimating()
        tableControl.infiniteScrollingView.stopAnimating()
    }
    
    func isRemoveScrollingViewHeight(enable: Bool) {
        
    }
    //overwrite
    func insertRowAtTop() {
        
    }
    //overwrite
    func insertRowAtBottom() {
        
    }
}