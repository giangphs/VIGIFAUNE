//
//  ASSharedTimeFormatter.h
//  Naturapass
//
//  Created by Clément Padovani on 9/27/14.
//  Copyright (c) 2014 OCSMobi - 11. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASSharedTimeFormatter : NSObject

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: yyyy-MM-dd'T'HH:mm:ssZZZZ
 */

@property (nonatomic, strong, readonly) NSDateFormatter *inputFormatter;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: dd-MM-yyyy HH:mm
 */

@property (nonatomic, strong, readonly) NSDateFormatter *outputFormatter;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: dd/MM/yyyy
 */

@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: dd-MM-yyyy H:mm
 */

@property (nonatomic, strong, readonly) NSDateFormatter *timeFormatter;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: d MMM yyyy à h:mm
 */

@property (nonatomic, strong, readonly) NSDateFormatter *outputFormatterBis;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: yyyy-M-d
 */

@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatterBis;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: dd/MM/yyyy HH:mm
 */

@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatterTer;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: d MMMM
 */

@property (nonatomic, strong, readonly) NSDateFormatter *monthFormatter;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  NSDateFormatter with date format of type: EEEE
 */

@property (nonatomic, strong, readonly) NSDateFormatter *weekDayFormatter;

/**
 *	@Author Clément Padovani, 14-09-30 08:09
 *
 *	@brief  NSDateFormatter with date format of type: EEEE d MMMM
 */

@property (nonatomic, strong, readonly) NSDateFormatter *sectionHeaderViewDateFormatter;

/**
 *	@Author Clément Padovani, 14-10-01 08:10
 *
 *	@brief  NSDateFormatter with relative formatting.
 */

@property (nonatomic, strong, readonly) NSDateFormatter *sectionHeaderViewDateRelativeFormatter;

/**
 *	@Author Clément Padovani, 14-09-30 11:09
 *
 *	@brief  NSDateFormatter with date format of type: HH:mm
 */

@property (nonatomic, strong, readonly) NSDateFormatter *timeFormatterBis;

/**
 *	@Author Clément Padovani, 14-09-29 10:09
 *
 *	@brief  Use this singleton to access the date formatters.
 *
 *	@return The shared time formatter singleton.
 */

+ (instancetype) sharedFormatter;

//#ifndef DEBUG
//
//#error "Remove me!"
//
//#endif

+ (void) checkFormatString: (NSString *) formatString forFormatter: (NSDateFormatter *) dateFormatter;

@end
