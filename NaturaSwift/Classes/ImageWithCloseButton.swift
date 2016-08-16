//
//  ImageWithCloseButton.swift
//  NaturaSwift
//
//  Created by Manh on 7/21/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
typealias clickClose = (index: NSInteger) ->()
class ImageWithCloseButton: UIView {
    @IBOutlet var imageContent:UIImageView!;
    var myCallback: clickClose!;
    override func awakeFromNib() {
        super.awakeFromNib();

    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    func fnOncallback(callback: (index: NSInteger) ->()) {
        myCallback = callback;
    }

    @IBAction func onClose(sender: UIButton)
    {
        if self.myCallback != nil {
            self.myCallback(index: 0);
        }
    }
}