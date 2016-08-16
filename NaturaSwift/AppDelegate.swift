//
//  AppDelegate.swift
//  NaturaSwift
//
//  Created by Giang on 3/3/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import OKAlertController

@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController: MainNavigationController?;
    
    
    func forceLogin() -> Void {
        
        
        let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
        
        if let arr = NSUserDefaults.standardUserDefaults().objectForKey("userinfo") {
            
            for dic in arr as! NSArray{
                let convert = JSON(dic)
                
                if convert["id"].intValue == sender_id {
                    
                    //matching password...auto login
                    let strPassword: String = "\(SHA1_KEY)\(convert["pwd"].stringValue)"
                    
                    let api:WebServiceAPI = WebServiceAPI();
                    
                    api.fnGET_REAL_LOGIN( convert["email"].stringValue, password: strPassword.SHA1() , pushToken: "1e7da48ebacb6f1e8b8e73937ffc91520029efc6d1982f499907faf743c7381d") { (responseData, code) in
                        
                        
                        print("\(responseData)")
                        
                        guard (responseData as? NSDictionary) != nil else{
                            
                            print("err")
                            
                            return
                        }

                        
                        if let u1 = responseData!["user"], u2 = u1!["id"]!{
                            
                            let mutDic: NSMutableDictionary = u1!.mutableCopy() as! NSMutableDictionary
                            
                            let localArr : NSMutableArray = []
                            
                            mutDic["pwd"] = convert["pwd"].stringValue
                            
                            localArr.addObject(mutDic)
                            
                            NSUserDefaults.standardUserDefaults().setObject(localArr, forKey: "userinfo")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            NSUserDefaults.standardUserDefaults().setObject(u2, forKey: "userID")
                            NSUserDefaults.standardUserDefaults().synchronize()
                        }

                        
                    }
                    
                    
                }
                
            }
        }
        
        
    }
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        queueFMDatabase()
        GMSServices.provideAPIKey(GOOGLE_PLACE_API);
        
        HNKGooglePlacesAutocompleteQuery.setupSharedQueryWithAPIKey("AIzaSyAyZkjQbl2HA72X0DUcu2wITsswwUP_UEc")

        
        
        
        window = UIWindow.init(frame: UIScreen.mainScreen().bounds);
        window?.backgroundColor = UIColor.whiteColor();
        
        let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID")

        if (sender_id != nil) {
            //login before
            //update sessionID new
            forceLogin()
            //display Home
            self.gotoApplication()
        }else{
        //show Login
            let kclass:String = String(LoginVC);
            let vc:LoginVC = LoginVC(nibName:kclass, bundle: nil);
            self.window?.rootViewController = vc;

        }
        
        window?.makeKeyAndVisible()

        return true
    }
    
    func loadLoginView() -> Void {
        
        // Create alert controller as usual
        let alert = OKAlertController(title: "Disconnect", message: "Do u want to logout?")
        
        // Fill with reqired actions
        alert.addAction("Ok", style: .Default) { _ in
            
            NSUserDefaults.standardUserDefaults().removeObjectForKey("userID")
            
            // Process action
            let kclass:String = String(LoginVC);
            let vc:LoginVC = LoginVC(nibName:kclass, bundle: nil);
            self.window?.rootViewController = vc;
            
            
        }
        
        alert.addAction("Cancel", style: .Cancel, handler: nil) // Ignore cancel action handler
        
        // Setup alert controller to conform design
        
        alert.show(fromController: navigationController!, animated: true)
    }
    
    func gotoApplication() -> Void {
        let vc:HomeVC = HomeVC(nibName:"HomeVC", bundle: nil);
        navigationController = MainNavigationController(rootViewController: vc);
        window?.rootViewController = navigationController;
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func queueFMDatabase()
    {
        //c_allow_add using to tick on group Edit...show shareview in creating publication
        //c_allow_show using to tick on group Edit
        let str1: String = "CREATE TABLE IF NOT EXISTS  `tb_shape` (`c_id`    INTEGER," +
            "`c_owner_id`    INTEGER," +
            "`c_type`    TEXT," +
            "`c_title`    TEXT," +
            "`c_description`    TEXT," +
            "`c_sharing`    INTEGER," +
            "`c_groups`    TEXT," +
            "`c_hunts`    TEXT," +
            "`c_friend`    INTEGER," +
            "`c_member`    INTEGER," +
            "`c_data`   TEXT," +
            "`c_updated`    INTEGER," +
            "`c_ne_lat`    REAL," +
            "`c_ne_lng`    REAL," +
            "`c_sw_lat`    REAL," +
            "`c_sw_lng`    REAL," +
            "`c_user_id`    INTEGER," +
        "PRIMARY KEY(c_id,c_user_id));"
        
        let str2: String = "CREATE TABLE IF NOT EXISTS   `tb_group` (" +
            "`c_id`    INTEGER," +
            "`c_name`    TEXT," +
            "`c_description`    TEXT," +
            "`c_access`    INTEGER," +
            "`c_admin`    INTEGER," +
            "`c_nb_member`    INTEGER," +
            "`c_user_id`    INTEGER," +
            "`c_updated`    INTEGER," +
            "`c_allow_add`    INTEGER," +
            "`c_allow_show`    INTEGER," +
            "PRIMARY KEY(c_id,c_user_id)" +
        ");"
        
        let str3: String = "CREATE TABLE  IF NOT EXISTS  `tb_hunt` (" +
            "`c_id`    INTEGER," +
            "`c_name`    TEXT," +
            "`c_description`    TEXT," +
            "`c_access`    INTEGER," +
            "`c_admin`    INTEGER," +
            "`c_nb_participant`    INTEGER," +
            "`c_start_date`    INTEGER," +
            "`c_end_date`    INTEGER," +
            "`c_meeting_address`    TEXT," +
            "`c_meeting_lat`    REAL," +
            "`c_meeting_lon`    REAL," +
            "`c_user_id`    INTEGER," +
            "`c_updated`    INTEGER," +
            "PRIMARY KEY(c_id,c_user_id)" +
        ");"
        
        let str4: String = "CREATE TABLE  IF NOT EXISTS `tb_favorite` (" +
            "`c_id`    INTEGER," +
            "`c_name`    TEXT," +
            "`c_legend`    TEXT," +
            "`c_color`    INTEGER," +
            "`c_category`    INTEGER," +
            "`c_tree`    TEXT," +
            "`c_card`    INTEGER," +
            "`c_animal`    INTEGER," +
            "`c_specific`    INTEGER," +
            "`c_sharing`    INTEGER," +
            "`c_groups`    TEXT," +
            "`c_hunts`    TEXT," +
            "`c_attchments`    TEXT," +
            "`c_user_id`    INTEGER," +
            "`c_updated`    INTEGER," +
            "PRIMARY KEY(c_id,c_user_id)" +
        ");"
        
        let str5: String = "CREATE TABLE IF NOT EXISTS `tb_favorite_address` (" +
            "`c_id`    INTEGER," +
            "`c_title`    TEXT," +
            "`c_favorite`    TEXT," +
            "`c_lat`    REAL," +
            "`c_lon`    REAL," +
            "`c_user_id`    INTEGER," +
            "PRIMARY KEY(c_id,c_user_id)" +
        ");"
        
        let str6: String = "CREATE TABLE IF NOT EXISTS  `tb_db_version` (`version`    INTEGER);"
        
        let str7: String = "CREATE TABLE IF NOT EXISTS  `tb_distributor` (`c_id`    INTEGER," +
            "`c_name`    TEXT," +
            "`c_address`    TEXT," +
            "`c_cp`    TEXT," +
            "`c_city`    TEXT," +
            "`c_tel`    TEXT," +
            "`c_email`    TEXT," +
            "`c_lat`    REAL," +
            "`c_lon`    REAL," +
            "`c_brands`    TEXT," +
            "`c_updated`    INTEGER," +
            "`c_logo`    TEXT," +
            "PRIMARY KEY(c_id)" +
        ");"
        
        let str8: String = "CREATE TABLE IF NOT EXISTS `tb_dog_breed` (`c_id`    INTEGER," +
            "`c_name`    TEXT," +
            "PRIMARY KEY(c_id)" +
        ");"
        
        
        let arrSqlites = [str1,str2,str3,str4,str5,str6,str7,str8 ]
        
        DatabaseManager.sharedInstance.queue.inTransaction {
            (db, rollback) in
            
            do{
                for str in arrSqlites
                {
                    try db.executeUpdate(str, values: nil)
                }
            }
            catch {
                print(error)
            }
        }
        
        /*
         
         
         @"CREATE TABLE IF NOT EXISTS `tb_dog_breed` (`c_id`    INTEGER" +
         `c_name`    TEXT" +
         PRIMARY KEY(c_id)\
         );",
         
         @"CREATE TABLE IF NOT EXISTS `tb_dog_type` (`c_id`    INTEGER" +
         `c_name`    TEXT" +
         PRIMARY KEY(c_id)\
         );",
         
         @"CREATE TABLE IF NOT EXISTS `tb_weapon_brand` (`c_id`    INTEGER" +
         `c_name`    TEXT" +
         PRIMARY KEY(c_id)\
         );",
         
         @"CREATE TABLE IF NOT EXISTS `tb_weapon_calibre` (`c_id`    INTEGER" +
         `c_name`    TEXT" +
         PRIMARY KEY(c_id)\
         );"
         ];
         //table distributor
         
         [[DatabaseManager sharedManager].queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
         
         for (NSString*strQuerry in arrSqlites) {
         [db  executeUpdate:strQuerry];
         }
         
         /*ADD 1 columns  c_default */
         
         if (![db  columnExists:@"c_default" inTableWithName:@"tb_favorite"])
         {
         NSArray*  arrQuery2 = @[@"ALTER TABLE tb_favorite ADD COLUMN c_default INTEGER"];
         
         for (NSString*strQuerry in arrQuery2) {
         
         [db  executeUpdate:strQuerry];
         }
         
         }
         
         /*ADD 2 columns  c_lat_center + c_lng_center */
         if (![db  columnExists:@"c_lat_center" inTableWithName:@"tb_shape"])
         {
         NSArray*  arrQuery3 = @[@"ALTER TABLE tb_shape ADD COLUMN c_lat_center REAL",
         @"ALTER TABLE tb_shape ADD COLUMN c_lng_center REAL" ];
         
         for (NSString*strQuerry in arrQuery3) {
         
         [db  executeUpdate:strQuerry];
         }
         }
         
         
         }];
         */
    }
    
    
}

