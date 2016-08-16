//
//  ImageMapViewAnnotation.m
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

#import "ImageMapViewAnnotation.h"

@implementation ImageMapViewAnnotation

- (NSString *) title
{
        return @"datatest";
}

- (NSString *) subtitle
{
    return @"datatest";
}

- (NSString *) imagePath
{
	return [self publicationDictionary][@"media"][@"path"];
}

- (MapViewAnnotationType) annotationType
{
	return MapViewAnnotationTypeImage;
}

@end
