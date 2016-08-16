//
//  MapGlobalVC.swift
//  NaturaSwift
//
//  Created by Manh on 5/26/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import GoogleMaps
import Alamofire
import SwiftyJSON
import FMDB
class MapGlobalVC: BaseMapVC {
    let sender_id = NSUserDefaults.standardUserDefaults().objectForKey("userID") as! Int
    var visibleRegion:GMSVisibleRegion?;
    var expectTarget:ISSCREEN = .ISCARTE;
    //MARK: - INIT
    override func viewDidLoad() {
        super.viewDidLoad();
        MapDataDownloader.sharedInstance.fnGetSqliteForAllPointsInMap([kSQL_shape]);
        
        
    }
    //MARK: - API
    func getMapData() -> Void {
        
        //test ggtt
        tableControl.registerNib(UINib.init(nibName: String(TypeCell1), bundle: nil), forCellReuseIdentifier: TypeCell1ID);
        
        
        //load latest point and data cached
        //        let theCenter: NSDictionary = (NSUserDefaults.standardUserDefaults().objectForKey(concatstring("", str2:  "CACHE_LAST_POINT")) as? NSDictionary)!;
        //        if (theCenter.isEqual(nil)) {
        //            simpleDic = ["latitude": theCenter["mapLat"]!,
        //                        "longitude": theCenter["mapLong"]!
        //            ];
        //        }
        
        //        let api:WebServiceAPI = WebServiceAPI();
        
        
        //        api.fnGET_REAL_LOGIN_NO_PUSH("dinhmanhvp@gmail.com", password: "d2009cda4865812da8c2c0527c69ed3e287a78ed") { response in
        //            print(response)
        //
        //            NSUserDefaults.standardUserDefaults().setValue("3608", forKey: "sender_id")
        //            NSUserDefaults.standardUserDefaults().synchronize()
        //
        //
        //            let sender_id = NSUserDefaults.standardUserDefaults().valueForKey("sender_id")
        //            print(sender_id!)
        //
        //
        MapDataDownloader.sharedInstance.fnGetSqliteForAllPointsInMap([kSQL_shape])
        //
        //        }
    }
    
    //MARK: - FUNC
    func forceRefresh()  {
        NSObject.cancelPreviousPerformRequestsWithTarget(self);
        self.performSelector(#selector(updateUICarte), withObject: nil, afterDelay: 2);
    }
    func updateUICarte() {
        fnGetShapes();
    }
    func fnGetShapes()  {
        let mutArr: NSMutableArray = NSMutableArray();
        DatabaseManager.sharedInstance.queue.inTransaction {
            (db, rollback) in
            let discardedItem: NSMutableArray = NSMutableArray();
            // If shape not in DB --> del
            for overlay in self.arrOverlays
            {
                let dic = JSON(overlay);
                if let strCid: String =  dic["c_id"].stringValue
                {
                    let strQuery:String = String(format: "SELECT c_id FROM tb_shape WHERE c_id==%@ ORDER BY c_updated DESC LIMIT 1", strCid);
                    var isExist: Bool = false;
                    do{
                        let set_query1: FMResultSet = try db.executeQuery(strQuery, values: nil);
                        while set_query1.next()
                        {
                            isExist = true;
                        }
                    }
                    catch {
                        print(error)
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        if isExist == false
                        {
                            if dic["shape"].rawValue is GMSPolyline
                            {
                                discardedItem.addObject(dic["shape"].rawValue);
                                let polyline: GMSPolyline = dic["shape"].rawValue as! GMSPolyline;
                                polyline.map = nil;
                                if dic["shapeLegend"].rawValue is GMSMarker
                                {
                                    let shapeLegendDel: GMSMarker = dic["shapeLegend"].rawValue as! GMSMarker;
                                    shapeLegendDel.map = nil;
                                }
                            }
                            else if dic["shape"].rawValue is GMSPolygon
                            {
                                discardedItem.addObject(dic["shape"].rawValue);
                                let polygon: GMSPolygon = dic["shape"].rawValue as! GMSPolygon;
                                polygon.map = nil;
                                if dic["shapeLegend"].rawValue is GMSMarker
                                {
                                    let shapeLegendDel: GMSMarker = dic["shapeLegend"].rawValue as! GMSMarker;
                                    shapeLegendDel.map = nil;
                                }
                                
                            }
                            else if dic["shape"].rawValue is GMSCircle
                            {
                                discardedItem.addObject(dic["shape"].rawValue);
                                let pvcircle: GMSCircle = dic["shape"].rawValue as! GMSCircle;
                                pvcircle.map = nil;
                                if dic["shapeLegend"].rawValue is GMSMarker
                                {
                                    let shapeLegendDel: GMSMarker = dic["shapeLegend"].rawValue as! GMSMarker;
                                    shapeLegendDel.map = nil;
                                }
                            }
                        }
                    })
                }
                
            }
            self.arrOverlays.removeObjectsInArray(discardedItem as [AnyObject]);
            let mutStr: NSMutableString = NSMutableString();
            mutStr.setString("SELECT DISTINCT * FROM tb_shape ");
            let bounds:GMSCoordinateBounds = GMSCoordinateBounds.init(region: self.visibleRegion!);
            let m_MOBILE_NE: CLLocationCoordinate2D = bounds.northEast;
            let m_MOBILE_SW: CLLocationCoordinate2D = bounds.southWest;
            mutStr.appendString(String(format: " WHERE(((%f BETWEEN  c_ne_lat AND c_sw_lat) OR(%f BETWEEN  c_ne_lat AND c_sw_lat) OR (c_ne_lat BETWEEN  %f AND %f) OR (c_sw_lat BETWEEN  %f AND %f) ) AND ( (%f BETWEEN c_ne_lng AND c_sw_lng) OR (%f BETWEEN c_ne_lng AND c_sw_lng) OR (c_ne_lng BETWEEN %f AND %f) OR  (c_sw_lng BETWEEN %f AND %f))) ", m_MOBILE_SW.latitude,m_MOBILE_NE.latitude,m_MOBILE_SW.latitude ,m_MOBILE_NE.latitude, m_MOBILE_SW.latitude ,m_MOBILE_NE.latitude,
                m_MOBILE_SW.longitude, m_MOBILE_NE.longitude ,m_MOBILE_SW.longitude , m_MOBILE_NE.longitude,
                m_MOBILE_SW.longitude , m_MOBILE_NE.longitude));
            mutStr.appendString(String(format: " AND c_user_id=%@ ",self.sender_id));
            //2. checking: if atleast 1 point is in the visible area ... or ... center of it in ... => 5 points
            if bFilterON == false
            {
                switch self.expectTarget {
                case .ISGROUP:
                    mutStr.appendString("AND ( ");
                    let tmp: String = (GroupEnterOBJ.sharedInstance.dictionaryGroup.objectForKey("id")?.stringValue)!;
                    if tmp != ""
                    {
                        mutStr.appendString(String(format:"  c_groups LIKE \"%%[%@]%%\" ", tmp ))
                    }
                    mutStr.appendString( ") ");
                    break;
                case .ISLOUNGE:
                    mutStr.appendString("AND ( ");
                    let tmp: String = (GroupEnterOBJ.sharedInstance.dictionaryGroup.objectForKey("id")?.stringValue)!;
                    if tmp != ""
                    {
                        mutStr.appendString(String(format:"  c_hunts LIKE \"%%[%@]%%\" ", tmp ))
                    }
                    mutStr.appendString( ") ");
                    break;
                default:
                    break;
                }
                
            }
            else
            {
                mutStr.appendString("AND ( ");
                switch self.expectTarget {
                case .ISGROUP:
                    let tmp: String = (GroupEnterOBJ.sharedInstance.dictionaryGroup.objectForKey("id")?.stringValue)!;
                    if tmp != ""
                    {
                        mutStr.appendString(String(format:"  c_groups LIKE \"%%[%@]%%\" ", tmp ))
                    }
                    break;
                case .ISLOUNGE:
                    let tmp: String = (GroupEnterOBJ.sharedInstance.dictionaryGroup.objectForKey("id")?.stringValue)!;
                    if tmp != ""
                    {
                        mutStr.appendString(String(format:"  c_hunts LIKE \"%%[%@]%%\" ", tmp ))
                    }
                    break;
                case .ISCARTE:
                    if self.strFilterType == "0"
                    {
                        mutStr.appendString(String(format:" (c_owner_id=%@) ", self.sender_id ))
                    }
                    else if self.strFilterType == "1"
                    {
                        mutStr.appendString(String(format:"  (c_friend=1)" ))
                        
                    }
                    else if self.strFilterType == "3"
                    {
                        mutStr.appendString(String(format:"  (c_member=1)" ))
                        
                    }
                    else
                    {
                        mutStr.appendString(String(format:"  (0)" ))
                        
                    }
                    //groups
                    let arrGr: NSArray = self.strMesGroupFilter.componentsSeparatedByString(",");
                    for mGroup in arrGr
                    {
                        let tmp: String = mGroup.stringByReplacingOccurrencesOfString(" ", withString: "");
                        if tmp != ""
                        {
                            mutStr.appendString(String(format:" OR (c_groups LIKE \"%%[%@]%%\") ", tmp ))
                            
                        }
                    }
                    //hunts
                    let arrHunt: NSArray = self.strMesHuntFilter.componentsSeparatedByString(",");
                    for mHunt in arrHunt
                    {
                        let tmp: String = mHunt.stringByReplacingOccurrencesOfString(" ", withString: "");
                        if tmp != ""
                        {
                            mutStr.appendString(String(format:" OR (c_hunts LIKE \"%%[%@]%%\") ", tmp ))
                            
                        }
                    }
                    break;
                default:
                    break;
                }
                mutStr.appendString(") ");
            }
            do{
                let set_query1: FMResultSet = try db.executeQuery(mutStr as String, values: nil);
                while set_query1.next()
                {
                }
            }
            catch {
                print(error)
            }
            
            
        }
    }
    @IBAction func fnBack(sender: AnyObject) {
        
        self.navigationController? .popViewControllerAnimated(true)
    }
    //MARK: - MARKER
    //1.get data
    //1.1. Filter
    func getFilter() {
        
        if let filterDic: NSDictionary = NSUserDefaults.standardUserDefaults().objectForKey("OBJECT_FILTER") as? NSDictionary,
            let filter = filterDic["isFilter"] as? Bool where filter == true {
            self.strFilterType =  filterDic["iFilter"] as! String;
            //get groupID
            let strPathGroup: String = FileHelper.pathForApplicationDataFile(concatstring(String(sender_id), str2: SHARE_MES_GROUP_SAVE));
            let arrTmp: NSArray = NSArray.init(contentsOfFile: strPathGroup)!;
            let arrGroup: NSMutableArray = NSMutableArray();
            for dic in arrTmp {
                let convert = JSON(dic)
                if convert["isSelected"].boolValue == true {
                    arrGroup.addObject(convert["groupID"].stringValue);
                }
            }
            self.strMesGroupFilter = arrGroup.componentsJoinedByString(",");
            //get huntID
            let strPathHunt: String = FileHelper.pathForApplicationDataFile(concatstring(String(sender_id), str2: SHARE_MES_HUNT_SAVE));
            let arrHuntTmp: NSArray = NSArray.init(contentsOfFile: strPathHunt)!;
            let arrHunt: NSMutableArray = NSMutableArray();
            for dic in arrHuntTmp {
                let convert = JSON(dic)
                if convert["isSelected"].boolValue == true {
                    arrHunt.addObject(convert["huntID"].stringValue);
                }
            }
            self.strMesHuntFilter = arrHunt.componentsJoinedByString(",");
        }
        else
        {
            self.strFilterType = "3";
        }
        fnFilterChangeImage();
        if bFilterON == true {
            if (self.strMesGroupFilter == nil  || self.strMesGroupFilter == "") && (self.strMesHuntFilter == nil || self.strMesHuntFilter == "") && self.strFilterType.intValue < 0{
                vTmpMap.warning.hidden = false;
                vTmpMap.warning.text = str(strWarningONWithoutSelection);
                vTmpMap.warning.setNeedsDisplay();
            }
            else
            {
                vTmpMap.warning.hidden = true;
                vTmpMap.warning.text = "";
                vTmpMap.warning.setNeedsDisplay();
            }
        }
        else
        {
            vTmpMap.warning.hidden = true;
            vTmpMap.warning.text = "";
            vTmpMap.warning.setNeedsDisplay();
        }
        
    }
    //1.2. get Category
    func fnCategory() {
        
    }
    //2. show data
    func fnFilterChangeImage() {
        
    }
    
    
    @IBAction func doLeftMenu() {
        navigationController?.popToRootViewControllerAnimated(true)
        //    [self doRemoveObservation];
        
    }
    
}