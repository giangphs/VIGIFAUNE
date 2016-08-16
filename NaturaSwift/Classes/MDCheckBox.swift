//
//  MDCheckBox.swift
//  NaturaSwift
//
//  Created by Manh on 7/15/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class MDCheckBox: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame);
        setImage(UIImage(named: "checkbox_active"), forState: .Selected);
        setImage(UIImage(named: "checkbox"), forState: .Selected);
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func awakeFromNib() {
        setImage(UIImage(named: "checkbox_active"), forState: .Selected);
        setImage(UIImage(named: "checkbox"), forState: .Selected);

    }
    func setTypeCheckBox(type: UI_TYPE) {
        switch type{
        case .UI_GROUP_MUR_ADMIN:
            setImage(UIImage(named: "checkbox_active"), forState: .Selected);
            break
        case .UI_GROUP_MUR_NORMAL:
            setImage(UIImage(named: "checkbox_active"), forState: .Selected);
            break
        case .UI_GROUP_TOUTE:
            setImage(UIImage(named: "ic_check_active_blue"), forState: .Selected);
            break
        case .UI_CHASSES_MUR_ADMIN:
            setImage(UIImage(named: "ic_chasse_checkbox_active"), forState: .Selected);
            setImage(UIImage(named: "ic_chasse_checkbox_inactive"), forState: .Selected);
            break
        case .UI_CHASSES_MUR_NORMAL:
            setImage(UIImage(named: "ic_chasse_checkbox_active"), forState: .Selected);
            setImage(UIImage(named: "ic_chasse_checkbox_inactive"), forState: .Selected);
            break
        case .UI_CHASSES_TOUTE:
            setImage(UIImage(named: "checkbox_active"), forState: .Selected);
            break
        case .UI_CARTE:
            setImage(UIImage(named: "ic_check_active_pink"), forState: .Selected);
            break
        case .UI_AMIS_DELETE:
            setImage(UIImage(named: "ic_remove_contact"), forState: .Selected);
            break
        case .UI_DISCUSSION:
            setImage(UIImage(named: "discussion_bg_checkbox_selected"), forState: .Selected);
            break
        }
    }
}