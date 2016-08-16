//
//  ImageViewAction.swift
//  NaturaSwift
//
//  Created by Manh on 6/29/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class ImageViewAction: UIImageView {
    //MARK: - VARIABLE
    var oncallback:((index: NSInteger) ->())!;
    var indexPath: NSInteger!;
    var url: String!;
    var singleTap: UITapGestureRecognizer!;
    //MARK: - INIT
    override func awakeFromNib() {
        super.awakeFromNib();
    }
    //MARK: - ACTION
    func fnRemoveClick() {
        if singleTap != nil {
            self.removeGestureRecognizer(singleTap);
        }
    }
    func fnOncallback(callback: (index: NSInteger) ->()) {
        singleTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected));
        singleTap.numberOfTapsRequired = 1;
        self.userInteractionEnabled = true;
        self.addGestureRecognizer(singleTap);
        oncallback = callback;
    }
    @IBAction func tapDetected(sender: UIButton)
    {
        if oncallback != nil {
            oncallback(index: indexPath);
        }
    }
}