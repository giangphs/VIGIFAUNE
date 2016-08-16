//
//  LXMapScaleView.m
//
//  Created by Tamas Lustyik on 2012.01.09..
//  Copyright (c) 2012 LKXF. All rights reserved.
//

#import "LXMapScaleView_Google.h"


static const CGRect kDefaultViewRect = {{0,0},{160,30}};
static const CGFloat kMinimumWidth = 100.0f;
static const UIEdgeInsets kDefaultPadding = {10,10,10,10};

@interface LXMapScaleView_Google ()
{
	UIView* mapView;
	UILabel* zeroLabel;
	UILabel* maxLabel;
	UILabel* unitLabel;
	CGFloat scaleWidth;
    
    NSUInteger maxValue;
    NSString* unit;
    

}

- (void)constructLabels;

@end



@implementation LXMapScaleView_Google

@synthesize style;
@synthesize metric;
@synthesize position;
@synthesize padding;
@synthesize maxWidth;



// -----------------------------------------------------------------------------
// LXMapScaleView::initWithMapView:
// -----------------------------------------------------------------------------
- (id)initWithMapView:(UIView*)aMapView
{
	if ( (self = [super initWithFrame:kDefaultViewRect]) )
	{
		self.opaque = NO;
		self.clipsToBounds = YES;
		self.userInteractionEnabled = NO;
        maxValue = 0;
        unit = @"";

		mapView = aMapView;
		metric = YES;
		style = kLXMapScaleStyleBar;
		position = kLXMapScalePositionBottomLeft;
		padding = kDefaultPadding;
		maxWidth = kDefaultViewRect.size.width;
		
		[self constructLabels];
		
		[aMapView addSubview:self];
	}
	
	return self;
}


// -----------------------------------------------------------------------------
// LXMapScaleView::constructLabels
// -----------------------------------------------------------------------------
- (void)constructLabels
{
	UIFont* font = [UIFont systemFontOfSize:12.0f];
//	zeroLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 8, 10)];
//	zeroLabel.backgroundColor = [UIColor clearColor];
//	zeroLabel.textColor = [UIColor whiteColor];
//	zeroLabel.shadowColor = [UIColor blackColor];
//	zeroLabel.shadowOffset = CGSizeMake(1, 1);
//	zeroLabel.text = @"0";
//	zeroLabel.font = font;
//	[self addSubview:zeroLabel];
	
	maxLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 20, 10)];
	maxLabel.backgroundColor = [UIColor clearColor];
	maxLabel.textColor = [UIColor whiteColor];
	maxLabel.shadowColor = [UIColor blackColor];
	maxLabel.shadowOffset = CGSizeMake(1, 1);
	maxLabel.text = @"1";
	maxLabel.font = font;
	maxLabel.textAlignment = NSTextAlignmentRight;
	[self addSubview:maxLabel];
	
	unitLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 18, 10)];
	unitLabel.backgroundColor = [UIColor clearColor];
	unitLabel.textColor = [UIColor whiteColor];
	unitLabel.shadowColor = [UIColor blackColor];
	unitLabel.shadowOffset = CGSizeMake(1, 1);
	unitLabel.text = @"m";
	unitLabel.font = font;
	[self addSubview:unitLabel];
}

-(void) hideShowLabel:(BOOL) isHide
{
    zeroLabel.hidden = isHide;
    maxLabel.hidden = isHide;
    unitLabel.hidden = isHide;
}

// -----------------------------------------------------------------------------
// LXMapScaleView::update
// -----------------------------------------------------------------------------
- (void)update:(float)meters
{
	if ( !mapView || !mapView.bounds.size.width)
	{
		return;
	}
	
//	CLLocationDistance horizontalDistance = MKMetersPerMapPointAtLatitude(mapView.centerCoordinate.latitude);
//	float metersPerPixel = mapView.visibleMapRect.size.width * horizontalDistance;
//	
//	CGFloat maxScaleWidth = maxWidth-40;
    
//    float meters = maxScaleWidth*metersPerPixel;

		
		if ( meters >= 1000.0f )
		{
            maxValue = meters / 1000.0f;
			// use kilometer scale
			unit = @"km";
		}
		else
		{
			// use meter scale
			unit = @"m";
            maxValue = meters;
		}

    self.iViewLevel = (int)meters;//metter
}

-(void) reloadBar:(CGFloat) width
{
    scaleWidth = width;
    
    maxLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)maxValue];
    unitLabel.text = unit;
    
    [self layoutSubviews];
}

// -----------------------------------------------------------------------------
// LXMapScaleView::setFrame:
// -----------------------------------------------------------------------------
- (void)setFrame:(CGRect)aFrame
{
	[self setMaxWidth:aFrame.size.width];
}


// -----------------------------------------------------------------------------
// LXMapScaleView::setBounds:
// -----------------------------------------------------------------------------
- (void)setBounds:(CGRect)aBounds
{
	[self setMaxWidth:aBounds.size.width];
}


// -----------------------------------------------------------------------------
// LXMapScaleView::setMaxWidth:
// -----------------------------------------------------------------------------
- (void)setMaxWidth:(CGFloat)aMaxWidth
{
	if ( maxWidth != aMaxWidth && aMaxWidth >= kMinimumWidth )
	{
		maxWidth = aMaxWidth;
		
		[self setNeedsLayout];
	}
}


// -----------------------------------------------------------------------------
// LXMapScaleView::setAlpha:
// -----------------------------------------------------------------------------
- (void)setAlpha:(CGFloat)aAlpha
{
	[super setAlpha:aAlpha];
	zeroLabel.alpha = aAlpha;
	maxLabel.alpha = aAlpha;
	unitLabel.alpha = aAlpha;
}


// -----------------------------------------------------------------------------
// LXMapScaleView::setStyle:
// -----------------------------------------------------------------------------
- (void)setStyle:(LXMapScaleStyle)aStyle
{
	if ( style != aStyle )
	{
		style = aStyle;
		
		[self setNeedsDisplay];
	}
}


// -----------------------------------------------------------------------------
// LXMapScaleView::setPosition:
// -----------------------------------------------------------------------------
- (void)setPosition:(LXMapScalePosition)aPosition
{
	if ( position != aPosition )
	{
		position = aPosition;

		[self setNeedsLayout];
	}
}


// -----------------------------------------------------------------------------
// LXMapScaleView::setMetric:
// -----------------------------------------------------------------------------
//- (void)setMetric:(BOOL)aIsMetric
//{
//	if ( metric != aIsMetric )
//	{
//		metric = aIsMetric;
//		
//		[self update];
//	}
//}


// -----------------------------------------------------------------------------
// LXMapScaleView::layoutSubviews
// -----------------------------------------------------------------------------
- (void)layoutSubviews
{
//    self.center = mapView.center;

	CGSize maxLabelSize = [maxLabel.text sizeWithFont:maxLabel.font];

    
	maxLabel.frame = CGRectMake((scaleWidth  - maxLabelSize.width)/2,
                                
								0, 
								maxLabelSize.width+1,
								maxLabel.frame.size.height);
	
	CGSize unitLabelSize = unitLabel.frame.size;
	unitLabel.frame = CGRectMake(CGRectGetMaxX(maxLabel.frame),
								 0,
								 unitLabelSize.width,
								 unitLabelSize.height);
    
    CGRect rectTemp= CGRectMake(zeroLabel.frame.size.width/2.0f+1+scaleWidth+1 - (maxLabelSize.width+1)/2.0f,
                                
                                0,
                                maxLabelSize.width+1,
                                maxLabel.frame.size.height);
    CGRect rectTempUnit= CGRectMake(CGRectGetMaxX(rectTemp),
                                    0,
                                    unitLabelSize.width,
                                    unitLabelSize.height);

	CGSize mapSize = mapView.bounds.size;
	CGRect frame = self.bounds;
	frame.size.width = CGRectGetMaxX(rectTempUnit) - CGRectGetMinX(zeroLabel.frame);
	/*
	switch (position)
	{
		case kLXMapScalePositionTopLeft:
		{
			frame.origin = CGPointMake(padding.left,
									   padding.top);
			self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
			break;
		}
			
		case kLXMapScalePositionTop:
		{
			frame.origin = CGPointMake((mapSize.width - frame.size.width) / 2.0f,
									   padding.top);
			self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;
			break;
		}
			
		case kLXMapScalePositionTopRight:
		{
			frame.origin = CGPointMake(mapSize.width - padding.right - frame.size.width,
									   padding.top);
			self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
			break;
		}
			
		default:
		case kLXMapScalePositionBottomLeft:
		{
			frame.origin = CGPointMake(padding.left,
									   mapSize.height - padding.bottom - frame.size.height);
			self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
			break;
		}
			
		case kLXMapScalePositionBottom:
		{
			frame.origin = CGPointMake((mapSize.width - frame.size.width) / 2.0f,
									   mapSize.height - padding.bottom - frame.size.height);
			self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
			break;
		}
			
		case kLXMapScalePositionBottomRight:
		{
			frame.origin = CGPointMake(mapSize.width - padding.right - frame.size.width,
									   mapSize.height - padding.bottom - frame.size.height);
			self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin;
			break;
		}
	}
	*/
    if (position == kLXMapScalePositionBottomRight) {
        frame.origin = CGPointMake(mapSize.width+20- frame.size.width,
                                  mapSize.height+5- frame.size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
        super.frame = frame;
    }
    else
    {
        frame.origin = CGPointMake( (mapView.frame.size.width - frame.size.width)/2, mapSize.height - 40 - frame.size.height);

//        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleBottomMargin;

        
        super.frame = frame;

    }
	[self setNeedsDisplay];
}


// -----------------------------------------------------------------------------
// LXMapScaleView::drawRect:
// -----------------------------------------------------------------------------
- (void)drawRect:(CGRect)aRect
{
	if ( !mapView || (scaleWidth == 0))
	{
		return;
	}

	CGContextRef ctx = UIGraphicsGetCurrentContext();

	{
		CGRect scaleRect = CGRectMake(4, 12, scaleWidth, 3);
		
		[[UIColor blackColor] setFill];
		CGContextFillRect(ctx, CGRectInset(scaleRect, -1, -1));
		
		[[UIColor whiteColor] setFill];
		CGRect unitRect = scaleRect;
		unitRect.size.width = scaleWidth/5.0f;
		
		for ( int i = 0; i < 5; i+=2 )
		{
			unitRect.origin.x = scaleRect.origin.x + unitRect.size.width*i;
			CGContextFillRect(ctx, unitRect);
		}
	}

}


@end

