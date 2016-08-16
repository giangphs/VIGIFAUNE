//
//  MDMarkersCustom.swift
//  NaturaSwift
//
//  Created by Manh on 5/27/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit
import SDWebImage
typealias callBackMarkersCustom = (image: UIImage, precent_arrow: Float) -> Void
class MDMarkesCustom: UIView {
    var dicMarkers: NSDictionary!;
    var isResize: Bool!;
    var imageViewMarker: UIImageView!;
    var lbMarker: UILabel!;
    
    var MDMarkersSmallSize: CGSize!;
    var MDMarkersSize: CGSize!;
    
    let MDMarkersSizeWidth: CGFloat = 29;
    let MDMarkersSizeHeight: CGFloat = 32;
    let MDMarkersSmallSizeWidth: CGFloat = 8;
    let MDMarkersSmallSizeHeight: CGFloat = 10;
    var sizeLegend: Int!;
    var percent_arrow: Float!;
    var CallBackMarkers: callBackMarkersCustom = {_,_ in };
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dicmarkers: NSDictionary, resize: Bool)
    {
        super.init(frame:CGRect.zero);
        dicMarkers = dicmarkers;
        isResize = resize;
        MDMarkersSize = CGSizeMake(MDMarkersSizeWidth, MDMarkersSizeHeight)
        MDMarkersSmallSize = CGSizeMake(MDMarkersSmallSizeWidth, MDMarkersSmallSizeHeight)
    }
    func doSetCalloutView()  {
        loadImageData();
    }
    
    func loadImageData() {
        let senderID: Int = (NSUserDefaults.standardUserDefaults().valueForKey("sender_id") as? Int)!;
        let view:UIView = UIView.init();
        imageViewMarker = UIImageView.init();
        var imageViewFrame: CGRect = imageViewMarker.frame;
        if (isResize == true) {
            imageViewFrame.size = MDMarkersSmallSize;
            sizeLegend = 6;
        }
        else
        {
            imageViewFrame.size = MDMarkersSize;
            sizeLegend = 11;
            
        }
        imageViewMarker.frame = imageViewFrame;
        if ((dicMarkers["legend"]?.isKindOfClass(NSNull) != nil) && (dicMarkers["legend"]?.isEqual(""))! == true) {
            buldLegend();
        }
        //add subview
        view.addSubview(lbMarker);
        view.addSubview(imageViewMarker);
        //set frame view
        let legendFrame: CGRect = lbMarker.frame;
        view.frame = CGRectMake(0, 0, imageViewFrame.size.width + legendFrame.size.width, imageViewFrame.size.height);
        //
        percent_arrow = (Float(imageViewFrame.origin.x) + Float(imageViewFrame.size.width)/2)/Float(view.frame.size.width);
        var photoDefault: String = "";
        var strImage: String = "";
        if (dicMarkers["owner"] is NSDictionary) {
            // normal dic
            if ((dicMarkers["owner"]!["id"] as? Int)! == senderID) {
                //My publication
                photoDefault = "green_circle_map_icon_photo"
            }
            else
            {
                photoDefault = "green_carre_map_icon_photo";
            }
            strImage = "\(IMAGE_ROOT_API)\(dicMarkers["mobile_markers"]!["picto"])";
        }
        else
        {
            if ((dicMarkers["c_owner_id"]!["id"] as? Int)! == senderID) {
                //My publication
                photoDefault = "green_circle_map_icon_photo";

            }
            else
            {
                //Other one
                photoDefault = "green_carre_map_icon_photo";

            }
            strImage = "\(IMAGE_ROOT_API)\(dicMarkers["c_marker_picto"])";

        }
        let url: NSURL = NSURL.init(string: strImage)!;
        let manager: SDWebImageManager = SDWebImageManager.sharedManager();
        manager.downloadImageWithURL(url, options: SDWebImageOptions.CacheMemoryOnly, progress: { (receivedSize, expectedSize) in
            
            }) { (image, error, cacheType, finished, imageURL) in
                var imageTmp: UIImage! = nil;
                if(image==nil)
                {
                    imageTmp = UIImage.init(named: photoDefault)!;
                }
                else
                {
                    imageTmp = image;
                }
                self.imageViewMarker.image = imageTmp;
                self.returnImage(self.imageFromWithImage(view))
                
        }
    }
    func buldLegend() {
        lbMarker = UILabel.init();
        lbMarker.backgroundColor = UIColor.whiteColor();
        lbMarker.textAlignment = NSTextAlignment.Center;
        lbMarker.font = UIFont.init(name: "HelveticaNeue-Light", size: CGFloat(sizeLegend));
        
        if (dicMarkers["owner"]is NSDictionary) {
            lbMarker.text = String(dicMarkers["legend"]!);
        }
        else
        {
            lbMarker.text = String(dicMarkers["c_legend"]!);
        }
        if (lbMarker.text != nil) {
            let fWidth: CGFloat = widthOfString(lbMarker.text!, font: lbMarker.font) + 6;
            if (isResize ==  true) {
                lbMarker.frame = CGRectMake( MDMarkersSmallSizeWidth - 1, 0, fWidth - 4,MDMarkersSmallSizeHeight - 2);
            }
            else
            {
                lbMarker.frame  = CGRectMake( MDMarkersSizeWidth - 3, 5, fWidth, MDMarkersSizeHeight - 17);
            }
        }
    }
    func returnImage(image: UIImage) {
        
        CallBackMarkers(image: image, precent_arrow: percent_arrow);
    }
    func imageFromWithImage(view: UIView) -> UIImage {
        //draw
        if UIScreen.instancesRespondToSelector(#selector(NSDecimalNumberBehaviors.scale)) {
            UIGraphicsBeginImageContextWithOptions(view.frame.size, false, UIScreen.mainScreen().scale);
        }else{
            UIGraphicsBeginImageContext(view.frame.size);
        }
        
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!);
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    func widthOfString(string: String, font: UIFont) -> CGFloat {
        let attributes: NSDictionary = [NSFontAttributeName: font];
        return NSAttributedString.init(string: string, attributes: attributes as? [String : AnyObject]).size().width;
    }
}