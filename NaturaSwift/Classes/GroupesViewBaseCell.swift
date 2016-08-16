//
//  GroupesViewBaseCell.swift
//  NaturaSwift
//
//  Created by Manh on 7/15/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class GroupesViewBaseCell: CellBase {
    //MARK: - OUTLET
    @IBOutlet var   lblAdminGroup : UILabel!;
    @IBOutlet var   btnEnterGroup : UIButton!;
    @IBOutlet var   btnUnsubscribe : UIButton!;
    @IBOutlet var   btnAdminstrator : UIButton!;
    @IBOutlet var   btnEmailNotify : UIButton!;
    @IBOutlet var   checkbox : MDCheckBox!;
    @IBOutlet var   lblName : UILabel!;
    @IBOutlet var   txtDescription : UILabel!;
    @IBOutlet var   lblAccess : UILabel!;
    @IBOutlet var   lblNbSubcribers : UILabel!;
    @IBOutlet var   lblNbPending : UILabel!;
    @IBOutlet var   imgViewAvatar : UIImageView!;
    @IBOutlet var   imgMember : UIImageView!;
    @IBOutlet var   btnValidation : UIButton!;
    @IBOutlet var   btnLabel : UIButton!;
    //MARK: - INT
    override func awakeFromNib() {
        super.awakeFromNib();
        self.mainView.layer.masksToBounds = true;
        self.mainView.layer.cornerRadius  = 5.0;
        self.mainView.layer.borderWidth   = 0.5;
        self.mainView.layer.borderColor   = UIColor.lightGrayColor().CGColor;

    }
    override func layoutSubviews() {
        super.layoutSubviews();
        contentView.layoutIfNeeded();
    }
    func fnSettingCell(type: UI_TYPE) {
        switch type{
        case .UI_GROUP_MUR_ADMIN:
            fnSetColor(UIColorFromRGB(GROUP_MUR_ADMIN_COLOR));
            break
        case .UI_GROUP_MUR_NORMAL:
            fnSetColor(UIColorFromRGB(GROUP_MUR_NORMAL_COLOR));
            self.btnUnsubscribe.backgroundColor = UIColorFromRGB(GROUP_MUR_CANCEL_COLOR);
            break
        case .UI_GROUP_TOUTE:
            break
        case .UI_CHASSES_MUR_ADMIN:
            fnSetColor(UIColorFromRGB(CHASSES_TINY_BAR_COLOR));
            break
        case .UI_CHASSES_MUR_NORMAL:
            fnSetColor(UIColorFromRGB(CHASSES_TINY_BAR_COLOR));
            break
        case .UI_CHASSES_TOUTE:
            break
        case .UI_CARTE:
            break
        case .UI_AMIS_DELETE:
            break
        case .UI_DISCUSSION:
            break
        }
    }
    func fnSetColor(color: UIColor) {
        self.lblName.textColor = color;
        self.lblNbSubcribers.textColor = color;
        self.btnEnterGroup.backgroundColor = color;
        if(self.btnAdminstrator != nil)
        {
            self.btnAdminstrator.backgroundColor = color;
        }
    }
}