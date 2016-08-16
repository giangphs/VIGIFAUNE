//
//  MGBadgeView.swift
//  NaturaSwift
//
//  Created by Manh on 7/5/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
let kMGBadgeViewTag: Int = 9876;
enum MGBadePosition: Int {
   case  MGBadgePositionCenterLeft = 0
   case  MGBadgePositionCenterRight = 1
   case  MGBadgePositionTopLeft = 2
   case  MGBadgePositionTopRight = 3
   case  MGBadgePositionBottomLeft = 4
   case  MGBadgePositionBottomRight = 5
   case  MGBadgePositionBest = 6
}
class MGBadgeView: UIView {
    var postion: MGBadePosition!
        {
            get {
                return _postion;
            }
            set {
                if _postion != newValue {
                    _postion = newValue;
                    mg_updateBadgeViewPosition();
                    self.setNeedsDisplay();
                }
            }
        };
    var badgeValue: NSInteger!
        {
        get {
            return _badgeValue
        }
        set {
            if _badgeValue != newValue {
                _badgeValue = newValue;
                if newValue != 0 || displayIfZero {
                    mg_updateBadgeViewSize();
                    if postion == MGBadePosition.MGBadgePositionBest {
                        mg_updateBadgeViewPosition();
                    }
                }
                else
                {
                    self.frame = CGRectZero;
                }
                self.setNeedsDisplay();
            }
        }
    };
    var font: UIFont!
        {
        get { return _font;}
        set {
            if _font != newValue {
                _font = newValue;
                if postion == MGBadePosition.MGBadgePositionBest {
                    mg_updateBadgeViewPosition();
                }
                self.setNeedsDisplay();
            }
        }
    };

    var badgeColor: UIColor!
        {
        get { return _badgeColor;}
        set {
            if _badgeColor != newValue {
                _badgeColor = newValue;
                self.setNeedsDisplay();
            }
        }
        };
    var textColor: UIColor!
        {
        get { return _textColor;}
        set {
            if _textColor != newValue {
                _textColor = newValue;
                self.setNeedsDisplay();
            }
        }
    };
    var outlineColor: UIColor!
        {
        get { return _outlineColor;}
        set {
            if _outlineColor != newValue {
                _outlineColor = newValue;
                self.setNeedsDisplay();
            }
        }
    };
    var outlineWidth: Float!
        {
        get { return _outlineWidth;}
        set {
            if _outlineWidth != newValue {
                _outlineWidth = newValue;
                if _postion == MGBadePosition.MGBadgePositionBest {
                    mg_updateBadgeViewPosition();
                }
                self.setNeedsDisplay();
            }
        }
    };
    var minDiameter: Float!
        {
        get { return _minDiameter;}
        set {
            if _minDiameter != newValue {
                _minDiameter = newValue;
                if _postion == MGBadePosition.MGBadgePositionBest {
                    mg_updateBadgeViewPosition();
                }
                self.setNeedsDisplay();
            }
        }
        };
    var displayIfZero: Bool!
        {
        get { return _displayIfZero;}
        set {
            if _displayIfZero != newValue {
                _displayIfZero = newValue;
                if _badgeValue == 0 {
                    if (_displayIfZero != nil) {
                        mg_updateBadgeViewSize();
                        if _postion == MGBadePosition.MGBadgePositionBest {
                            mg_updateBadgeViewPosition();
                        }
                    }
                    else
                    {
                        self.frame = CGRectZero;
                    }
                }
            }
        }
        };
    private var _postion: MGBadePosition?
    private var _badgeValue: NSInteger?
    private var _font: UIFont?
    private var _badgeColor: UIColor?
    private var _textColor: UIColor?
    private var _outlineColor: UIColor?
    private var _outlineWidth: Float?
    private var _minDiameter: Float?
    private var _displayIfZero: Bool?
    
    var horizontalOffset: Float!;
    var verticalOffset: Float!;
    var BADGE_TOTAL_OFFSET: Float!

    override init(frame: CGRect) {
        super.init(frame: frame);
        font = UIFont.boldSystemFontOfSize(12.0);
        badgeColor = UIColor.redColor();
        textColor = UIColor.whiteColor();
        outlineColor = UIColor.whiteColor();
        outlineWidth = 2.0;
        minDiameter = 10.0;
        postion = MGBadePosition.MGBadgePositionBest;
        displayIfZero = false;
        horizontalOffset = 0.0;
        verticalOffset = 0.0;
        self.backgroundColor = UIColor.clearColor();
        self.opaque = true;
        self.tag = kMGBadgeViewTag;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect);
        if badgeValue != 0 || displayIfZero {
            let stringToDraw: NSString = "\(badgeValue)";
            let context: CGContextRef = UIGraphicsGetCurrentContext()!;
            outlineColor.set();
            CGContextFillEllipseInRect(context, CGRectInset(rect, 1.0, 1.0));
            badgeColor.set();
            CGContextFillEllipseInRect(context, CGRectInset(rect, CGFloat(outlineWidth) + 1.0, CGFloat(outlineWidth)   + 1.0));
            let numberSize: CGSize = stringToDraw.sizeWithAttributes([NSFontAttributeName: font]);
            textColor.set();
            let paragrapStyle: NSMutableParagraphStyle = NSMutableParagraphStyle();
            paragrapStyle.lineBreakMode = NSLineBreakMode.ByClipping;
            paragrapStyle.alignment = NSTextAlignment.Center;
            let lblRect: CGRect = CGRectMake(rect.origin.x, (rect.size.height/2.0) - (numberSize.height/2.0), rect.size.width, numberSize.height);
            
            stringToDraw.drawInRect(lblRect, withAttributes: [
                NSFontAttributeName: font,
                NSParagraphStyleAttributeName: paragrapStyle,
                NSForegroundColorAttributeName: textColor
                ]);
            
        }
    }
    //MARK: - Properties accessor methods
    
    
    //MARK: - private methods
    func mg_updateBadgeViewSize() {
        BADGE_TOTAL_OFFSET = (3 + outlineWidth)*2;
        let numberSize: CGSize = ("\(badgeValue)" as NSString).sizeWithAttributes([NSFontAttributeName: font]);
        let badgeHeight: Float = max(BADGE_TOTAL_OFFSET + Float(numberSize.height), minDiameter);
        let badgeWidth: Float = max(badgeHeight,BADGE_TOTAL_OFFSET + Float(numberSize.width));
        self.bounds = CGRectMake(0, 0, CGFloat(badgeWidth), CGFloat(badgeHeight));
    }
    func mg_updateBadgeViewPosition() {
        
        if let superviewFrame: CGRect = self.superview?.frame
        {
            if postion == MGBadePosition.MGBadgePositionCenterRight {
                self.center = CGPointMake(superviewFrame.size.width + 2, 30);
            }
            else
            {
                self.center = CGPointMake(superviewFrame.size.width + CGFloat(horizontalOffset), CGFloat(verticalOffset));
            }
        }
    }
}
let kMGBadgeViewPropertyKey: String = "kMGBadgeViewPropertyKey";
extension UIView
{
    var badgeView:MGBadgeView {
        get {
            return objc_getAssociatedObject(self, kMGBadgeViewPropertyKey) as! MGBadgeView
        }
        set {
            objc_setAssociatedObject(self, kMGBadgeViewPropertyKey, newValue,objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func fnbadgeView() -> MGBadgeView {
        var badgeView: MGBadgeView? = objc_getAssociatedObject(self, kMGBadgeViewPropertyKey) as? MGBadgeView;
        if (badgeView == nil) {
            self.badgeView = MGBadgeView(frame: CGRectZero);
            badgeView = objc_getAssociatedObject(self, kMGBadgeViewPropertyKey) as? MGBadgeView;
            self.addSubview(badgeView!);
        }
        return badgeView!;
    }
}