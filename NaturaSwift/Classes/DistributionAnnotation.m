//
//  DistributionAnnotation.m
//  Naturapass
//
//  Created by Giang on 6/3/15.
//  Copyright (c) 2015 Appsolute. All rights reserved.
//

#import "DistributionAnnotation.h"

@implementation DistributionAnnotation

- (CLLocationCoordinate2D) coordinate
{

    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[self publicationDictionary][@"c_lat"] floatValue],
                                                                   [[self publicationDictionary][@"c_lon"] floatValue]);
    return coordinate;
}

- (NSString *) title
{
    return [self publicationDictionary][@"c_name"] ;
}

- (NSString *) subtitle
{
    return [self publicationDictionary][@"c_address"];
}

//important
- (MapViewAnnotationType) annotationType
{
    return MapViewAnnotationTypeDis;
}

@end