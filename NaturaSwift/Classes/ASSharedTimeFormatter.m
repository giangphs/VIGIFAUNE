//
//  ASSharedTimeFormatter.m
//  Naturapass
//
//  Created by Clément Padovani on 9/27/14.
//  Copyright (c) 2014 OCSMobi - 11. All rights reserved.
//

#import "ASSharedTimeFormatter.h"

static ASSharedTimeFormatter *_sharedFormatter = nil;

@interface ASSharedTimeFormatter ()

@property (nonatomic, strong, readwrite) NSDateFormatter *inputFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *outputFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *dateFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *timeFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *outputFormatterBis;

@property (nonatomic, strong, readwrite) NSDateFormatter *dateFormatterBis;

@property (nonatomic, strong, readwrite) NSDateFormatter *dateFormatterTer;

@property (nonatomic, strong, readwrite) NSDateFormatter *monthFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *weekDayFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *sectionHeaderViewDateFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *sectionHeaderViewDateRelativeFormatter;

@property (nonatomic, strong, readwrite) NSDateFormatter *timeFormatterBis;

@end

@implementation ASSharedTimeFormatter

+ (instancetype) sharedFormatter
{
	NSAssert([NSThread isMainThread], @"Not main thread! Thread: %@", [NSThread currentThread]);
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedFormatter = [[self alloc] initInStyle];
	});
	
	return _sharedFormatter;
}

- (instancetype) initInStyle
{
	self = [super init];
	
	if (self)
	{
		
	}
	
	return self;
}

- (instancetype) init
{
	NSAssert(NO, @"DON'T CALL ME!");
	
	self = [super init];
	
	if (self)
	{
		
	}
	
	return self;
}

// TODO: Ask Mathieu about lazy-init; if it's better to set the the ivar or the property

- (NSDateFormatter *) inputFormatter
{
	if (!_inputFormatter)
	{
		NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
		
		[inputFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[inputFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[inputFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ssZZZZ"];

		_inputFormatter = inputFormatter;
	}
	
	return _inputFormatter;
}

- (NSDateFormatter *) outputFormatter
{
	if (!_outputFormatter)
	{
		NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
		
		[outputFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[outputFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[outputFormatter setDateFormat: @"dd-MM-yyyy HH:mm"];
		
		_outputFormatter = outputFormatter;
	}
	
	return _outputFormatter;
}

- (NSDateFormatter *) dateFormatter
{
	if (!_dateFormatter)
	{
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		
		[dateFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[dateFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[dateFormatter setDateFormat: @"dd/MM/yyyy"];
		
		_dateFormatter = dateFormatter;
	}
	
	return _dateFormatter;
}

- (NSDateFormatter *) timeFormatter
{
	if (!_timeFormatter)
	{
		NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
		
		[timeFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[timeFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[timeFormatter setDateFormat: @"dd-MM-yyyy H:mm"];

		_timeFormatter = timeFormatter;
	}
	
	return _timeFormatter;
}

- (NSDateFormatter *) outputFormatterBis
{
	if (!_outputFormatterBis)
	{
		NSDateFormatter *outputFormatterBis = [[NSDateFormatter alloc] init];
		
		[outputFormatterBis setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[outputFormatterBis setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[outputFormatterBis setDateFormat: @"d MMM yyyy à H:mm"];

		_outputFormatterBis = outputFormatterBis;
	}
	
	return _outputFormatterBis;
}

- (NSDateFormatter *) dateFormatterBis
{
	if (!_dateFormatterBis)
	{
		NSDateFormatter *dateFormatterBis = [[NSDateFormatter alloc] init];
		
		[dateFormatterBis setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[dateFormatterBis setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[dateFormatterBis setDateFormat: @"d MMM yyy"];
		
		_dateFormatterBis = dateFormatterBis;
	}
	
	return _dateFormatterBis;
}

- (NSDateFormatter *) dateFormatterTer
{
	if (!_dateFormatterTer)
	{
		NSDateFormatter *dateFormatterTer = [[NSDateFormatter alloc] init];
		
		[dateFormatterTer setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[dateFormatterTer setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[dateFormatterTer setDateFormat: @"dd/MM/yyyy HH:mm"];
		
		_dateFormatterTer = dateFormatterTer;
	}
	
	return _dateFormatterTer;
}

- (NSDateFormatter *) monthFormatter
{
	if (!_monthFormatter)
	{
		NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
		
		[monthFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[monthFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[monthFormatter setDateFormat: @"d MMMM"];

		_monthFormatter = monthFormatter;
	}
	
	return _monthFormatter;
}

- (NSDateFormatter *) weekDayFormatter
{
	if (!_weekDayFormatter)
	{
		NSDateFormatter *weekDayFormatter = [[NSDateFormatter alloc] init];
		
		[weekDayFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[weekDayFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[weekDayFormatter setDateFormat: @"EEEE"];
		
		_weekDayFormatter = weekDayFormatter;
	}
	
	return _weekDayFormatter;
}

- (NSDateFormatter *) sectionHeaderViewDateFormatter
{
	if (!_sectionHeaderViewDateFormatter)
	{
		NSDateFormatter *sectionHeaderViewDateFormatter = [[NSDateFormatter alloc] init];
		
		[sectionHeaderViewDateFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[sectionHeaderViewDateFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[sectionHeaderViewDateFormatter setDateFormat: @"EEEE d MMMM"];
		
		_sectionHeaderViewDateFormatter = sectionHeaderViewDateFormatter;
	}
	
	return _sectionHeaderViewDateFormatter;
}

- (NSDateFormatter *) sectionHeaderViewDateRelativeFormatter
{
	if (!_sectionHeaderViewDateRelativeFormatter)
	{
		NSDateFormatter *sectionHeaderViewDateRelativeFormatter = [[NSDateFormatter alloc] init];
		
		[sectionHeaderViewDateRelativeFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[sectionHeaderViewDateRelativeFormatter setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[sectionHeaderViewDateRelativeFormatter setTimeStyle: NSDateFormatterNoStyle];
		
		[sectionHeaderViewDateRelativeFormatter setDateStyle: NSDateFormatterShortStyle];
		
		[sectionHeaderViewDateRelativeFormatter setDoesRelativeDateFormatting: YES];
		
		_sectionHeaderViewDateRelativeFormatter = sectionHeaderViewDateRelativeFormatter;
	}
	
	return _sectionHeaderViewDateRelativeFormatter;
}

- (NSDateFormatter *) timeFormatterBis
{
	if (!_timeFormatterBis)
	{
		NSDateFormatter *timeFormatterBis = [[NSDateFormatter alloc] init];
		
		[timeFormatterBis setLocale: [NSLocale localeWithLocaleIdentifier: @"fr_FR"]];
		
		[timeFormatterBis setTimeZone: [NSTimeZone timeZoneWithName: @"Europe/Paris"]];
		
		[timeFormatterBis setDateFormat: @"HH:mm"];
		
		_timeFormatterBis = timeFormatterBis;
	}
	
	return _timeFormatterBis;
}

+ (void) checkFormatString: (NSString *) formatString forFormatter: (NSDateFormatter *) dateFormatter
{
	NSString *formatterFormatString = [dateFormatter dateFormat];
	
	NSAssert([formatString isEqualToString: formatterFormatString], @"ASSERT. %@ format string is supposed to be equal to %@", formatterFormatString, formatString);
}

@end
