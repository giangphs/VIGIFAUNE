//
//  EVPageViewTopTabBar.swift
//  Pods
//
//  Created by Eric Vennaro on 2/29/16.
//
//
import UIKit
import SwiftyJSON
typealias callBackTopBar = (index: NSArray) ->()

public class MDTopTabBar: UIView {
    private let arrButton = NSMutableArray();
    private let arrIcon = NSMutableArray();
    
    private var buttonFontColors: (selectedColor: UIColor, unselectedColor: UIColor)!
    private let dicButton = NSMutableDictionary();
    
    var myMainNavCallBack: callBackTopBar!;
    
    public var arrButtonTabBar:NSArray?
        {
        didSet {
            var i:Int = 0;
            for nameItem in arrButtonTabBar! {
                //set select
                if let isscreen: NSArray = nameItem["isscreen"] as? NSArray  where isscreen.count > 0  {
                    for strScreen in isscreen {
                        dicButton.setValue(i, forKey: strScreen as! String);
                    }
                }
                //set button
                let btnItem: UIButton = UIButton();
                var padding: Int = 10;
                if let name: String = nameItem["name"] as? String  where name.characters.count > 0  {
                    padding = 5;
                    btnItem.setTitle(name, forState: .Normal)
                    btnItem.titleEdgeInsets = UIEdgeInsetsMake(25, 0, 0, 0);
                }
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
                
                if let icon_normal = nameItem["icon_normal"] as? String {
                    let img_normal = UIImage(named: icon_normal);
                    img_width = (img_normal?.size.width)!;
                    img_height = (img_normal?.size.height)!;
                    icon.setImage(img_normal, forState: .Normal);
                    
                }
                if let icon_selected = nameItem["icon_selected"] as? String {
                    icon.setImage(UIImage(named: icon_selected), forState: .Selected);
                }
                else
                {
                    icon.setImage(UIImage(named: (nameItem["icon_normal"] as? String)!), forState: .Selected);
                }
                let _h: CGFloat = 20;
                let _w = img_width*_h/img_height;
                btnItem.addSubview(icon);
                //contraint icon
                icon.translatesAutoresizingMaskIntoConstraints = false;
                let strContraintV: String = "V:|-\(padding)-[icon(==\(_h))]-0-|";
                btnItem.addConstraints(
                    NSLayoutConstraint.constraintsWithVisualFormat(strContraintV, options: [], metrics: nil, views:["icon" : icon]))
                let centerX = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: btnItem, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
                let width = NSLayoutConstraint(item: icon, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: _w)
                btnItem.addConstraints([ centerX,width]);
                
                i = i + 1;
                
            }
        }
    }
    public var fontColors: (selectedColor: UIColor, unselectedColor: UIColor)? {
        didSet {
            buttonFontColors = fontColors
            for buttonItem in arrButton {
                let btn: UIButton = buttonItem as! UIButton;
                btn.setTitleColor(fontColors!.unselectedColor, forState: .Normal)
                btn.setTitleColor(fontColors!.selectedColor, forState: .Selected)
                
            }
        }
    }
    
    
    public var labelFont: UIFont? {
        didSet {
            for buttonItem in arrButton {
                let btn: UIButton = buttonItem as! UIButton;
                btn.titleLabel?.font = self.labelFont
                
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
        buttonSelectWithIndex(index);
        if index == 0 {
            myMainNavCallBack(index: ["back"]);
        }
        else
        {
            if (myMainNavCallBack != nil) {
                if let arrName = arrButtonTabBar![index] as? NSDictionary, let isscreen = arrName["isscreen"] as? NSArray{
                    myMainNavCallBack(index: isscreen);
                }
            }
        }
        
    }
    public func buttonSelectWithNameScreen(nameScreen: String)
    {
        if let index = dicButton[nameScreen] as? Int {
            buttonSelectWithIndex(index);
        }
//        else
//        {
//            myMainNavCallBack(index: ["back"]);
//        }
    }
    public func buttonSelectWithIndex(index: Int)
    {
        var i:Int = 0;
        for buttonItem in arrButton {
            let btnItem: UIButton = buttonItem as! UIButton;
            let icon: UIButton = btnItem.viewWithTag(2*(i + START_SUB_NAV_TAG)) as! UIButton;
            if i == index {
                btnItem.selected = true;
                icon.selected = true;
            }
            else
            {
                btnItem.selected = false;
                icon.selected = false;
                
            }
            i = i + 1;
        }
    }
    
    public func updateStatusButton(index: Int,dicChange:[String: AnyObject])
    {
        let json = JSON(dicChange);
        let icon: UIButton = self.viewWithTag(2*(index + START_SUB_NAV_TAG)) as! UIButton
        icon.setImage(UIImage(named: json["icon_normal"].string!), forState: .Normal);
        icon.setImage(UIImage(named: json["icon_selected"].string!), forState: .Selected);
        
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
            if index > 1 {
                strContraintH = strContraintH +  "[btn\(index)(==btn\(index - 1))]-0-";
            }
            else if(index == 1)
            {
                strContraintH = strContraintH +  "[btn\(index)]-0-";
            }
            else
            {
                //button back
                strContraintH = strContraintH +  "[btn\(index)(==30)]-0-";
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
