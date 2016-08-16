//
//  DPTextField.h
//  Naturapass
//
//  Created by Manh on 8/6/15.
//  Copyright (c) 2015 Appsolute. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^callBackTFClick) ();

@interface DPTextField : UITextField
@property (nonatomic, copy) callBackTFClick CallBack;
@property (nonatomic, strong) UIDatePicker       *datePicker;

@end
