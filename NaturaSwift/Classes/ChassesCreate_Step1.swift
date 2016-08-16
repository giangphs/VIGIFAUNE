//
//  ChassesCreate_Step1.swift
//  NaturaSwift
//
//  Created by Giang on 7/22/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation

import SwiftyJSON

class ChassesCreate_Step1: ChassesCreateBaseVC {
    
   @IBOutlet var textfieldName: UITextField!
   @IBOutlet var textviewComment: SAMTextView!
   @IBOutlet var labelPlaceHolder: UILabel!
   @IBOutlet var lblTitleScreen: UILabel!

   @IBOutlet var textfieldFin: DPTextField!
   @IBOutlet var textfieldDebut: DPTextField!
   @IBOutlet var viewPhotoSelected: ImageWithCloseButton!
   @IBOutlet var scrollviewKeyboard: TPKeyboardAvoidingScrollView!

//    UIToolbar *keyboardToolBar;

   @IBOutlet var imgPhoto: UIImageView!
   @IBOutlet var img1: UIImageView!
   @IBOutlet var img2: UIImageView!
   @IBOutlet var img3: UIImageView!
   @IBOutlet var img4: UIImageView!
   @IBOutlet var img5: UIImageView!
    
    @IBOutlet var btnINSERR: UIButton!
    @IBOutlet var btnENSAVOIRPLUS: UIButton!

    
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();

        lblTitleScreen.text = str(strINFORMATIONS);
        btnENSAVOIRPLUS.setTitle(str(strENSAVOIRPLUS), forState: .Normal)
        
        textfieldName.placeholder = str(strNom);
        textfieldFin.placeholder = str(strDateDeFin);
        textfieldDebut.placeholder = str(strDateDeDebut);
        
        btnSuivant.setTitle(str(strSUIVANT), forState: .Normal)
        
        textviewComment.placeholder = str(strDescriptionPlaceholder);
        
        fnColorTheme()

        InitializeKeyboardToolBar()
        textviewComment.inputAccessoryView = keyboardToolbar
        
        //Photo
//        self.viewPhotoSelected.hidden=YES;
//        [self.viewPhotoSelected setMyCallback: ^(){
//            //Close
//            self.viewPhotoSelected.hidden=YES;
//            self.viewPhotoSelected.imageContent.image = nil;
//            }];
//        __weak ChassesCreate_Step1 *wkVC = self;
//        
//        
//        [self.textfieldDebut setCallBack:^(){
//            
//            //Auto set for textField Fin if empty
//            if ([wkVC.textfieldFin.text isEqualToString:@""]) {
//            
//            wkVC.textfieldFin.datePicker.date = wkVC.textfieldDebut.datePicker.date;
//            
//            
//            NSDateFormatter *dateFormatter = [[ASSharedTimeFormatter sharedFormatter] dateFormatterTer];
//            
//            [ASSharedTimeFormatter checkFormatString: @"dd/MM/yyyy HH:mm" forFormatter: dateFormatter];
//            
//            wkVC.textfieldFin.text = [NSString stringWithFormat:@"%@",
//            [dateFormatter stringFromDate:wkVC.textfieldFin.datePicker.date]];
//            
//            }
//            }];
        
        
        //modifi
//        if ([ChassesCreateOBJ sharedInstance].isModifi) {
//            [self.btnSuivant setTitle:str(strValider) forState:UIControlStateNormal ];
//            ChassesCreateOBJ *obj =[ChassesCreateOBJ sharedInstance];
//            textfieldName.text =obj.strName;
//            textviewComment.text =obj.strComment;
//            
//            self.textfieldFin.text =obj.strFin;
//            self.textfieldDebut.text =obj.strDebut;
//            
//            self.textfieldFin.delegate = self;
//            self.textfieldFin.delegate = self;
//            
//            self.viewPhotoSelected.hidden=NO;
//            self.viewPhotoSelected.imageContent.image = [UIImage imageWithData:obj.imgData];
//        }

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
    
    func fnColorTheme() -> Void {
        imgPhoto.backgroundColor = UIColorFromRGB(CHASSES_TINY_BAR_COLOR)
        img1.backgroundColor = UIColorFromRGB(CHASSES_TINY_BAR_COLOR)
        
        btnSuivant.backgroundColor = UIColorFromRGB(CHASSES_TINY_BAR_COLOR)
        btnINSERR.backgroundColor = UIColorFromRGB(CHASSES_TINY_BAR_COLOR)
        btnENSAVOIRPLUS.backgroundColor = UIColorFromRGB(CHASSES_TINY_BAR_COLOR)
        
    }
    
    
    

}