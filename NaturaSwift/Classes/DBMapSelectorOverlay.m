//
//  DBMapSelectorOverlay.m
//  DBMapSelectorViewControllerExample
//
//  Created by Denis Bogatyrev on 27.03.15.
//  Copyright (c) 2015 Denis Bogatyrev. All rights reserved.
//

#import "DBMapSelectorOverlay.h"
#import <MapKit/MapKit.h>

@implementation DBMapSelectorOverlay

@synthesize boundingMapRect = _boundingMapRect;

- (instancetype)initWithCenterCoordinate:(CLLocationCoordinate2D)coordinate radius:(CLLocationDistance)radius meter:(double)meter{
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _radiusMapPoints = radius;
        _meter = meter;
        _boundingMapRect = [self MKMapRectForCoordinate:_coordinate radius:_radiusMapPoints];
        _editingCoordinate = YES;
        _editingRadius = YES;
        _fillInside = YES;
        _shouldShowRadiusText = YES;
    }
    return self;
}

#pragma mark - Accessor

- (void)setCoordinate:(CLLocationCoordinate2D)coordinate {
    if ((_coordinate.latitude != coordinate.latitude) || (_coordinate.longitude != coordinate.longitude)) {
        _coordinate = coordinate;
        _boundingMapRect = [self MKMapRectForCoordinate:_coordinate radius:_radiusMapPoints];
    }
}

- (void)setRadius:(CLLocationDistance)radius {
    if (_radiusMapPoints != radius) {
        _radiusMapPoints = radius;
        _boundingMapRect = [self MKMapRectForCoordinate:_coordinate radius:_radiusMapPoints];
    }
}

#pragma mark - Additional

- (MKMapRect)MKMapRectForCoordinate:(CLLocationCoordinate2D)coordinate radius:(CLLocationDistance)radius {
    MKCoordinateRegion r = MKCoordinateRegionMakeWithDistance(coordinate, radius *2.f, radius *2.f);
    MKMapPoint a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(r.center.latitude + r.span.latitudeDelta *.5f, r.center.longitude - r.span.longitudeDelta *.5f));
    MKMapPoint b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(r.center.latitude - r.span.latitudeDelta *.5f, r.center.longitude + r.span.longitudeDelta *.5f));
    return MKMapRectMake(MIN(a.x,b.x), MIN(a.y,b.y), ABS(a.x-b.x), ABS(a.y-b.y));
}

@end
