//
//  SlideCustomCell.swift
//  NaturaSwift
//
//  Created by Manh on 7/6/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
class SlideCustomCell: UITableViewCell {
    @IBOutlet var slideTitleLabel: UILabel!;
    @IBOutlet var tickButton: UIButton!;
    @IBOutlet var slideImage: UIImageView!;
    override func awakeFromNib() {
        super.awakeFromNib();
        
    }
    func setListLabel(text: String) {
        slideTitleLabel.text = text;
    }
    func setListImages(text: String) {
        slideImage.image = UIImage(named: text);
    }
}