//
//  VideoSheetVC.swift
//  NaturaSwift
//
//  Created by Giang on 7/21/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import MobileCoreServices

class VideoSheetVC: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    /* We will use this variable to determine if the viewDidAppear:
     method of our view controller is already called or not. If not, we will
     display the camera view */


    var beenHereBefore = false
    var controller: UIImagePickerController?
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String: AnyObject]){
        
        print("Picker returned successfully")
        
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
        
        if let type:AnyObject = mediaType{
            
            if type is String{
                let stringType = type as! String
                
                if stringType == kUTTypeMovie as String{
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
                    if let url = urlOfVideo{
                        print("Video URL = \(url)")
                    }
                }
                    
                else if stringType == kUTTypeImage as String{
                    /* Let's get the metadata. This is only for images. Not videos */
                    let metadata = info[UIImagePickerControllerMediaMetadata]
                        as? NSDictionary
                    if let theMetaData = metadata{
                        let image = info[UIImagePickerControllerOriginalImage]
                            as? UIImage
                        if let theImage = image{
                            print("Image Metadata = \(theMetaData)")
                            print("Image = \(theImage)")
                        }
                    }
                }
                
            }
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("Picker was cancelled")
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    func cameraSupportsMedia(mediaType: String,
                             sourceType: UIImagePickerControllerSourceType) -> Bool{
        
        let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
                [String]?
        
        if let types = availableMediaTypes{
            for type in types{
                if type == mediaType{
                    return true
                }
            }
        }
        
        return false
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as String, sourceType: .Camera)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if beenHereBefore{
            /* Only display the picker once as the viewDidAppear: method gets
             called whenever the view of our view controller gets displayed */
            return;
        } else {
            beenHereBefore = true
        }
        
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            
            controller = UIImagePickerController()
            
            if let theController = controller{
                theController.sourceType = .Camera
                
                theController.mediaTypes = [kUTTypeImage as String]
                
                theController.allowsEditing = true
                theController.delegate = self
                
                presentViewController(theController, animated: true, completion: nil)
            }
            
        } else {
            print("Camera is not available")
        }
        
    }
    
}

