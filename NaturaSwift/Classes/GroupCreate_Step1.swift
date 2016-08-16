//
//  GroupCreate_Step1.swift
//  NaturaSwift
//
//  Created by Manh on 7/21/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation

class GroupCreate_Step1: GroupCreateBaseVC, UITextViewDelegate , UITextFieldDelegate {
    //MARK: - OUTLET
    @IBOutlet var       nameTextField:UITextField!;
    @IBOutlet var       descTextView:UITextView!;
    @IBOutlet var       descTitleLabel:UILabel!;
    @IBOutlet var       lbTitle:UILabel!;
    @IBOutlet var       btnHelp:UIButton!;
    @IBOutlet var  scrollviewKeyboard:TPKeyboardAvoidingScrollView!;
    @IBOutlet var  viewPhotoSelected:ImageWithCloseButton!;

    //MARK: - VARIABLE
    //MARK: - INT
    override func viewDidLoad() {
        super.viewDidLoad();
        lbTitle.text = str(strInformationSubLeGroupe);
        btnHelp.setTitle(str(strENSAVOIRPLUS), forState: .Normal);
        nameTextField.autocapitalizationType = .Words;
        nameTextField.placeholder = str(strNomDuGroupe);
        descTitleLabel.text = str(strDescriptionDeVotreGroupe);
        descTitleLabel.textColor = UIColor.lightGrayColor();
        viewPhotoSelected.hidden = true;
        viewPhotoSelected.fnOncallback({ (index) in
            //Close
            self.viewPhotoSelected.hidden = true;
            self.viewPhotoSelected.imageContent.image  = nil;
        })
        //modifi
        if GroupCreateOBJ.sharedInstance.isModifi {
            self.btnSuivant.setTitle(str(strValider), forState: .Normal)
            let obj:GroupCreateOBJ = GroupCreateOBJ.sharedInstance;
            nameTextField.text = obj.strName;
            descTextView.text = obj.strComment;
            if obj.imgData != nil {
                self.viewPhotoSelected.hidden = false;
                self.viewPhotoSelected.imageContent.image = UIImage.sd_imageWithData(obj.imgData);
            }
            else
            {
                self.viewPhotoSelected.hidden = true;
                self.viewPhotoSelected.imageContent.image = nil;
            }
            if descTextView.text == "" || descTextView == nil {
                descTitleLabel.text = str(strDDescription);
            }
            else{
                descTitleLabel.text = "";

            }
        }

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
    }
    //MARK: - FUNC
    @IBAction func profileImageOptions(sender: UIButton) {
        nameTextField.resignFirstResponder();
        descTextView.resignFirstResponder();
        let vc: PhotoSheetVC = PhotoSheetVC(nibName: "PhotoSheetVC", bundle: nil);
        vc.expectTarget = self.expectTarget;
        vc.myCallback = {
            (data: NSDictionary) in
        };
        self.presentViewController(vc, animated: false) { 
            
        };
        
    }
    @IBAction func helpAction(sender: UIButton) {
        AlertVC.showAlert(str(strAnnuler_Groups), message: str(strDescHelpAgenda), tapBlock: {(index: BUTTON_ALERT) in
            switch index {
            case .BUTTON_CANCEL:
                NSLog("close");
                break;
            case .BUTTON_OK:
                NSLog("ok");
                break;
            default:
                break;
            }
        });
    }
    @IBAction func inviteAction(sender: UIButton) {
        if descTextView.text == "" && nameTextField.text == "" {
            GroupCreateOBJ.sharedInstance.strName = nameTextField.text;
            GroupCreateOBJ.sharedInstance.strComment = descTextView.text;
            if GroupCreateOBJ.sharedInstance.isModifi {
                GroupCreateOBJ.sharedInstance.modifiGroupWithVC(self);
            }
            else
            {
                
            }
        }
    }
    //MARK: - TEXTVIEW DELEGATE
    func textViewDidChange(textView: UITextView) {
        if (descTextView.text == "" || descTextView == nil) {
            descTitleLabel.text = str(strDDescription);
        }
        else
        {
            descTitleLabel.text = "";
        }
    }
    func textViewDidBeginEditing(textView: UITextView) {
        self.scrollviewKeyboard.setContentOffset(CGPointMake(0, 100), animated: true);
    }
    func textViewDidEndEditing(textView: UITextView) {
        self.scrollviewKeyboard.setContentOffset(CGPointMake(0, 0), animated: true);
    }
    //MARK: - TEXTFIELD DELEGATE
    func textFieldDidBeginEditing(textView: UITextField) {
        self.scrollviewKeyboard.setContentOffset(CGPointMake(0, 100), animated: true);
        
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.scrollviewKeyboard.setContentOffset(CGPointMake(0, 0), animated: true);
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder();
        descTextView.resignFirstResponder();
        return true;
    }
}