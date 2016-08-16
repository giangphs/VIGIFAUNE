//
//  NewMapAnnotationView.h
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

//#import "Config.h"
#import <SDWebImage/UIImageView+WebCache.h>

@import MapKit;

@class MapViewAnnotation;

static const CGFloat kTextMapAnnotationViewSizeWidth = 29;// 29;

static const CGFloat kTextMapAnnotationViewSizeHeight = 32;//32;



static const CGSize kTextMapAnnotationViewSize = {kTextMapAnnotationViewSizeWidth, kTextMapAnnotationViewSizeHeight};

static const CGFloat kNewMapAnnotationViewSquareSize = 45;

static const CGFloat kNewMapAnnotationViewArrowWidth = 18;

static const CGFloat kNewMapAnnotationViewArrowHeight = 9;

static const CGPoint kNewMapAnnotationViewCenterOffset = {0, (-(kNewMapAnnotationViewSquareSize + kNewMapAnnotationViewArrowHeight) / 2)};

// BIG SIZE: 222/145

// SMALL SIZE: 30/33

// 13/28

static const CGPoint kTextMapAnnotationViewSmallCenterOffset = {1.5f, -14};

static const CGPoint kTextMapAnnotationViewLargeCenterOffset = {0, -70.5f};

static const CGRect kTextMapAnnotationViewContentViewFrame = {{0, 0}, {kTextMapAnnotationViewSizeWidth, kTextMapAnnotationViewSizeHeight}};

static const CGFloat kTextMapAnnotationViewTextViewSizeWidth = 222;

static const CGFloat kTextMapAnnotationViewTextViewSizeHeight = 145;

static const CGSize kTextMapAnnotationViewTextViewSize = {kTextMapAnnotationViewTextViewSizeWidth, kTextMapAnnotationViewTextViewSizeHeight};

static const CGRect kTextMapAnnotationViewTextViewFrame = {{0, 0}, {kTextMapAnnotationViewTextViewSizeWidth, kTextMapAnnotationViewTextViewSizeHeight}};


@interface NewMapAnnotationView : MKAnnotationView
{
    float _yShadowOffset;
    
}
@property (nonatomic, strong) MapViewAnnotation *mapViewAnnotation;

@property (nonatomic, strong, readonly) UIView *backgroundView;

@property (nonatomic, strong) UIView *contentView;


@property (nonatomic, strong) UILabel *legendView;

@property (nonatomic) BOOL hidesArrow;

- (instancetype) initForMapAnnotation: (MapViewAnnotation *) mapViewAnnotation withReuseIdentifier: (NSString *) reuseIdentifier;

@end
