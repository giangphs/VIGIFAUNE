//
//  DBMapSelectorOverlayRenderer.m
//  DBMapSelectorViewControllerExample
//
//  Created by Denis Bogatyrev on 27.03.15.
//  Copyright (c) 2015 Denis Bogatyrev. All rights reserved.
//

#import "DBMapSelectorOverlayRenderer.h"
#import "DBMapSelectorOverlay.h"

@interface DBMapSelectorOverlayRenderer () {
    DBMapSelectorOverlay    *_selectorOverlay;
}

@end

@implementation DBMapSelectorOverlayRenderer

@synthesize fillColor = _fillColor;
@synthesize strokeColor = _strokeColor;

- (instancetype)initWithSelectorOverlay:(DBMapSelectorOverlay *)selectorOverlay {
    self = [super initWithOverlay:selectorOverlay];
    if (self) {
        _selectorOverlay = selectorOverlay;
        _fillColor = [UIColor orangeColor];
        _strokeColor = [UIColor darkGrayColor];
        [self addOverlayObserver];
    }
    return self;
}

- (void)dealloc {
    [self removeOverlayObserver];
}

#pragma mark - Observering

- (NSArray *)overlayObserverArray {
    return @[NSStringFromSelector(@selector(radius)),
             NSStringFromSelector(@selector(editingCoordinate)),
             NSStringFromSelector(@selector(editingRadius)),
             NSStringFromSelector(@selector(fillInside))];
}

- (void)addOverlayObserver {
    for (NSString *keyPath in [self overlayObserverArray]) {
        [_selectorOverlay addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)removeOverlayObserver {
    for (NSString *keyPath in [self overlayObserverArray]) {
        [_selectorOverlay removeObserver:self forKeyPath:keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isKindOfClass:[_selectorOverlay class]]) {
        if ([[self overlayObserverArray] containsObject:keyPath]) {
            [self invalidatePath];
        }
    }
}

#pragma mark - Drawing

-(CGFloat) getBarWidth
{
    CGFloat radiusAtLatitude = _selectorOverlay.radiusMapPoints ;//* MKMapPointsPerMeterAtLatitude([[self overlay] coordinate].latitude);

    MKMapPoint mpoint = MKMapPointForCoordinate([[self overlay] coordinate]);

    MKMapRect circlebounds = MKMapRectMake(mpoint.x, mpoint.y, radiusAtLatitude *2, radiusAtLatitude * 2);
    
    CGRect overlayRect = [self rectForMapRect:circlebounds];

    return CGRectGetWidth(overlayRect);
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    
    
    MKMapPoint mpoint = MKMapPointForCoordinate([[self overlay] coordinate]);
        CGFloat radiusAtLatitude = (_selectorOverlay.radiusMapPoints) * MKMapPointsPerMeterAtLatitude([[self overlay] coordinate].latitude);

    MKMapRect circlebounds = MKMapRectMake(mpoint.x, mpoint.y, radiusAtLatitude *2, radiusAtLatitude * 2);
    CGRect overlayRect = [self rectForMapRect:circlebounds];
    
//    CGRect overlayRect = [self rectForMapRect:_selectorOverlay.boundingMapRect];
    
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    CGContextSetLineWidth(context, overlayRect.size.width *.015f);
    CGContextSetShouldAntialias(context, YES);
    
    if (NO == _selectorOverlay.fillInside) {
        
        CGRect rect = [self rectForMapRect:mapRect];
        CGContextSaveGState(context);
        CGContextAddRect(context, rect);
        CGContextSetFillColorWithColor(context, [self.fillColor colorWithAlphaComponent:.2f].CGColor);
        CGContextFillRect(context, rect);
        CGContextRestoreGState(context);
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextFillEllipseInRect(context, [self rectForMapRect:[self.overlay boundingMapRect]]);
        CGContextRestoreGState(context);
    }
    
    CGContextSetFillColorWithColor(context, (_selectorOverlay.fillInside ? [self.fillColor colorWithAlphaComponent:.2f].CGColor : [UIColor clearColor].CGColor));
    CGContextAddArc(context, overlayRect.origin.x, overlayRect.origin.y, radiusAtLatitude, 0, 2 * M_PI, true);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(context, [self.fillColor colorWithAlphaComponent:.75f].CGColor);
    CGContextAddArc(context, overlayRect.origin.x, overlayRect.origin.y, radiusAtLatitude *(_selectorOverlay.editingCoordinate ? .1f : .015f), 0, 2 * M_PI, true);
    CGContextDrawPath(context, kCGPathFillStroke);
    
//    CGContextSetFillColorWithColor(context, self.strokeColor.CGColor);
//    CGContextAddArc(context, overlayRect.origin.x + radiusAtLatitude, overlayRect.origin.y, radiusAtLatitude * (_selectorOverlay.editingRadius ? .075f : .015f), 0, 2 * M_PI, true);
//    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGFloat kDashedLinesLength[] = {overlayRect.size.width * .01f, overlayRect.size.width * .01f};
    CGContextSetLineWidth(context, overlayRect.size.width *.01f);
    CGContextSetLineDash(context, .0f, kDashedLinesLength, 1.f);
    
    CGContextMoveToPoint(context, overlayRect.origin.x + (_selectorOverlay.editingCoordinate ? overlayRect.size.width * .05f : .0f), overlayRect.origin.y);
    CGContextAddLineToPoint(context, overlayRect.origin.x + overlayRect.size.width * .5f, overlayRect.origin.y);
    CGContextStrokePath(context);

    if (_selectorOverlay.shouldShowRadiusText) {
//        CGFloat fontSize = radius * zoomScale;
        
          CGFloat fontSize = 30;
//        float meter = radius/MKMapPointsPerMeterAtLatitude([[self overlay] coordinate].latitude);
        NSString *radiusStr = [self.class stringForRadius:_selectorOverlay.meter];
        CGPoint point = CGPointMake([self pointForMapPoint:mpoint].x + overlayRect.size.width * .18f, [self pointForMapPoint:mpoint].y - overlayRect.size.width * .03f);
        CGContextSetFillColorWithColor(context, self.strokeColor.CGColor);
        
        CGContextSelectFont(context, "HelveticaNeue-Bold", fontSize, kCGEncodingMacRoman);

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextSelectFont(context, "HelveticaNeue-Bold", fontSize, kCGEncodingMacRoman);
#pragma clang diagnostic pop
        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGAffineTransform xform = CGAffineTransformMake(1.0 / zoomScale, 0.0, 0.0, -1.0 / zoomScale, 0.0, 0.0);
        CGContextSetTextMatrix(context, xform);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CGContextShowTextAtPoint(context, point.x, point.y, [radiusStr cStringUsingEncoding:NSUTF8StringEncoding], radiusStr.length);
#pragma clang diagnostic pop
    }
    
    UIGraphicsPopContext();
}

+ (NSString *)stringForRadius:(float)meters {
    NSString *unit = nil;
    int maxValue = 0;

    if ( meters >= 1000.0f )
    {
        // use kilometer scale
        unit = @"km";
        
        maxValue = meters / 1000.0f;

//        static const int kKilometerScale[] = {1,2,5,10,20,50,100,200,500,1000,2000,5000,10000,20000,50000};
//        float kilometers = meters / 1000.0f;
//        
//        for ( int i = 0; i < 15; ++i )
//        {
//            if ( kilometers < kKilometerScale[i] )
//            {
//                maxValue = kKilometerScale[i-1];
//                break;
//            }
//        }
    }
    else
    {
        // use meter scale
        unit = @"m";
        
        maxValue = meters;
        
//        static const int kMeterScale[11] = {1,2,5,10,20,50,100,200,500,1000,2000};
//        
//        for ( int i = 0; i < 11; ++i )
//        {
//            if ( meters < kMeterScale[i] )
//            {
//                maxValue = kMeterScale[i-1];
//                break;
//            }
//        }
    }

    
    return [NSString stringWithFormat:@"%d %@",maxValue, unit];
}

@end
