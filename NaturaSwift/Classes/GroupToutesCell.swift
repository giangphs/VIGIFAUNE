//
//  GroupToutesCell.swift
//  NaturaSwift
//
//  Created by Manh on 7/19/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class GroupToutesCell: CellBase {
    @IBOutlet var       btnRejoindre:MDStatusButton!;
    @IBOutlet var       btnMember:MDStatusButton!;
    @IBOutlet var       usericonImages:UIImageView!;
    @IBOutlet var       titleNameLabel:UILabel!;
    @IBOutlet var       publicAccessLabel:UILabel!;
    @IBOutlet var       descLabel:UILabel!;
    @IBOutlet var       viewBorder:UIView!;
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.viewBorder.layer.masksToBounds = true;
        self.viewBorder.layer.cornerRadius  = 5.0;
        self.viewBorder.layer.borderWidth   = 0.5;
        self.viewBorder.layer.borderColor   = UIColor.lightGrayColor().CGColor;
        
        self.usericonImages.layer.masksToBounds = true;
        self.usericonImages.layer.cornerRadius  = self.usericonImages.frame.size.height/2;
        self.usericonImages.layer.borderWidth   = 0;
    }
    func fnSetColor(color: UIColor) {
        self.titleNameLabel.textColor       = color;
        self.btnMember.backgroundColor      = color;
        self.btnRejoindre.backgroundColor   = color;
    }
    func fnSettingCell(type: UI_TYPE) {
        switch type {
        case UI_TYPE.UI_GROUP_MUR_ADMIN:
            self.fnSetColor(UIColorFromRGB(GROUP_MUR_ADMIN_COLOR));
            break;
        case UI_TYPE.UI_GROUP_MUR_NORMAL:
            self.fnSetColor(UIColorFromRGB(GROUP_MUR_NORMAL_COLOR));
            break;
        case UI_TYPE.UI_GROUP_TOUTE:
            self.fnSetColor(UIColorFromRGB(GROUP_TOUS_COLOR));
            break;
        case UI_TYPE.UI_CHASSES_MUR_ADMIN:
            self.fnSetColor(UIColorFromRGB(CHASSES_TINY_BAR_COLOR));
            break;
        case UI_TYPE.UI_CHASSES_MUR_NORMAL:
            self.fnSetColor(UIColorFromRGB(CHASSES_TINY_BAR_COLOR));
            break;
        default:
            break;
        }
    }
}