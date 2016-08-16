//
//  BaseVC.swift
//  NaturaSwift
//
//  Created by Manh on 6/23/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import OKAlertController
import SwiftyJSON

var bFilterON: Bool = false;

class BaseVC: UIViewController , UITableViewDelegate  {
    
    //MARK: IBOUTLET
    @IBOutlet var tableControl: UITableView!;
    @IBOutlet var vContainer: UIView!;
    //MARK: VARIABLE
    var expectTarget: ISSCREEN = ISSCREEN.ISMUR;
    var childTarget: Bool = false;
    var topTabBar: MDTopTabBar = MDTopTabBar();
    var bottomTabBar: MDBottomTabBar = MDBottomTabBar();
    var preTabBar: MDPreAnnulerTabBar = MDPreAnnulerTabBar();
    var navigation: BaseNavigation!;
    var subviewCount: MainNavigationBaseView!;
    var mParent:UIViewController!;
    var showTabBottom: Bool = true;
    var typeTabbar: TYPE_TABBAR = TYPE_TABBAR.TABBAR_TOP;
    
    var keyboardToolbar: UIToolbar!
    var doneBarItem:UIBarButtonItem!
    var spaceBarItem:UIBarButtonItem!

    
    //MARK: INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        self.loadNavigation();
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated);
        // change color when goback
        let mainView: MainNavigationBaseView = navigation.viewNavigation1.viewWithTag(TAG_MAIN_NAV_VIEW) as! MainNavigationBaseView;
        let navBar: UINavigationBar = (self.navigationController?.navigationBar)!;
        navBar.barTintColor = mainView.backgroundColor;
        
        switch typeTabbar {
        case TYPE_TABBAR.TABBAR_TOP:
            //set state sub top bar
            updateStateTopBar();
            break;
        default:
            break
        }
    }
    
    //MARK: - REMOVE TOP BAR ITEM
    func removeTopBarItem(arrRemove: NSArray) {
        setupMDTopTabBar(expectTarget, arrRemove: arrRemove);
        
    }
    
    //MARK: - SETUP TABBAR
    func setupTabBar(tabbar: TYPE_TABBAR, target: ISSCREEN)
    {
        typeTabbar =  tabbar;
        switch typeTabbar {
        case .TABBAR_TOP:
            //setup top bar
            setupMDTopTabBar(expectTarget, arrRemove: nil);
            break;
        case .TABBAR_PRE:
            //setup top bar
            setupMDPreTabBar(target);
            break;
        }
    }
    //MARK: - TOP BAR
    /*
     note:
     isscreen: a list screen names, will set focus image on these one.
     set full list + what item need removing
     
     */
    
    private func setupMDTopTabBar(target: ISSCREEN, arrRemove: NSArray?) {
        topTabBar.removeFromSuperview();
        topTabBar = MDTopTabBar();
        
        let arrButtonTabBar = NSMutableArray();
        var color: UInt = MUR_MAIN_BAR_COLOR;
        arrButtonTabBar.addObject([
            "name": "",
            "icon_normal":"ic_group_back",
            "icon_selected": "ic_group_back"]);
        switch target {
        case .ISMUR:
            //color
            color = MUR_MAIN_BAR_COLOR;
            //set image
            arrButtonTabBar.addObject([
                "isscreen":[String(MurVC),String(CommentDetailVC)],
                "name": str(strMur),
                "icon_normal":"mur_ic_action_mur.png",
                "icon_selected": "mur_ic_action_mur_active.png"]);
            if bFilterON {
                arrButtonTabBar.addObject([
                    "isscreen":[String(MurFilterVC)],
                    "name": str(strFiltres),
                    "icon_normal":"mur_ic_action_filter",
                    "icon_selected": "mur_ic_action_filter_active"]);
            }
            else
            {
                arrButtonTabBar.addObject([
                    "isscreen":[String(MurFilterVC)],
                    "name": str(strFiltres),
                    "icon_normal":"mur_ic_filter_off",
                    "icon_selected": "mur_ic_filter_off_active"]);
            }
            arrButtonTabBar.addObject([
                "name": str(strParametres),
                "icon_normal":"mur_ic_action_setting",
                "icon_selected": "mur_ic_action_setting_active"]);
            topTabBar.myMainNavCallBack = {(index: NSArray) in
                
                self.clickSubNav_Mur(index);
            };
            break;
            
        case .ISGROUP:
            if childTarget == true {
                //color
                color = GROUP_MAIN_BAR_COLOR;
                //set image
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupEnterMurVC)],
                    "name": str(strMur),
                    "icon_normal":"ic_group_mur_inactive",
                    "icon_selected": "ic_group_mur_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strCarte),
                    "icon_normal":"ic_group_map_inactive",
                    "icon_selected": "ic_group_map_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strDiscussion),
                    "icon_normal":"ic_chat_inactive",
                    "icon_selected": "ic_group_chat_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strAgenda),
                    "icon_normal":"ic_group_event_inactive",
                    "icon_selected": "ic_group_event_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strParametres),
                    "icon_normal":"ic_group_setting",
                    "icon_selected": "ic_group_setting_active"]);
                
                topTabBar.myMainNavCallBack = {(index: NSArray) in
                    self.clickSubNav_Group_Child(index);
                };
                
            }
            else
            {
                //color
                color = GROUP_MAIN_BAR_COLOR;
                //set image
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupMesVC)],
                    "name": str(strMesgroupes),
                    "icon_normal":"ic_my_group_inactive",
                    "icon_selected": "ic_my_group"]);
                
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupSearchVC)],
                    "name": str(strRecherche),
                    "icon_normal":"ic_search_group",
                    "icon_selected": "ic_search_group_active"]);
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupInvitationAttend)],
                    "name": str(strInvitations),
                    "icon_normal":"group_ic_invite_inactive",
                    "icon_selected": "group_ic_invite"]);
                
                topTabBar.myMainNavCallBack = {(index: NSArray) in
                    self.clickSubNav_Group(index);
                };
            }
            break;
            
        case .ISLOUNGE:
            if childTarget == true {
                //color
                color = GROUP_MAIN_BAR_COLOR;
                //set image
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupEnterMurVC)],
                    "name": str(strMur),
                    "icon_normal":"ic_group_mur_inactive",
                    "icon_selected": "ic_group_mur_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strCarte),
                    "icon_normal":"ic_group_map_inactive",
                    "icon_selected": "ic_group_map_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strDiscussion),
                    "icon_normal":"ic_chat_inactive",
                    "icon_selected": "ic_group_chat_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strAgenda),
                    "icon_normal":"ic_group_event_inactive",
                    "icon_selected": "ic_group_event_active"]);
                arrButtonTabBar.addObject([
                    "name": str(strParametres),
                    "icon_normal":"ic_group_setting",
                    "icon_selected": "ic_group_setting_active"]);
                
                topTabBar.myMainNavCallBack = {(index: NSArray) in
                    self.clickSubNav_Group_Child(index);
                };
                
            }
            else
            {
                //color
                color = GROUP_MAIN_BAR_COLOR;
                //set image
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupMesVC)],
                    "name": str(strMesgroupes),
                    "icon_normal":"ic_my_group_inactive",
                    "icon_selected": "ic_my_group"]);
                
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupSearchVC)],
                    "name": str(strRecherche),
                    "icon_normal":"ic_search_group",
                    "icon_selected": "ic_search_group_active"]);
                arrButtonTabBar.addObject([
                    "isscreen":[String(GroupInvitationAttend)],
                    "name": str(strInvitations),
                    "icon_normal":"group_ic_invite_inactive",
                    "icon_selected": "group_ic_invite"]);
                
                topTabBar.myMainNavCallBack = {(index: NSArray) in
                    self.clickSubNav_Group(index);
                };
            }
            
            break;
            
        default:
            break;
        }
        
        let dicRemove:NSMutableDictionary = NSMutableDictionary();
        
        if arrRemove != nil {
            for strClass in arrRemove! {
                dicRemove.setValue("1", forKey: strClass as! String);
            }
        }
        if dicRemove.allKeys.count > 0 {
            for nameClass in arrButtonTabBar {
                
                //user JSON to access value of Dictionary
                let dic = JSON(nameClass)
                
                if (dic["isscreen"].array != nil) {
                    
                    let isscreen = dic["isscreen"].rawValue as! NSArray;
                    
                    for name in isscreen {
                        
                        if ((dicRemove[name as! String] as? String) != nil) {
                            arrButtonTabBar.removeObject(nameClass);
                        }
                    }
                    
                }
            }
        }
        
        topTabBar.arrButtonTabBar = arrButtonTabBar;
        topTabBar.fontColors = (selectedColor: UIColorFromRGB(color), unselectedColor: UIColor.blackColor())
        
        topTabBar.labelFont = FONT_HELVETICANEUE(12);
        topTabBar.backgroundColor = UIColor.whiteColor()
        topTabBar.setupUI()
        view.addSubview(topTabBar)
        setupConstraints()
        //setup bottom bar
        setupMDBottomTabBar(topTabBar);
        
    }
    
    func setupConstraints() {
        //clear contraint
        self.view.removeConstraints(view.constraints)
        topTabBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:AnyObject] = ["topTabBar" : topTabBar, "vContainer" : vContainer];
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[topTabBar(==44)]-0-[vContainer]-0-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[topTabBar]-0-|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vContainer]-0-|", options: [], metrics: nil, views: views))
        
    }
    
    func updateStatusNavControls() {
        if bFilterON {
            self.topTabBar.updateStatusButton(2, dicChange: ["icon_normal":"mur_ic_action_filter","icon_selected": "mur_ic_action_filter_active"]);
        }
        else
        {
            self.topTabBar.updateStatusButton(2 , dicChange: ["icon_normal":"mur_ic_filter_off","icon_selected": "mur_ic_filter_off_active"]);
        }
        
        
    }
    
    func updateStateTopBar() {
        
//        topTabBar.buttonSelectWithNameScreen(NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last!);
        
        switch expectTarget {
            
        case .ISMUR:
            updateStatusNavControls();
            break
        default:
            break;
        }
        
    }
    
    func clickSubNav_Mur(index: NSArray) {
        for iscreen in index {
            if iscreen as! String == "back" {
                self.navigationController?.popViewControllerAnimated(false);
            }
            else if iscreen as! String == String(MurVC) {
                if self is MurVC {return;}
                let vc:MurVC = MurVC(nibName: String(MurVC), bundle: nil);
                self.pushVC(vc, expectTarget: ISSCREEN.ISMUR, isChildTarget: false, iAmParent: false, animate: false);
                return;
            }
            else if iscreen as! String == String(MurFilterVC)
            {
                if self is MurFilterVC {return;}
                let vc:MurFilterVC = MurFilterVC(nibName: String(MurFilterVC), bundle: nil);
                self.pushVC(vc, expectTarget: ISSCREEN.ISMUR, isChildTarget: false, iAmParent: false, animate: false);
                
                return;
            }
        }
    }
    
    func clickSubNav_Group(index: NSArray) {
        for iscreen in index {
            if iscreen as! String == "back" {
                self.navigationController?.popViewControllerAnimated(false);
            }
            else if iscreen as! String == String(GroupMesVC) {
                if self is GroupMesVC {return;}
                let vc:GroupMesVC = GroupMesVC(nibName: String(GroupMesVC), bundle: nil);
                self.pushVC(vc, expectTarget: ISSCREEN.ISGROUP, isChildTarget: false, iAmParent: false, animate: false);
                return;
            }
            else if iscreen as! String == String(GroupSearchVC)
            {
                if self is GroupSearchVC {return;}
                let vc:GroupSearchVC = GroupSearchVC(nibName: String(GroupSearchVC), bundle: nil);
                self.pushVC(vc, expectTarget: ISSCREEN.ISGROUP, isChildTarget: false, iAmParent: false, animate: false);
                
                return;
            }
            else if iscreen as! String == String(GroupSearchVC)
            {
                if self is GroupInvitationAttend {return;}
                let vc:GroupInvitationAttend = GroupInvitationAttend(nibName: String(GroupInvitationAttend), bundle: nil);
                self.pushVC(vc, expectTarget: ISSCREEN.ISGROUP, isChildTarget: false, iAmParent: false, animate: false);
                
                return;
            }
        }
        
    }
    
    func clickSubNav_Group_Child(index: NSArray) {
        for iscreen in index {
            if iscreen as! String == "back" {
                self.navigationController?.popViewControllerAnimated(false);
            }
            else if iscreen as! String == String(GroupEnterMurVC) {
                if self is GroupEnterMurVC {return;}
                let vc:GroupEnterMurVC = GroupEnterMurVC(nibName: String(GroupEnterMurVC), bundle: nil);
                self.pushVC(vc, expectTarget: ISSCREEN.ISGROUP, isChildTarget: true, iAmParent: false, animate: true);
                return;
            }
        }
        
    }
    
    //MARK: - BOTTOM BAR
    private func setupMDBottomTabBar(viewTop: UIView) {
        if showTabBottom == false {return;}
        
        let arrButtonTabBar = NSMutableArray();
        arrButtonTabBar.addObject(["icon":"icon_bottom_photo"]);
        arrButtonTabBar.addObject(["icon":"icon_bottom_video"]);
        arrButtonTabBar.addObject(["icon":"icon_bottom_location"]);
        bottomTabBar.myMainNavCallBack = {(index: Int) in
            self.bottomTabBarAction(index);
        };
        bottomTabBar.arrButtonTabBar = arrButtonTabBar;
        bottomTabBar.backgroundColor = UIColorFromRGB(BOTTOMBAR_COLOR);
        bottomTabBar.setupUI()
        view.addSubview(bottomTabBar)
        setupConstraintsBottomTabBar(viewTop)
    }
    
    func setupConstraintsBottomTabBar(viewTop: UIView) {
        
        //clear contraint
        self.view.removeConstraints(view.constraints)
        topTabBar.translatesAutoresizingMaskIntoConstraints = false
        bottomTabBar.translatesAutoresizingMaskIntoConstraints = false
        let views: [String:AnyObject] = ["viewTop" : viewTop,"bottomTabBar" : bottomTabBar, "vContainer" : vContainer]
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[viewTop(==44)]-0-[vContainer]-0-[bottomTabBar(==44)]-0-|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[bottomTabBar]-0-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[viewTop]-0-|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vContainer]-0-|", options: [], metrics: nil, views: views))
        
    }
    
    func bottomTabBarAction(index: Int) {
        switch index {
        case 0: // PHOTO
            break;
        case 1: // VIDEO
            break;
        case 2: // LOCATION
            break;
        default:
            break;
        }
    }
    
    //MARK: - PRE BAR
    private func setupMDPreTabBar(target: ISSCREEN) {

        let arrButtonTabBar = NSMutableArray();
        
        switch target {
        case .ISLOUNGE:
            arrButtonTabBar.addObject([
                "name": "PRÉCÉDENT",
                "color": CHASSES_BACK,
                "icon":"ic_previous"]);
            
            
            arrButtonTabBar.addObject([
                "name": "ANNULER",
                "color": CHASSES_CANCEL,
                "icon":"ic_close"]);

            break
        case .ISGROUP:
            arrButtonTabBar.addObject([
                "name": "PRÉCÉDENT",
                "color": GROUP_BACK,
                "icon":"ic_previous"]);
            
            
            arrButtonTabBar.addObject([
                "name": "ANNULER",
                "color": GROUP_CANCEL,
                "icon":"ic_close"]);

            break

        default:
            break
        }
        
        preTabBar.myMainNavCallBack = {(index: Int) in
            self.onSubNavClick(index);
        };
        preTabBar.arrButtonTabBar = arrButtonTabBar;
        preTabBar.backgroundColor = UIColorFromRGB(BOTTOMBAR_COLOR);
        preTabBar.setupUI()
        view.addSubview(preTabBar)
        setupConstraintsPreTabBar()
        //setup bottom bar
        setupMDBottomTabBar(preTabBar);
    }
    
    func setupConstraintsPreTabBar() {
        //clear contraint
        self.view.removeConstraints(view.constraints)
        preTabBar.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String:AnyObject] = ["preTabBar" : preTabBar, "vContainer" : vContainer];
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[preTabBar(==44)]-0-[vContainer]-0-|", options: [], metrics: nil, views: views))
        
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[preTabBar]-0-|", options: [], metrics: nil, views: views))
        view.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[vContainer]-0-|", options: [], metrics: nil, views: views))
    }
    
    func onSubNavClick(index: Int) {
        
    }
    
    //MARK: NAVIGATION
    func loadNavigation() {
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        let kclass:String = String(BaseNavigation);
        navigation = BaseNavigation(nibName: kclass, bundle: nil);
        navigation.view.frame = CGRectMake(0, 0, (self.navigationController?.navigationBar.frame.size.width)!, (self.navigationController?.navigationBar.frame.size.height)!)
        self.navigationController?.navigationBar.translucent = false;
        navigation.view.sizeToFit();
        self.navigationItem.titleView =  navigation.view;
        
    }
    
    func addMainNav(nameView: String) {
        subviewCount =  NSBundle.mainBundle().loadNibNamed(String(MainNavMUR), owner: self, options: nil)[0] as! MainNavigationBaseView;
        subviewCount.myMainNavCallBack = {(button: UIButton) in
            self.onMainNavClick(button);
        };
        subviewCount.translatesAutoresizingMaskIntoConstraints = false;
        navigation.viewNavigation1.addSubview(subviewCount);
        subviewCount.tag = TAG_MAIN_NAV_VIEW;
        //add contraint
        let views: [String:AnyObject] = ["subviewCount" : subviewCount];
        
        navigation.viewNavigation1.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[subviewCount]-0-|", options: [], metrics: nil, views: views))
        navigation.viewNavigation1.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat("H:|[subviewCount]|", options: [], metrics: nil, views: views))
        let btnAmis: UIImageView = subviewCount.viewWithTag(24) as! UIImageView;
        subviewCount.badgingBtn(btnAmis, iCount: 10);
        
    }
    
    func onMainNavClick(btn: UIButton) {
        switch btn.tag - START_SUB_NAV_TAG {
        case 0: //HOME
            self.navigationController?.popViewControllerAnimated(true);
            break;
        case 1: //SEARCH
            self.navigationController?.popViewControllerAnimated(true);
            break;
        case 2: //AMIS
            self.navigationController?.popViewControllerAnimated(true);
            break;
        case 3: //DISCUSS
            self.navigationController?.popViewControllerAnimated(true);
            break;
        case 4: //NOTIFICATION
            self.navigationController?.popViewControllerAnimated(true);
            break;
        case 5: //PROGRESS
            self.navigationController?.popViewControllerAnimated(true);
            break;
            
        default:
            break;
        }
    }
    
    //MARK: - PUSHVC
    func pushVC(vc: BaseVC, expectTarget: ISSCREEN,isChildTarget: Bool, iAmParent: Bool, animate: Bool)  {
        
        if let controllerArray: NSArray = self.navigationController!.viewControllers as NSArray
        {
            for controller in controllerArray {
                if controller.isKindOfClass(vc.classForCoder) {
                    self.navigationController?.popToViewController(controller as! UIViewController, animated: false);
                    return;
                }
            }
        }
        vc.expectTarget = expectTarget;
        vc.childTarget = isChildTarget;
        if iAmParent {
            vc.mParent = self;
        }
        else
        {
            vc.mParent = self.mParent;
        }
        let navigationController: MainNavigationController = self.navigationController as! MainNavigationController
        navigationController.pushViewController(vc, animated: animate) {
            
        }
    }
    
    func gotoback() {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
    //MARK: - PUSH REFRESH
    func initRefreshControl() {
        tableControl.addPullToRefreshWithActionHandler {
            self.insertRowAtTop()
        }
        
        tableControl.addInfiniteScrollingWithActionHandler {
            self.insertRowAtBottom()
        }
    }
    
    func startRefreshControl() {
        tableControl.triggerPullToRefresh()
    }
    
    func moreRefreshControl() {
        tableControl.triggerInfiniteScrolling()
    }
    
    func stopRefreshControl() {
        tableControl.pullToRefreshView.stopAnimating()
        tableControl.infiniteScrollingView.stopAnimating()
    }
    
    func isRemoveScrollingViewHeight(enable: Bool) {
        
    }
    
    //overwrite
    func insertRowAtTop() {
        
    }
    
    //overwrite
    func insertRowAtBottom() {
        
    }
    
    func convertDate(strInDate: String) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy H:mm"
        
        //OUTPUT
        let dateFormatter2 = NSDateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        dateFormatter2.locale = NSLocale.init(localeIdentifier: "fr_FR")
        dateFormatter2.timeZone = NSTimeZone.init(name: "Europe/Paris")
        let date = dateFormatter2.dateFromString(strInDate)
        let s = dateFormatter.stringFromDate(date!)
        return s
    }

    func InitializeKeyboardToolBar() -> Void {
//        if keyboardToolbar == nil {
//            keyboardToolbar = UIToolbar.init(frame: CGRectMake(0, 0, self.view.bounds.size.width, 38.0))
//            keyboardToolbar.barStyle   = .BlackTranslucent
//            spaceBarItem = UIBarButtonItem.init(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
//            doneBarItem = UIBarButtonItem.init(title: str(strOK), style: .Done, target: self, action: #selector(resignKeyboard))
//            keyboardToolbar.setItems([spaceBarItem,doneBarItem], animated: false)
//        }
        
    }
    
    func resignKeyboard(){
    }
    
    
}
