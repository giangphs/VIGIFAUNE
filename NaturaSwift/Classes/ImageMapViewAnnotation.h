//
//  ImageMapViewAnnotation.h
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

#import "MapViewAnnotation.h"

@interface ImageMapViewAnnotation : MapViewAnnotation

@property (nonatomic, copy, readonly) NSString *imagePath;
@property (nonatomic,assign) BOOL isResize;
@end
