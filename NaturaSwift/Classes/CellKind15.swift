//
//  CellKind15.swift
//  NaturaSwift
//
//  Created by Manh on 7/20/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
class CellKind15: CellBase {
   @IBOutlet var  imgProfile:UIImageView!;
   @IBOutlet var  nameGroup:UILabel!;
   @IBOutlet var  accessType:UILabel!;
   @IBOutlet var  numberMember:UILabel!;
   @IBOutlet var  contentGroup:UILabel!;
   @IBOutlet var  btnValid:UIButton!;
   @IBOutlet var  btnRefuse:UIButton!;
   @IBOutlet var  lbNameGroupAdmin:UILabel!;
    override func awakeFromNib() {
        super.awakeFromNib();
        self.imgProfile.layer.masksToBounds = true;
        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2;
        self.imgProfile.layer.borderWidth = 0;
    }
    override func layoutSubviews() {
        super.layoutSubviews();
        self.contentView.layoutIfNeeded();
    }
}