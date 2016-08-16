//
//  BaseMapVC.swift
//  NaturaSwift
//
//  Created by Manh on 5/26/16.
//  Copyright © 2016 PHS. All rights reserved.
//

import Foundation
import GoogleMaps
import SwiftyJSON

/*
 -(IBAction)fnIncrease;
 -(IBAction)fnDecrease;
 -(IBAction)fnTracking_CurrentPos;
 -(IBAction)CarteTypeAction;
 
 */

let kHNKDemoSearchResultsCellIdentifier = "HNKDemoSearchResultsCellIdentifier"

class BaseMapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, BaseMapUIDelegate , BaseMapUIDatasource{
    
    
    var circle: MKCircle!
    var selectorOverlayRenderer: DBMapSelectorOverlayRenderer!
    var selectorOverlay: DBMapSelectorOverlay!
    
    var arrDistributorAnnotations: NSMutableArray! = NSMutableArray()
    var arrPublication: NSMutableArray! = NSMutableArray()
    var mapShapes: NSMutableArray! = NSMutableArray()
    var arrOverlays: NSMutableArray! = NSMutableArray()
    var arrTitleShapeAnnotations: NSMutableArray!
    
    var searchResults: NSArray! = NSArray()
    
    var locationManager: CLLocationManager! = CLLocationManager()
    var centerPointAnnotation: MKPointAnnotation!
    
    var markView: MKAnnotationView!
    var placemark: CLPlacemark!
    var strLatitude: NSString!
    var strLongitude: NSString!
    var strFilterType: NSString!
    var strMesGroupFilter: NSString!
    var strMesHuntFilter: NSString!
    var strMesCategoryFilter: NSString!
    
    var centerAnnotationView: MKAnnotationView!
    
    var northEastFilter: CLLocationCoordinate2D!
    var southWestFilter: CLLocationCoordinate2D!
    var lastLocationCoordinate: CLLocationCoordinate2D!
    
    var canRequestMedia: Bool!
    var isCategoryON: Bool!
    var isUsingLocation: Bool!
    var iCanRequest: Bool!  
    var isDragging: Bool!
    var isFirsTime: Bool! = true
    var shouldBeginEditing: Bool!
    
    
    var myServiceAPI: WebServiceAPI!
    var iCount: Int!
    var iZoomDefaultLevel: Float!
    var indexTracking: Int!
    
    var mapScaleView: LXMapScaleView_Google!
    var vTmpMap: BaseMapUI!
    var selectedPlaceAnnotation: GMSMarker!
    var dicMarkerDistribution: NSMutableDictionary! = NSMutableDictionary()
    var myDIC_MarkerPublication: NSMutableDictionary! = NSMutableDictionary()
    
    
    
    @IBOutlet weak var baseMapView: UIView!
    @IBOutlet weak var toussearchBar: UISearchBar!
    @IBOutlet weak var searchAddress: UISearchBar!
    @IBOutlet weak var btnLeftMenu: UIButton!
    @IBOutlet weak var searchQuery: HNKGooglePlacesAutocompleteQuery!
    @IBOutlet weak var tableControl: UITableView!

    
    var myC_Search_Text: NSString!
    var currentDist: Double!
    
    var metTer: Double!
    
    
    var whiteCircle: GMSCircle!
    
    var textCircleTop: GMSMarker!
    var textCircleBottom: GMSMarker!
    
    var bearing: CLLocationDirection!
    
    
    
    
    //    @IBOutlet weak var mapView_:GMSMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let nibArrayTab: NSArray = NSBundle.mainBundle().loadNibNamed("BaseMapUI", owner: self, options: nil)
        
        vTmpMap = nibArrayTab[0] as! BaseMapUI
        vTmpMap.attachToParent(baseMapView)
        vTmpMap.mapView_.delegate = self
        vTmpMap.delegate = self
        vTmpMap.datasource = self
        vTmpMap.updateUI()
        
        self.toussearchBar.placeholder = str(strPlaceHolderFilter_Csearch)
        
        
        
        //        if (self.expectTarget == ISLOUNGE) {
        
        //            if ([[GroupEnterOBJ sharedInstance].dictionaryGroup[@"connected"] isKindOfClass: [NSDictionary class]]) {
        //                if([[GroupEnterOBJ sharedInstance].dictionaryGroup[@"connected"][@"access"]isEqual:@3])
        //                {
        //                    //admin
        //                    self.dicOption =@{@"admin":@1};
        //
        //                }else{
        //                    self.dicOption =@{@"admin":@0};
        //
        //                }
        //
        //            }else{
        //                self.dicOption =@{@"admin":@0};
        //            }
        //        }
        
        
        
        
        self.tableControl.hidden=true;
        self.tableControl.alpha = 0.75;
        
        iZoomDefaultLevel = 18;
        
        navigationItem.setHidesBackButton(true, animated: true)
        
        self.searchQuery = HNKGooglePlacesAutocompleteQuery.sharedQuery()
        locationManager.delegate=self
        
        vTmpMap.mapView_.settings.scrollGestures = true
        vTmpMap.mapView_.settings.zoomGestures = true
        vTmpMap.mapView_.myLocationEnabled = true
        
        vTmpMap.mapView_.settings.compassButton = true
        
        vTmpMap.mapView_.settings.allowScrollGesturesDuringRotateOrZoom = false
        
        vTmpMap.mapView_.delegate = self
        
        vTmpMap.mapView_.mapType = GoogleMaps.kGMSTypeSatellite
        
    }
    
    func fnTracking_CurrentPos() {
        //            switch indexTracking {
        //            case 0:
        //                indexTracking = 1
        //
        //
        //                vTmpMap.map
        //                [vTmpMap.mapView_ addObserver:self forKeyPath:@"myLocation" options:NSKeyValueObservingOptionNew context:nil];
        //
        //
        //                break;
        //
        //            default:
        //                <#code#>
        //            }
    }
    //
    //
    
    
    
    
    //MARK: -----observeValueForKeyPath-------
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if ((keyPath?.compare("myLocation")) != nil && (object?.isKindOfClass(GMSMapView.classForCoder()))!) {
            let newLocation: CLLocation = (object?.myLocation)!;
            if indexTracking ==  2 {
                vTmpMap.mapView_.animateToCameraPosition(GMSCameraPosition.cameraWithLatitude(newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude, zoom: vTmpMap.mapView_.camera.zoom, bearing:bearing , viewingAngle: 0 ));
                
            }
            else
            {
                if ((isFirsTime) != nil) {
                    isFirsTime = false;
                    vTmpMap.mapView_.animateToCameraPosition(GMSCameraPosition.cameraWithLatitude(newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude, zoom: iZoomDefaultLevel));
                }
                else
                {
                    vTmpMap.mapView_.animateToCameraPosition(GMSCameraPosition.cameraWithLatitude(newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude, zoom: vTmpMap.mapView_.camera.zoom));
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.performSelector(#selector(self.refreshCircle), withObject: nil, afterDelay: 0.75);
                })
                vTmpMap.mapView_.removeObserver(self, forKeyPath: "myLocation");
                
            }
        }
        
    }
    
    //MARK: -----GMSMapViewDelegate------
    func mapView(mapView: GMSMapView, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        
    }
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        
    }
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        return true;
    }
    func mapView(mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return nil;
    }
    //MARK: ----- CIRCLE -----
    func refreshCircle() {
        
        
    }
    func placeAtIndexPath(indexPath: NSIndexPath) -> HNKGooglePlacesAutocompletePlace {
//        if self.searchResults.count < indexPath.row {
//            return nil
//        }
        return self.searchResults[indexPath.row] as! HNKGooglePlacesAutocompletePlace
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kHNKDemoSearchResultsCellIdentifier, forIndexPath: indexPath) ;

        
//        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: kHNKDemoSearchResultsCellIdentifier)
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
//                reuseIdentifier:kHNKDemoSearchResultsCellIdentifier];
//        }
        
        cell.textLabel!.font = UIFont.init(name: "GillSans", size: 16.0)
        
        cell.textLabel!.text = placeAtIndexPath(indexPath).name
        
        return cell;

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        iCanRequest = YES;
//        isDragging = NO;
//        
//        self.indexTracking = 2;
//        [self fnTracking_CurrentPos: nil];
//        
//        HNKGooglePlacesAutocompletePlace *place = [self placeAtIndexPath:indexPath];
//        [CLPlacemark hnk_placemarkFromGooglePlace:place
//            apiKey:self.searchQuery.apiKey
//            completion:^(CLLocation *m_Placemark, NSString *addressString, NSError *error) {
//            if (error) {
//            [KSToastView ks_showToast:str(strAdresseIntrouvable) duration:2.0f completion: ^{
//            }];
//            
//            } else if (m_Placemark) {
//            if (self.searchResults.count > indexPath.row) {
//            [self addPlacemarkAnnotationToMap:m_Placemark addressString:addressString];
//            [self recenterMapToPlacemark:m_Placemark];
//            [self.tableControl
//            deselectRowAtIndexPath:indexPath
//            animated:NO];
//            self.tableControl.hidden=YES;
//            self.searchAddress.text=  [self placeAtIndexPath:indexPath].name;
//            [self.searchAddress setShowsCancelButton:NO animated:YES];
//            [self.searchAddress resignFirstResponder];
//            
//            
//            [self doReloadRefresh];
//            }
//            }
//            }];

    }
    


    
    
    
    
    
    func fnIncrease() {
        
        iZoomDefaultLevel = vTmpMap.mapView_.camera.zoom;
        iZoomDefaultLevel = iZoomDefaultLevel + 1;
        
        let zoomCamera: GMSCameraUpdate =  GMSCameraUpdate.zoomIn()
        
        vTmpMap.mapView_.animateWithCameraUpdate(zoomCamera)
    }
    
    
    func fnDecrease() {
        
        iZoomDefaultLevel = vTmpMap.mapView_.camera.zoom;
        iZoomDefaultLevel = iZoomDefaultLevel - 1;
        
        let zoomCamera: GMSCameraUpdate =  GMSCameraUpdate.zoomOut()
        
        vTmpMap.mapView_.animateWithCameraUpdate(zoomCamera)
        
        //        doReloadRefresh()
    }
    
    
    func addPublication(marker: GMSMarker) {
        
        let temp = JSON(marker.userData!)
        
        myDIC_MarkerPublication[ temp["c_id"].stringValue ] =  marker
    }
    
    
    func removeAllPublication() {
        myDIC_MarkerPublication.removeAllObjects()
    }
    
    
    func removePublicationWithKey(key: NSString) {
        myDIC_MarkerPublication.removeObjectForKey(key)
    }
    
    
    //MARKER:- GMS marker
    
    func GMSaddMarkerLegendMap(dic: NSDictionary) -> (GMSMarker){

        let dicTmp = JSON(dic)

        
        let position: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: dicTmp["c_lat"].doubleValue,
                                                                          longitude: dicTmp["c_lon"].doubleValue )
        let marker: GMSMarker = GMSMarker.init(position: position)
        
        marker.userData = dic;
        marker.infoWindowAnchor = CGPointMake(0.5, 0.5);
        marker.groundAnchor = CGPointMake(0.5, 0.5);
        
        let tmpImage: MDMarkersLegend = MDMarkersLegend.init(dicmarkers: dic, resize: false)
        
        tmpImage.CallBackMarkers = {(image)-> Void in
            marker.icon = image;
            marker.map = self.vTmpMap.mapView_;
            
        }
        
        tmpImage.doSetCalloutView()
        
        return marker;
    }
    
    
    
    
    //MARK:- shapes
    
    
    func loadOptionShapes(mapShapes: NSArray) -> Void {
        
        for dicShapes in mapShapes {
            let strType: NSString = dicShapes["c_type"] as! NSString
            
            switch strType {
            case SHAPE_TYPE_POLYGON:
                break
            case SHAPE_TYPE_POLYLINE:
                break
            case SHAPE_TYPE_CIRCLE:
                break
            case SHAPE_TYPE_RECTANGLE:
                break
                
            default: break
                
            }
            
        }
    }
    
    
    
    //    -(void)loadOptionShapes:(NSArray*)mapShapes
    //    {
    //
    //    for (NSDictionary *dicShapes in mapShapes) {
    //    NSString *strType =dicShapes[@"c_type"];
    //
    //    if ([strType isEqualToString:SHAPE_TYPE_POLYGON]) {
    //    [self addPolygon:dicShapes];
    //    }
    //    else if ([strType isEqualToString:SHAPE_TYPE_POLYLINE])
    //    {
    //    [self addPolyline:dicShapes];
    //
    //    }
    //    else if ([strType isEqualToString:SHAPE_TYPE_CIRCLE])
    //    {
    //    [self addCircle:dicShapes];
    //
    //    }
    //    else if ([strType isEqualToString:SHAPE_TYPE_RECTANGLE])
    //    {
    //    [self addRectangle:dicShapes];
    //    }
    //    }
    //    }
    //
    
    func convertColorWithStringWithAlpha(strColor: NSString) -> UIColor {
        
        let tmpColor = strColor.stringByReplacingOccurrencesOfString("#", withString: "")
        var result: CUnsignedInt = 0
        let scanner:NSScanner = NSScanner(string: tmpColor)
        
        scanner.locale = 0
        scanner.scanHexInt(&result)
        
        return UIColor.init(rgb: result, alpha: 0.3)
    }
    
    func convertColorWithString(strColor: NSString) -> UIColor {
        
        let tmpColor = strColor.stringByReplacingOccurrencesOfString("#", withString: "")
        var result: CUnsignedInt = 0
        let scanner:NSScanner = NSScanner(string: tmpColor)
        
        scanner.locale = 0
        scanner.scanHexInt(&result)
        
        return UIColor.init(rgb: result, alpha: 1)
    }
    
    func addPolygon(dic: NSDictionary) -> Void {
        
        let dicTmp = JSON(dic)
        
        let dicShapes = dicTmp["c_data"].dictionaryValue
        let listPoint = dicShapes["paths"]!.arrayValue
        
        let rect: GMSMutablePath = GMSMutablePath.init()
        
        for i in 0...listPoint.count{
            let mDic = listPoint[i]
            
            rect.addCoordinate(CLLocationCoordinate2DMake(mDic["lat"].doubleValue , mDic["lng"].doubleValue ))
        }
        
        
        let polygon: GMSPolygon = GMSPolygon(path: rect)
        
        polygon.fillColor = convertColorWithStringWithAlpha(dicShapes["options"]!["color"].stringValue)
        
        polygon.strokeColor = UIColor.blackColor()
        
        polygon.strokeWidth = 0.7;
        polygon.map = vTmpMap.mapView_;
        
        var legendMarker: GMSMarker! = nil
        
        if let lStr = dic["c_title"] as? NSString where lStr.length > 0 {
            
            let dicLegend: NSDictionary = [
                "c_lat": dicTmp["c_lat_center"].stringValue,
                "c_lon": dicTmp["c_lng_center"].stringValue,
                "c_name": "name",
                "c_address":"c_address",
                "c_title":dicTmp["c_title"].stringValue,
                "c_description":dicTmp["c_description"].stringValue,
                "c_marker": MARKERS_TYPE.MARKER_LEGEND.rawValue ]
            
            legendMarker = GMSaddMarkerLegendMap(dicLegend)
            
        }
        
        
        arrOverlays.addObject(
            [
                "c_id": dicTmp["c_id"].stringValue,
                "shape":polygon,
                "shapeLegend": legendMarker == nil ? [] : legendMarker] )
    }
    
    
    func addPolyline(dic: NSDictionary) -> Void {
        
        let dicTmp = JSON(dic)
        
        let dicShapes = dicTmp["c_data"].dictionaryValue
        let listPoint = dicShapes["paths"]!.arrayValue
        
        
        let path: GMSMutablePath = GMSMutablePath()
        
        for i in 0...listPoint.count{
            let mDic = listPoint[i]
            
            path.addCoordinate(CLLocationCoordinate2DMake(mDic["lat"].doubleValue , mDic["lng"].doubleValue ))
        }
        
        let polyline: GMSPolyline = GMSPolyline(path: path)
        
        polyline.strokeColor = convertColorWithString(dicShapes["options"]!["color"].stringValue)
        
        polyline.strokeWidth = 1;
        polyline.geodesic = true;
        polyline.map = vTmpMap.mapView_;
        
        var legendMarker: GMSMarker! = nil
        
        if let lStr = dic["c_title"] as? NSString where lStr.length > 0 {
            
            let dicLegend: NSDictionary = [
                "c_lat": dicTmp["c_lat_center"].stringValue,
                "c_lon": dicTmp["c_lng_center"].stringValue,
                "c_name": "name",
                "c_address":"c_address",
                "c_title":dicTmp["c_title"].stringValue,
                "c_description":dicTmp["c_description"].stringValue,
                "c_marker": MARKERS_TYPE.MARKER_LEGEND.rawValue ]
            
            legendMarker = GMSaddMarkerLegendMap(dicLegend)
            
        }
        
        arrOverlays.addObject(
            [
                "c_id": dicTmp["c_id"].stringValue,
                "shape":polyline,
                "shapeLegend": legendMarker == nil ? [] : legendMarker] )
        
    }
    
    func addCircle(dic: NSDictionary) -> Void {
        let dicTmp = JSON(dic)
        
        let dicShapes = dicTmp["c_data"].dictionaryValue
        
        let coord_Shapes: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: dicShapes["center"]!["lat"].doubleValue,
                                              longitude: dicShapes["center"]!["lng"].doubleValue)
        
        let radius_Shapes = dicShapes["radius"]!.doubleValue
        
        let circ: GMSCircle = GMSCircle.init(position: coord_Shapes, radius: radius_Shapes)
        
        circ.strokeWidth = 0.7;
        
        circ.fillColor = convertColorWithStringWithAlpha(dicShapes["options"]!["color"].stringValue)
        circ.map = vTmpMap.mapView_;
        
        
        
        var legendMarker: GMSMarker! = nil
        
        if let lStr = dic["c_title"] as? NSString where lStr.length > 0 {
            
            let dicLegend: NSDictionary = [
                "c_lat": dicTmp["c_lat_center"].stringValue,
                "c_lon": dicTmp["c_lng_center"].stringValue,
                "c_name": "name",
                "c_address":"c_address",
                "c_title":dicTmp["c_title"].stringValue,
                "c_description":dicTmp["c_description"].stringValue,
                "c_marker": MARKERS_TYPE.MARKER_LEGEND.rawValue ]
            
            legendMarker = GMSaddMarkerLegendMap(dicLegend)
            
        }
        
        arrOverlays.addObject(
            [
                "c_id": dicTmp["c_id"].stringValue,
                "shape":circ,
                "shapeLegend": legendMarker == nil ? [] : legendMarker] )
        
    }
    
    
    func addRectangle(dic: NSDictionary) -> Void {
        let dicTmp = JSON(dic)
        
        let dicShapes = dicTmp["c_data"].dictionaryValue
        let listPoint = dicShapes["bounds"]!.arrayValue
        
        let rect: GMSMutablePath = GMSMutablePath.init()
        
        rect.addCoordinate(CLLocationCoordinate2DMake(listPoint[0]["lat"].doubleValue , listPoint[0]["lng"].doubleValue ))
        rect.addCoordinate(CLLocationCoordinate2DMake(listPoint[1]["lat"].doubleValue , listPoint[1]["lng"].doubleValue ))
        rect.addCoordinate(CLLocationCoordinate2DMake(listPoint[2]["lat"].doubleValue , listPoint[2]["lng"].doubleValue ))
        rect.addCoordinate(CLLocationCoordinate2DMake(listPoint[3]["lat"].doubleValue , listPoint[3]["lng"].doubleValue ))
        
        
        let polygon: GMSPolygon = GMSPolygon(path: rect)
        
        polygon.fillColor = convertColorWithStringWithAlpha(dicShapes["options"]!["color"].stringValue)
        
        polygon.strokeColor = UIColor.blackColor()
        
        polygon.strokeWidth = 0.7;
        
        polygon.map = vTmpMap.mapView_;
        
        
        
        var legendMarker: GMSMarker! = nil
        
        if let lStr = dic["c_title"] as? NSString where lStr.length > 0 {
            
            let dicLegend: NSDictionary = [
                "c_lat": dicTmp["c_lat_center"].stringValue,
                "c_lon": dicTmp["c_lng_center"].stringValue,
                "c_name": "name",
                "c_address":"c_address",
                "c_title":dicTmp["c_title"].stringValue,
                "c_description":dicTmp["c_description"].stringValue,
                "c_marker": MARKERS_TYPE.MARKER_LEGEND.rawValue ]
            
            legendMarker = GMSaddMarkerLegendMap(dicLegend)
            
        }
        
        arrOverlays.addObject(
            [
                "c_id": dicTmp["c_id"].stringValue,
                "shape":polygon,
                "shapeLegend": legendMarker == nil ? [] : legendMarker] )
        
    }
    
    
    func CarteTypeAction( ) -> Void {
        
    }
    
    //    -(IBAction)CarteTypeAction:(id)sender
    //    {
    //    CarteTypeVC *vc = [[CarteTypeVC alloc] initFromParent];
    //    vc.expectTarget = self.expectTarget;
    //
    //    [vc setMyCallback:^(NSDictionary*data){
    //
    //    int iType = [data[@"maptype"] intValue];
    //    switch (iType) {
    //    case 10:
    //    vTmpMap.mapView_.mapType = kGMSTypeNormal;
    //
    //    break;
    //    case 11:
    //    vTmpMap.mapView_.mapType = kGMSTypeSatellite;
    //    break;
    //    case 12:
    //    vTmpMap.mapView_.mapType = kGMSTypeHybrid;//
    //    break;
    //    case 13:
    //    vTmpMap.mapView_.mapType = kGMSTypeTerrain;//
    //    break;
    //
    //    default:
    //    break;
    //    }
    //    }];
    //    [vc showInVC:self];
    //    }
    //
    //     -(void)settingBlurBackGround
    //     {
    //     }
    //     -(void)hideBlurBackGround
    //     {
    //
    //     }
    //     -(void)showBlurBackGround
    //     {
    //     }
    
    
}


extension UIColor {
    convenience init(rgb: UInt32, alpha: Float) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}

