//
//  MDStatusButton.swift
//  NaturaSwift
//
//  Created by Manh on 7/19/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class MDStatusButton: UIButton {
    var  colorEnable:UIColor!;
    var  colorDisEnable:UIColor!;
    var  imgEnable:UIImage!;
    var  imgDisEnable:UIImage!;
    override init(frame: CGRect) {
        super.init(frame: frame);
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override func awakeFromNib() {
        super.awakeFromNib();
        colorDisEnable = UIColor.lightGrayColor();
        colorEnable = self.backgroundColor;
        imgEnable = self.currentBackgroundImage;
        imgDisEnable = UIImage(named: "gray_btn_bg");
    }
    override var enabled:Bool{
        didSet {
            //Your code
            if enabled {
                self.backgroundColor = colorEnable;
                self.setBackgroundImage(imgEnable, forState: .Normal);
            }
            else
            {
                self.backgroundColor = colorDisEnable;
                self.setBackgroundImage(imgDisEnable, forState: .Normal);
            }
        }
    }
}