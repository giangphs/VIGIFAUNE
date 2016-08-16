//
//  ArrowView.m
//  Naturapass
//
//  Created by Giang on 1/14/16.
//  Copyright © 2016 Appsolute. All rights reserved.
//

#import "ArrowView.h"

#define kSalonUserAnnotationViewBackgroundColor [UIColor whiteColor]

#define kSalonUserAnnotationViewShadowColor [UIColor colorWithRed: (21.f/255.f) green: (23.f/255.f) blue: (22.f/255.f) alpha: 1]

//#define kSalonUserAnnotationViewShadowColor [UIColor redColor]

#define kSalonUserAnnotationViewShadowOpacity .27f

#define kSalonUserAnnotationViewShadowOffset CGSizeMake(0, 2.5f)

@implementation ArrowView

- (instancetype) initWithFrame: (CGRect) frame
{
    self = [super initWithFrame: frame];
    
    if (self)
    {
        [self setContentMode: UIViewContentModeRedraw];
        
        [self setOpaque: NO];
        
        [self setBackgroundColor: [UIColor clearColor]];
        
        [self setClipsToBounds: NO];
        
        [[self layer] setMasksToBounds: NO];
        
        [[self layer] setShadowColor: [kSalonUserAnnotationViewShadowColor CGColor]];
        
        [[self layer] setShadowOpacity: kSalonUserAnnotationViewShadowOpacity];
        
        [[self layer] setShadowOffset: kSalonUserAnnotationViewShadowOffset];
        
        [[self layer] setRasterizationScale: [[UIScreen mainScreen] scale]];
        
        [[self layer] setShouldRasterize: YES];
        
        [[self layer] setShadowPath: [[UIBezierPath bezierPathWithRect: [self bounds]] CGPath]];
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    [[self layer] setShadowPath: [[UIBezierPath bezierPathWithRect: [self bounds]] CGPath]];
}

- (void) drawRect: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    // Top left
    
    [bezierPath moveToPoint: CGPointZero];
    
    // Top right
    
    [bezierPath addLineToPoint: CGPointMake(CGRectGetWidth([self bounds]), 0)];
    
    // Bottom of the arrow
    
    [bezierPath addLineToPoint: CGPointMake((CGRectGetWidth([self bounds]) / 2), CGRectGetHeight([self bounds]))];
    
    [bezierPath closePath];
    
    CGContextAddPath(context, [bezierPath CGPath]);
    
    CGContextSetFillColorWithColor(context, [kSalonUserAnnotationViewBackgroundColor CGColor]);
    
    CGContextFillPath(context);
}

@end
