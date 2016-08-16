//
//  MapViewAnnotation.h
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef NS_ENUM(NSUInteger, MapViewAnnotationType)
{
	MapViewAnnotationTypeText,
	MapViewAnnotationTypeImage,
	MapViewAnnotationTypeVideo,
    MapViewAnnotationTypeDis

};

@interface MapViewAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) MapViewAnnotationType annotationType;

@property (nonatomic, strong) NSDictionary *publicationDictionary;

- (instancetype) initForPublicationDictionary: (NSDictionary *) publicationDictionary NS_DESIGNATED_INITIALIZER;

@end
