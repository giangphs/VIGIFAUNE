//
//  MembersCell.swift
//  NaturaSwift
//
//  Created by Manh on 7/19/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
typealias callBackGroup = (index: Int) ->()
class MembersCell: CellBase {
    @IBOutlet var       imageIcon:UIImageView!;
    @IBOutlet var       label1:UILabel!;
    @IBOutlet var       imageLine:UIImageView!;
    @IBOutlet var       constraint_image_width:NSLayoutConstraint!;
    @IBOutlet var       constraint_image_height:NSLayoutConstraint!;
    @IBOutlet var       btnAddFriend:UIButton!;
    @IBOutlet var       imgAddFriend:UIImageView!;
    override func awakeFromNib() {
        super.awakeFromNib();
        self.label1.textColor = UIColor.blackColor();
        self.label1.font = FONT_HELVETICANEUE(15);
    }
}