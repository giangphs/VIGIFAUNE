//
//  MDMarkersLegend.swift
//  NaturaSwift
//
//  Created by Manh on 5/30/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit
import QuartzCore
import CoreLocation
typealias callBackMarkers = (image: UIImage) -> Void
class MDMarkersLegend: UIView {
    let kJPSThumbnailAnnotationViewReuseID: String = "JPSThumbnailAnnotationView"
    let kJPSThumbnailAnnotationViewVerticalOffset: CGFloat = 10.0;
    let kJPSThumbnailAnnotationViewAnimationDuration: CGFloat = 0.25;
    
    var iWith: CGFloat!;
    var coordinate: CLLocationCoordinate2D!;
    var imageView: UIImageView!;
    var titleLabel: UILabel!;
    var subtitleLabel: UILabel!;
    var bgLayer: CAShapeLayer!;
    var disclosureButton: UIButton!;
    var isResize: Bool! ;
    var dicMarker: NSDictionary!;
    var CallBackMarkers: callBackMarkers = {_ in};
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(dicmarkers: NSDictionary, resize: Bool)
    {
        super.init(frame:CGRect.zero);
        isResize = resize;
        dicMarker = dicmarkers;
        let tmp: UILabel = UILabel.init();
        tmp.font = UIFont.boldSystemFontOfSize(13);
        tmp.text = dicMarker["c_title"]?.uppercaseString;
        let attributes: NSDictionary = [NSFontAttributeName: tmp.font];
        let textSize: CGSize = tmp.text!.sizeWithAttributes(attributes as? [String : AnyObject]);
        let strikeWidth: CGFloat = textSize.width + 5 + 20;
        iWith = strikeWidth;
        self.frame = CGRectMake(0, 0, strikeWidth , kJPSThumbnailAnnotationViewVerticalOffset + 15);
        self.backgroundColor = UIColor.clearColor();
        setupView();
        
    }
    func doSetCalloutView() {
        setupView();
    }
    func setupView() {
        animatebubbleWithDirection();
        let buttonType : UIButtonType = UIButtonType.Custom;
        disclosureButton = UIButton.init(type: buttonType);
        disclosureButton.backgroundColor = UIColor.clearColor();
        disclosureButton.frame = CGRectMake(self.frame.origin.x, 2, iWith, 20);
        disclosureButton.titleLabel?.font = UIFont.systemFontOfSize(13);
        disclosureButton.setTitle(dicMarker["c_title"]?.uppercaseString, forState: UIControlState.Normal);
        let titleInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, -15.0, 0.0, 0.0);
        disclosureButton.titleEdgeInsets = titleInsets;
        let image: UIImageView =  UIImageView.init(frame: CGRectMake(iWith - 15, 5, 10, 10));
        image.image =  UIImage.init(named: "icon_arrow_carter");
        disclosureButton.addSubview(image);
        self.addSubview(disclosureButton);
        
    }
    func setLayerProrerties()
    {
        bgLayer = CAShapeLayer();
        let path: CGPathRef = newBubbleWithRect(self.bounds);
        bgLayer.path = path;
        let strColor: String = (dicMarker["c_color"] as? String)!;
        bgLayer.fillColor = colorWithHexString(strColor, alpha: 1.0).CGColor;
        bgLayer.opacity = 0.4;
        bgLayer.masksToBounds = false;
        self.layer.insertSublayer(bgLayer, atIndex: 0);
        
        let image: UIImage = imageFromWithView(self);
        CallBackMarkers(image: image);
        
    }
    func newBubbleWithRect(rect: CGRect) -> CGPathRef {
        let radius: CGFloat = 1.5;
        let path: CGMutablePathRef = CGPathCreateMutable();
        let parentX: CGFloat = rect.origin.x +  rect.size.width/2.0;
        
        CGPathMoveToPoint(path, nil, rect.origin.x, rect.origin.y + radius);
        CGPathAddLineToPoint(path, nil, rect.origin.x, rect.origin.y + rect.size.height - radius);
        CGPathAddArc(path, nil, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, CGFloat(M_PI), CGFloat(M_PI_2), true);
        CGPathAddLineToPoint(path, nil, parentX - 5.0, rect.origin.y + rect.size.height);
        CGPathAddLineToPoint(path, nil, parentX, rect.origin.y + rect.size.height + 5.0);
        CGPathAddLineToPoint(path, nil, parentX + 5.0, rect.origin.y + rect.size.height);
        CGPathAddLineToPoint(path, nil, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);
        CGPathAddArc(path, nil, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, CGFloat(M_PI_2), 0.0, true);
        CGPathAddLineToPoint(path, nil, rect.origin.x + rect.size.width, rect.origin.y + radius);
        CGPathAddArc(path, nil, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 0.0, -CGFloat(M_PI_2), true);
        CGPathAddLineToPoint(path, nil, rect.origin.x + radius, rect.origin.y);
        CGPathAddArc(path, nil, rect.origin.x + radius, rect.origin.y + radius, radius, -CGFloat(M_PI_2), CGFloat(M_PI), true);
        CGPathCloseSubpath(path);
        return path;

        
    }
    func imageFromWithView(vView: UIView) -> UIImage {
        
        let view: UIView = vView;
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
    func animatebubbleWithDirection() {
        let animation: CABasicAnimation = CABasicAnimation.init(keyPath: "path");
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut);
        animation.repeatCount = 1;
        animation.removedOnCompletion = false;
        animation.fillMode = kCAFillModeForwards;
        animation.duration = NSTimeInterval.init(kJPSThumbnailAnnotationViewAnimationDuration) ;
        
        let fromPath: CGPathRef = newBubbleWithRect(self.bounds);
        animation.fromValue = fromPath;
        
        bgLayer .addAnimation(animation, forKey: animation.keyPath);

    }
    //MARK: convert Color
    func colorWithHexString(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: NSScanner = NSScanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        // Scan hex value
        scanner.scanHexInt(&hexInt)
        return hexInt
    }
}