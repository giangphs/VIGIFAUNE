//
//  ImageMapAnnotationView.m
//  Naturapass
//
//  Created by Clément Padovani on 10/21/14.
//  Copyright (c) 2014 Appsolute. All rights reserved.
//

#import "ImageMapAnnotationView.h"

#import "ImageMapViewAnnotation.h"
//#import "ASImageView.h"

#import "Config.h"
//ggtt

@interface ImageMapAnnotationView ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ImageMapAnnotationView
{
    int sizeLegend;
    BOOL isResize;
}
@synthesize contentView = _contentView;
@synthesize legendView = _legendView;

- (instancetype) initForImageMapViewAnnotation: (ImageMapViewAnnotation *) imageMapAnnotation
{
    NSParameterAssert(imageMapAnnotation);
    
    NSAssert([imageMapAnnotation isKindOfClass: [ImageMapViewAnnotation class]], @"Annotation is wrong kind of class (%@): %@", NSStringFromClass([imageMapAnnotation class]), imageMapAnnotation);
    
    self = [super initForMapAnnotation: imageMapAnnotation withReuseIdentifier: NSStringFromClass([self class])];
    
    if (self)
    {
        CGRect selfFrame = [self frame];
        if (imageMapAnnotation.isResize) {
            selfFrame.size = CGSizeMake(8, 10);
        }
        else
        {
            selfFrame.size = kTextMapAnnotationViewSize;
        }
        
        
        [self setFrame: selfFrame];
        
        [self setCenterOffset: kTextMapAnnotationViewSmallCenterOffset];
        
        [self setCanShowCallout: NO];
        
        [self setHidesArrow: YES];
        
        [self setMapViewAnnotation: imageMapAnnotation];
        
        
        //content view
        UIImageView *contentView = nil;
        isResize= imageMapAnnotation.isResize;
        if (imageMapAnnotation.isResize) {
            contentView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 8, 10)];
            sizeLegend =6;
        }
        else
        {
            contentView = [[UIImageView alloc] initWithFrame: kTextMapAnnotationViewContentViewFrame];
            sizeLegend =11;
        }
        _contentView = contentView;
        [self addSubview: _contentView];
        
        [self viewImage];
        
        //legend
        
        if ( [self.mapViewAnnotation.publicationDictionary[@"geolocation"] isKindOfClass: [NSDictionary class]]) {
            if (![self.mapViewAnnotation.publicationDictionary[@"legend"] isKindOfClass:[NSNull class]] && ![self.mapViewAnnotation.publicationDictionary[@"legend"] isEqualToString:@""] )
            {
                UILabel *lb = [[UILabel alloc] init];
                lb.backgroundColor = [UIColor whiteColor];
                lb.textAlignment = NSTextAlignmentCenter;
                lb.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:sizeLegend];
                
                self.legendView = lb;
                [self addSubview:self.legendView];
                
                [self buildLegend];
            }

        }else{
            if (![self.mapViewAnnotation.publicationDictionary[@"c_legend"] isKindOfClass:[NSNull class]] && ![self.mapViewAnnotation.publicationDictionary[@"c_legend"] isEqualToString:@""] )
            {
                UILabel *lb = [[UILabel alloc] init];
                lb.backgroundColor = [UIColor whiteColor];
                lb.textAlignment = NSTextAlignmentCenter;
                lb.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:sizeLegend];//11
                
                self.legendView = lb;
                [self addSubview:self.legendView];
                
                [self buildLegend];
            }
        }
        

    }
    
    return self;
}

- (CGFloat)widthOfString:(NSString *)string withFont:(UIFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size].width;
}

-(void) buildLegend
{
    if (self.legendView == nil)
    {
        UILabel *lb = [[UILabel alloc] init];
//        lb.backgroundColor = [UIColor whiteColor];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:sizeLegend];
        self.legendView = lb;
        [self addSubview:self.legendView];
    }
    
    
    
    if ( [self.mapViewAnnotation.publicationDictionary[@"geolocation"] isKindOfClass: [NSDictionary class]]) {
        if ( ![self.mapViewAnnotation.publicationDictionary[@"legend"]  isKindOfClass:[NSNull class]]  && ![self.mapViewAnnotation.publicationDictionary[@"legend"] isEqualToString:@""] )
        {
            self.legendView.text = self.mapViewAnnotation.publicationDictionary[@"legend"];
        }
    }
    if (![self.mapViewAnnotation.publicationDictionary[@"c_legend"] isKindOfClass:[NSNull class]] && ![self.mapViewAnnotation.publicationDictionary[@"c_legend"] isEqualToString:@""] )
    {
        self.legendView.text = self.mapViewAnnotation.publicationDictionary[@"c_legend"];
    }
    if (self.legendView.text) {
        CGFloat fWidth = [self widthOfString:self.legendView.text withFont:self.legendView.font] + 6;
        if (isResize) {
            self.legendView.frame  = CGRectMake( 7, 0, fWidth-4, 8);

        }
        else
        {
            self.legendView.frame  = CGRectMake( 26, 5, fWidth, 15);

        }
    }
}

/*
 "mobile_markers" =             {
 photo = "/uploads/gmap/marker/mobile/green_carre_map_icon_text.png";
 picto = "/uploads/gmap/marker/mobile/green_carre_map_icon_text.png";
 };
 */

-(void) viewImage
{
    NSString *photoDefault = @"";
    
    if ( [self.mapViewAnnotation.publicationDictionary[@"geolocation"] isKindOfClass: [NSDictionary class]]) {

        
        if ( [self.mapViewAnnotation.publicationDictionary[@"owner"][@"id"] intValue] == [[[NSUserDefaults standardUserDefaults] valueForKey:@"sender_id"] intValue]) {
            //My publication
            photoDefault = @"green_circle_map_icon_photo";
        }else{
            //Other one
            photoDefault = @"green_carre_map_icon_photo";
        }
        NSString * strImage=[NSString stringWithFormat:@"%@%@",IMAGE_ROOT_API,self.mapViewAnnotation.publicationDictionary[@"markers"][@"picto"]];
        
        [(UIImageView*)_contentView sd_setImageWithURL: [NSURL URLWithString:strImage ] placeholderImage:[UIImage imageNamed:photoDefault] ];
    }
    else
    {
        
        if ( [self.mapViewAnnotation.publicationDictionary[@"c_owner_id"] intValue] == [[[NSUserDefaults standardUserDefaults] valueForKey:@"sender_id"] intValue]) {
            //My publication
            photoDefault = @"green_circle_map_icon_photo";
        }else{
            //Other one
            photoDefault = @"green_carre_map_icon_photo";
        }
        NSString * strImage=[NSString stringWithFormat:@"%@%@",IMAGE_ROOT_API,self.mapViewAnnotation.publicationDictionary[@"c_marker_picto"]];
        
        [(UIImageView*)_contentView sd_setImageWithURL: [NSURL URLWithString:strImage ] placeholderImage:[UIImage imageNamed:photoDefault] ];
    }
}

- (void) setMapViewAnnotation: (ImageMapViewAnnotation *) mapViewAnnotation
{
    [super setMapViewAnnotation: mapViewAnnotation];
    
    [self viewImage];
    
    if (  (![self.mapViewAnnotation.publicationDictionary[@"c_legend"] isKindOfClass:[NSNull class]] && ![self.mapViewAnnotation.publicationDictionary[@"c_legend"] isEqualToString:@""] ) ||
             ( ![self.mapViewAnnotation.publicationDictionary[@"legend"] isKindOfClass:[NSNull class]] && ![self.mapViewAnnotation.publicationDictionary[@"legend"] isEqualToString:@""]) )
    {
        [self buildLegend];
    }
    else
    {
        self.legendView.frame = CGRectZero;
        self.legendView.text = @"";
        [self.legendView removeFromSuperview];
        
        self.legendView = nil;
    }
}

@end
