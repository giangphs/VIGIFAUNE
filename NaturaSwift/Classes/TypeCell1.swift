//
//  TypeCell1.swift
//  NaturaSwift
//
//  Created by Giang on 7/20/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation

class TypeCell1: CellBase {
    
    @IBOutlet var       btnRejoindre:MDStatusButton!;
    @IBOutlet var       btnMember:MDStatusButton!;
    @IBOutlet var       usericonImages:UIImageView!;
    @IBOutlet var       titleNameLabel:UILabel!;
    @IBOutlet var       publicAccessLabel:UILabel!;
    @IBOutlet var       descLabel:UILabel!;
    @IBOutlet var       viewBorder:UIView!;
    
    @IBOutlet var       view1:UIView!;
    @IBOutlet var       view2:UIView!;
    @IBOutlet var       view3:UIView!;
    @IBOutlet var       view4:UIView!;
    
    
    @IBOutlet var       Img1:UIImageView!;
    @IBOutlet var       Img2:UIImageView!;
    @IBOutlet var       Img3:UIImageView!;
    @IBOutlet var       Img4:UIImageView!;
    @IBOutlet var       Img5:UIImageView!;
    @IBOutlet var       Img6:UIImageView!;
    @IBOutlet var       Img7:UIImageView!;
    @IBOutlet var       Img8:UIImageView!;
    
    
    @IBOutlet var       label1:UILabel!;
    @IBOutlet var       label2:UILabel!;
    @IBOutlet var       label3:UILabel!;
    @IBOutlet var       label4:UILabel!;
    @IBOutlet var       label5:UILabel!;
    @IBOutlet var       label6:UILabel!;
    @IBOutlet var       label7:UILabel!;
    @IBOutlet var       label8:UILabel!;
    
    @IBOutlet var       label9:SOLabel!;
    
    @IBOutlet var       label10:UILabel!;
    @IBOutlet var       label11:UILabel!;
    @IBOutlet var       label12:UILabel!;
    
    
    @IBOutlet var       button1:MDStatusButton!;
    @IBOutlet var       button2:MDStatusButton!;
//    @IBOutlet var       button3:UIButton!
    @IBOutlet var       button4:UIButton!
    @IBOutlet var       button5:UIButton!
    
    @IBOutlet var       btnLocation:UIButton!
    
    @IBOutlet var       constraintHeight:NSLayoutConstraint!;
    @IBOutlet var       constraintHeight2:NSLayoutConstraint!;
    @IBOutlet var       btnLabel:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tmpV: UIView = viewWithTag(POP_MENU_VIEW_TAG2)!
        tmpV.backgroundColor = UIColorFromRGB(CHASSES_MAIN_BAR_COLOR)
        imgBackGroundSetting.image = UIImage.init(named: "chasse_bg_setting")
        imgSettingSelected.image = UIImage.init(named: "ic_admin_setting")
        imgSettingNormal.image = UIImage.init(named: "ic_chasse_setting_active")
        
    }
    
    func fnSetColor(color : UIColor) -> Void {
        self.label1.textColor = color
        self.label3.textColor = color
        self.label9.textColor = color
        self.button1.backgroundColor = color
    }
    
    func fnSettingCell(type: UI_TYPE) -> Void {
        
        switch type {
            
        case .UI_GROUP_MUR_ADMIN:
            
            fnSetColor(UIColorFromRGB(GROUP_TINY_BAR_COLOR))
            self.button1.setBackgroundImage(UIImage.init(named: "btn_blue_bg"), forState: UIControlState.Normal)
            self.button2.setBackgroundImage(UIImage.init(named: "btn_blue_bg"), forState: UIControlState.Normal)
            self.Img6.image = UIImage.init(named: "ic_close")
            self.button1.setTitle("PARTICIPANTS", forState: UIControlState.Normal)
            self.Img7.hidden = true
            self.view3.hidden = true
            self.view4.hidden = true
            self.Img4.hidden = true
            self.constraintHeight.constant = 0;
            self.constraintHeight2.constant = 0;
            
            break;
        case .UI_GROUP_MUR_NORMAL:
            fnSetColor(UIColorFromRGB(GROUP_TINY_BAR_COLOR))
            break;
            
        case .UI_CHASSES_MUR_ADMIN:
            
            fnSetColor(UIColorFromRGB(CHASSES_TINY_BAR_COLOR))
            self.button2.backgroundColor = UIColorFromRGB(CHASSES_TINY_BAR_COLOR)
            self.label12.textColor = UIColorFromRGB(BUTTON_DESINSCRIRE_COLOR)
            
            self.Img7.hidden = false
            self.view3.hidden = false
//            self.button3.hidden = false

            self.view4.hidden = false
            self.Img4.hidden = false
            
            self.constraintHeight.constant = 23;
            self.constraintHeight2.constant = 20;
            
            break;

            
        case .UI_CHASSES_MUR_NORMAL:
            
            fnSetColor(UIColorFromRGB(CHASSES_TINY_BAR_COLOR))
            self.button2.backgroundColor = UIColorFromRGB(BUTTON_DESINSCRIRE_COLOR)
            self.label12.textColor = UIColorFromRGB(BUTTON_DESINSCRIRE_COLOR)
            
            self.Img7.hidden = true
            self.view3.hidden = true
//            self.button3.hidden = true
            self.view4.hidden = true
            
            self.constraintHeight.constant = 0;
            self.constraintHeight2.constant = 0;
            
            break;

        case .UI_CHASSES_TOUTE:
            
            fnSetColor(UIColorFromRGB(CHASSES_TINY_BAR_COLOR))
            self.Img6.image = UIImage.init(named: "ic_close")

            self.Img7.hidden = true
            self.view3.hidden = true
//            self.button3.hidden = true
            self.view4.hidden = true
            
            self.constraintHeight.constant = 0;
            self.constraintHeight2.constant = 0;
            
            break;

            
        default:
            break;
        }
    }


}
