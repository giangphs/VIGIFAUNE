//
//  ImageWithCloseButton.h
//  Naturapass
//
//  Created by Giang on 7/31/15.
//  Copyright (c) 2015 Appsolute. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^clickClose)();
@interface ImageWithCloseButton : UIView
@property (nonatomic, strong) IBOutlet UIImageView *imageContent;
@property (nonatomic, copy) clickClose myCallback;
@end
