//
//  EVPageViewTopTabBar.swift
//  Pods
//
//  Created by Eric Vennaro on 2/29/16.
//
//
import UIKit
import SwiftyJSON
typealias callBackBottomBar = (index: Int) ->()

public class MDBottomTabBar: UIView {
    private let arrButton = NSMutableArray();
    private let arrIcon = NSMutableArray();


    var myMainNavCallBack: callBackBottomBar!;

    public var arrButtonTabBar:NSArray?
    {
        didSet {
            var i:Int = 0;
            for nameItem in arrButtonTabBar! {

                //set button
                let btnItem: UIButton = UIButton();

                arrButton.addObject(btnItem);
                
                btnItem.translatesAutoresizingMaskIntoConstraints = false
                btnItem.addTarget(self, action:#selector(buttonWasTouched), forControlEvents: .TouchUpInside)
                btnItem.tag = i;
                self.addSubview(btnItem)
                //add icon
                let icon: UIButton = UIButton();
                icon.tag = 2*(i + START_SUB_NAV_TAG);
                icon.addTarget(self, action: #selector(buttonWasTouched), forControlEvents: .TouchUpInside);
                var img_width: CGFloat = 20;//default
                var img_height: CGFloat = 20;//default

                if let icon_normal = nameItem["icon"] as? String {
                    let img_normal = UIImage(named: icon_normal);
                    img_width = (img_normal?.size.width)!;
                    img_height = (img_normal?.size.height)!;
                    icon.setImage(img_normal, forState: .Normal);
                    icon.setImage(UIImage(named: (nameItem["icon"] as? String)!), forState: .Selected);
                }
                
                let _h: CGFloat = 30;
                let _w = img_width*_h/img_height;
                btnItem.addSubview(icon);
                icon.translatesAutoresizingMaskIntoConstraints = false;
                //contraint icon
                let centerX = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: btnItem, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
                let centerY = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: btnItem, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
                let height = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: _h)

                let width = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: _w)
                //add line
                if i > 0 {
                    let icon_line: UIImageView = UIImageView(image: UIImage(named: "line_h"));
                    icon_line.translatesAutoresizingMaskIntoConstraints = false;
                    btnItem.addSubview(icon_line);
                    let strContraintV: String = "V:|-5-[icon_line]-5-|";
                    let strContraintH: String = "H:|-0-[icon_line(==1)]";

                    btnItem.addConstraints(
                        NSLayoutConstraint.constraintsWithVisualFormat(strContraintV, options: [], metrics: nil, views:["icon_line" : icon_line]));
                    btnItem.addConstraints(
                        NSLayoutConstraint.constraintsWithVisualFormat(strContraintH, options: [], metrics: nil, views:["icon_line" : icon_line]));
                }
                    btnItem.addConstraints([centerX,centerY,width,height]);
                
                i = i + 1;

            }
        }
    }
    //MARK: - Initialization
    public init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    public func setupUI() {
        setConstraints()
    }
    public func buttonWasTouched(sender: UIButton)
    {
        var index: Int = sender.tag;
        if index >= START_SUB_NAV_TAG {
            index = index/2 - START_SUB_NAV_TAG;
        }
        if (myMainNavCallBack != nil) {
            myMainNavCallBack(index: index);
        }

    }

    public func updateStatusButton(index: Int,dicChange:[String: AnyObject])
    {
        let json = JSON(dicChange);
        let icon: UIButton = self.viewWithTag(2*(index + START_SUB_NAV_TAG)) as! UIButton
            icon.setImage(UIImage(named: json["icon"].string!), forState: .Normal);
            icon.setImage(UIImage(named: json["icon"].string!), forState: .Selected);

    }
    //MARK: - Set Constraints
    private func setConstraints() {
        var views = [String: AnyObject]();
        var index: Int = 0;
        var strContraintH: String = "";
        for buttonItem in arrButton {
            var strContraintV: String = "";
            let btn: UIButton = buttonItem as! UIButton;
            btn.translatesAutoresizingMaskIntoConstraints = false;

            if index == 0 {
                strContraintH = strContraintH + "H:|-5-";
            }
            
            if index > 0 {
                strContraintH = strContraintH +  "[btn\(index)(==btn\(index - 1))]-0-";
            }
            else
            {
                //button back
                strContraintH = strContraintH +  "[btn\(index)]-0-";
            }
            if index ==  (arrButton.count - 1) {
                strContraintH = strContraintH +  "|"
            }
            views["btn\(index)"] = btn;
            
            strContraintV = "V:|-0-[btn]-0-|";
            self.addConstraints(
                NSLayoutConstraint.constraintsWithVisualFormat(strContraintV, options: [], metrics: nil, views:["btn" : btn]))
            index  = index + 1;

        }
        self.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(strContraintH, options: [], metrics: nil, views:views))
    }
}
