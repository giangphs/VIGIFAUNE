//
//  BaseMapUI.h
//  Naturapass
//
//  Created by Giang on 6/16/16.
//  Copyright © 2016 Appsolute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
//#import "BaseVC.h"

@protocol BaseMapUIDelegate<NSObject>

-(IBAction)fnIncrease;
-(IBAction)fnDecrease;
-(IBAction)fnTracking_CurrentPos;
-(IBAction)CarteTypeAction;

@optional
-(IBAction)CarteStatusAction:(id)sender;
-(IBAction)CarteTypeContentAction:(id)sender;
-(IBAction)CarteVentAction:(id)sender;
-(IBAction)CarteFiltreparticiantsAction:(id)sender;
-(IBAction)CarteFiltreAction:(id)sender;
-(IBAction)CarteMeteoAction:(id)sender;
- (IBAction)fnAddPublication:(id)sender;
-(IBAction)fnPrint:(id)sender;

@end

@protocol BaseMapUIDatasource<NSObject>
//    -(ISSCREEN) getTypeOfRequestScreen;

@end

@interface BaseMapUI : UIView
{
//    ISSCREEN iType;
}
//@property (nonatomic,strong) BaseVC *myParentVC;

@property (nonatomic,strong) id<BaseMapUIDelegate> delegate;
@property (nonatomic,strong) id<BaseMapUIDatasource> datasource;

@property (weak, nonatomic) IBOutlet UIView *viewBlur;
@property (nonatomic,strong) IBOutlet  GMSMapView *mapView_;
@property (weak, nonatomic) IBOutlet UIButton *btnZoomIn;
@property (weak, nonatomic) IBOutlet UIButton *btnZoomOUt;
@property (weak, nonatomic) IBOutlet UIButton *btnMeteo;
@property (weak, nonatomic) IBOutlet UIButton *btnWind;
@property (weak, nonatomic) IBOutlet UIButton *btnTypeMap;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIImageView *iconQuo;
@property (weak, nonatomic) IBOutlet UIImageView *iconQui;
@property (weak, nonatomic) IBOutlet UIButton *btnQui;
@property (weak, nonatomic) IBOutlet UIButton *btnQuo;
@property (weak, nonatomic) IBOutlet UIButton *btnRadar;
@property (weak, nonatomic) IBOutlet UILabel *lbWarning1;
@property (weak, nonatomic) IBOutlet UILabel *lbWarning2;
@property (weak, nonatomic) IBOutlet UIButton *btnPrint;

@property(nonatomic,strong) IBOutlet UIButton *btnCarteFiltreAction;
@property(nonatomic,strong) IBOutlet UIButton *btnCarteFiltreCategory;

@property (nonatomic,strong) IBOutlet UILabel *warning;
@property (nonatomic,strong) IBOutlet UILabel *warningZoom;
@property (nonatomic,strong) IBOutlet UIButton *btnFollowHeading;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *indicator;

@property (nonatomic,strong) IBOutlet UILabel* lbQui;
@property (weak, nonatomic) IBOutlet UILabel *lbQuo;

@property (weak, nonatomic) IBOutlet UIImageView *image_Category;
@property (weak, nonatomic) IBOutlet UIImageView *image_RealFilter;

-(void) updateUI;

-(void) attachToParent:(UIView*) parent;
@end
