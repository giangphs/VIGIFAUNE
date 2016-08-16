//
//  BaseMapUI.m
//  Naturapass
//
//  Created by Giang on 6/16/16.
//  Copyright © 2016 Appsolute. All rights reserved.
//

#import "BaseMapUI.h"

@implementation BaseMapUI

//awake from parent
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setup
{
}

-(void) updateUI
{
//    if ([self.datasource respondsToSelector:@selector(getTypeOfRequestScreen)]) {
//        iType = [self.datasource getTypeOfRequestScreen];
//        
//        switch (iType) {
//                
//            case ISCARTE:
//            {
//                [self fnAction: NO];
//            }
//                break;
//            case ISGROUP:
//            case ISLOUNGE:
//            {
//                [self fnAction: NO];
//            }
//                break;
//            case ISMUR:
//            {
//                [self fnAction: YES];
//                
//            }
//                
//            default:
//                break;
//        }
//
//    }
}

-(void) fnAction :(BOOL) isHide{
    self.btnMeteo.hidden = isHide;
    self.btnWind.hidden = isHide;
    
//    self.btnTypeMap.hidden = isHide;
    
    
    self.btnAdd.hidden = isHide;
    self.iconQuo.hidden = isHide;
    
    self.iconQui.hidden = isHide;
    self.btnQui.hidden = isHide;
    
    self.btnQuo.hidden = isHide;
    //    self.btnRadar.hidden = isHide;
    self.lbWarning1.hidden = isHide;
    self.lbWarning2.hidden = isHide;
    
    
    self.btnCarteFiltreAction.hidden = isHide;
    self.btnCarteFiltreCategory.hidden = isHide;
    
    self.warning.hidden = isHide;
    self.warningZoom.hidden = isHide;
//    self.btnFollowHeading.hidden = isHide;
    self.indicator.hidden = isHide;
    
    self.lbQui.hidden = isHide;
    self.lbQuo.hidden = isHide;
    
    self.image_Category.hidden = isHide;
    self.image_RealFilter.hidden = isHide;
}

-(void) attachToParent:(UIView*) parent
{
    [parent addSubview:self];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *mSelf = self;
    
    [parent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[mSelf]-(0)-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(mSelf)]];
    
    [parent addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mSelf]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(mSelf)]];
}

- (IBAction)doIncrease:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fnIncrease)]) {
        [self.delegate fnIncrease];
    }
}

- (IBAction)doDecrease:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fnDecrease)]) {
        [self.delegate fnDecrease];
    }
}

- (IBAction)fnTracking_CurrentPos:(id)sender {
    if ([self.delegate respondsToSelector:@selector(fnTracking_CurrentPos:)]) {
        [self.delegate fnTracking_CurrentPos];
    }
    
}

-(IBAction)CarteTypeAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CarteTypeAction:)]) {
        [self.delegate CarteTypeAction];
    }
}

-(IBAction)CarteStatusAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CarteStatusAction:)]) {
        [self.delegate CarteStatusAction:sender];
    }
    
}

-(IBAction)CarteTypeContentAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CarteTypeContentAction:)]) {
        [self.delegate CarteTypeContentAction:sender];
    }
    
}

-(IBAction)CarteVentAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CarteVentAction:)]) {
        [self.delegate CarteVentAction:sender];
    }
    
}

-(IBAction)CarteFiltreparticiantsAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CarteFiltreparticiantsAction:)]) {
        [self.delegate CarteFiltreparticiantsAction:sender];
    }
    
}

-(IBAction)CarteFiltreAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CarteFiltreAction:)]) {
        [self.delegate CarteFiltreAction:sender];
    }
    
}

-(IBAction)CarteMeteoAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(CarteMeteoAction:)]) {
        [self.delegate CarteMeteoAction:sender];
    }
    
}

- (IBAction)fnAddPublication:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(fnAddPublication:)]) {
        [self.delegate fnAddPublication:sender];
    }
}

-(IBAction)fnPrint:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(fnPrint:)]) {
        [self.delegate fnPrint:sender];
    }
    
}

@end
