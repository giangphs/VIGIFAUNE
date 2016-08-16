//
//  MapViewAnnotation.m
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

#import "MapViewAnnotation.h"


@interface MapViewAnnotation ()

@end

@implementation MapViewAnnotation

- (instancetype) initForPublicationDictionary: (NSDictionary *) publicationDictionary
{
	NSParameterAssert(publicationDictionary);
	
	self = [super init];
	
	if (self)
	{
		_publicationDictionary = publicationDictionary;
	}
	
	return self;
}

- (MapViewAnnotationType) annotationType
{
	NSAssert(NO, @"SHOULD NOT BE CALLED");
	
	return MapViewAnnotationTypeText;
}

- (CLLocationCoordinate2D) coordinate
{
    //Mur locaation or Map location data???
    
    if ( [[self publicationDictionary][@"geolocation"] isKindOfClass: [NSDictionary class]]) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[self publicationDictionary][@"geolocation"][@"latitude"] doubleValue],
                                                                       [[self publicationDictionary][@"geolocation"][@"longitude"] doubleValue]);
        return coordinate;

    }
    
	CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([[self publicationDictionary][@"c_lat"] doubleValue],
													   [[self publicationDictionary][@"c_lon"] doubleValue]);
	return coordinate;
}

- (NSString *) title
{
    return @"datatest";
}

- (NSString *) subtitle
{
    return @"datatest";
}

@end
