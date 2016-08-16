//
//  ImageMapAnnotationView.h
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

#import "NewMapAnnotationView.h"

@class ImageMapViewAnnotation;

@interface ImageMapAnnotationView : NewMapAnnotationView

@property (nonatomic, strong) ImageMapViewAnnotation *mapViewAnnotation;

- (instancetype) initForImageMapViewAnnotation: (ImageMapViewAnnotation *) imageMapAnnotation NS_DESIGNATED_INITIALIZER;

@end
