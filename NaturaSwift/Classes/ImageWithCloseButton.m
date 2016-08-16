//
//  ImageWithCloseButton.m
//  Naturapass
//
//  Created by Giang on 7/31/15.
//  Copyright (c) 2015 Appsolute. All rights reserved.
//

#import "ImageWithCloseButton.h"

@implementation ImageWithCloseButton
- (void)awakeFromNib {
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSArray *loadedViews = [mainBundle loadNibNamed:@"ImageWithCloseButton" owner:self options:nil];
    ImageWithCloseButton *loadedSubview = [loadedViews firstObject];
    
    [self addSubview:loadedSubview];
    
    loadedSubview.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeTop]];
    [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeLeft]];
    [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeBottom]];
    [self addConstraint:[self pin:loadedSubview attribute:NSLayoutAttributeRight]];
    
}

- (NSLayoutConstraint *)pin:(id)item attribute:(NSLayoutAttribute)attribute
{
    return [NSLayoutConstraint constraintWithItem:self
                                        attribute:attribute
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:item
                                        attribute:attribute
                                       multiplier:1.0
                                         constant:0.0];
}

- (IBAction)onClose:(id)sender {
    if (self.myCallback) {
        self.myCallback ();
    }
}

@end
