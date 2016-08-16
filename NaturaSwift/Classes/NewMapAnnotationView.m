//
//  NewMapAnnotationView.m
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

#import "NewMapAnnotationView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "MapViewAnnotation.h"

#import "ArrowView.h"

//for arrow if any
#define CalloutMapAnnotationViewBottomShadowBufferSize 6.0f
#define CalloutMapAnnotationViewContentHeightBuffer 8.0f
#define CalloutMapAnnotationViewHeightAboveParent 13.0f
#define CalloutMapAnnotationViewInset 4.0f


@interface NewMapAnnotationView ()

@property (nonatomic, strong, readwrite) UIView *backgroundView;

@property (nonatomic, strong) ArrowView *arrowView;

@end

@implementation NewMapAnnotationView


- (instancetype) initForMapAnnotation: (MapViewAnnotation *) mapViewAnnotation withReuseIdentifier: (NSString *) reuseIdentifier
{
	self = [super initWithAnnotation: mapViewAnnotation reuseIdentifier: reuseIdentifier];
	
	if (self)
	{
		[self setFrame: CGRectMake(0, 0, kNewMapAnnotationViewSquareSize, kNewMapAnnotationViewSquareSize + kNewMapAnnotationViewArrowHeight)];
		
		[self setOpaque: NO];
		
		[self setBackgroundColor: [UIColor clearColor]];
		
		[self addSubview: [self backgroundView]];

        //arrow
        
        CGRect arrowFrame = CGRectMake(((kNewMapAnnotationViewSquareSize - kNewMapAnnotationViewArrowWidth) / 2), kNewMapAnnotationViewSquareSize, kNewMapAnnotationViewArrowWidth, kNewMapAnnotationViewArrowHeight+3);
        
        self.arrowView = [[ArrowView alloc] initWithFrame: arrowFrame];
        
        [self addSubview: self.arrowView];
        
        //end arrow
        
        
		[self setCanShowCallout: NO];
		
		[self setCenterOffset: kNewMapAnnotationViewCenterOffset];
	}
	
	return self;
}

- (UIView *) backgroundView
{
	if (!_backgroundView)
	{
		UIView *backgroundView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, kNewMapAnnotationViewSquareSize, kNewMapAnnotationViewSquareSize)];
		
		[backgroundView setBackgroundColor: [UIColor redColor]];
		
		[backgroundView setOpaque: YES];
		
		_backgroundView = backgroundView;
	}
	
	return _backgroundView;
}

- (void) setAnnotation: (id <MKAnnotation>) annotation
{
	[super setAnnotation: annotation];
	
	if (!annotation && [self mapViewAnnotation])
		[self setMapViewAnnotation: nil];	
}

- (void) setHidesArrow:(BOOL)hidesArrow
{
	_hidesArrow = hidesArrow;

    [[self arrowView] setHidden: _hidesArrow];

	[[self backgroundView] setOpaque: !_hidesArrow];
	
	[[self backgroundView] setHidden: _hidesArrow];
}



- (CGFloat)yShadowOffset {
    if (!_yShadowOffset) {
        float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (osVersion >= 3.2) {
            _yShadowOffset = 6;
        } else {
            _yShadowOffset = -6;
        }
        
    }
    return _yShadowOffset;
}

- (CGFloat)relativeParentXPosition {
    return self.bounds.size.width / 2;
}

@end
