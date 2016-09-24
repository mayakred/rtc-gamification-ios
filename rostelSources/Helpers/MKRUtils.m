//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRUtils.h"
#import "MKRConsts.h"


@implementation MKRUtils {

}

+ (NSString *)deviceId {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)humanReadableDate:(NSDate *)date {
    return [[self class] humanReadableDate:date cutToday:NO];
}

+ (NSString *)humanReadableDate:(NSDate *)date cutToday:(BOOL)cutToday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    [dateFormatter setDoesRelativeDateFormatting:YES];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
    
    NSString *s = [dateFormatter stringFromDate:date];
    
    if (cutToday)
    {
        NSRange range = [s rangeOfString:@"Сегодня, "];
        if (range.location != NSNotFound)
            s = [s substringFromIndex:range.length];
    }
    
    return s;
}

+ (NSString *)humanReadableTimeDate:(NSDate *)date {
    return [[self class] humanReadableTimeDate:date cutToday:NO];
}

+ (NSString *)humanReadableTimeDate:(NSDate *)date cutToday:(BOOL)cutToday {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    [dateFormatter setDoesRelativeDateFormatting:YES];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];

    NSString *s = [dateFormatter stringFromDate:date];

    if (cutToday)
    {
        NSRange range = [s rangeOfString:@"Сегодня, "];
        if (range.location != NSNotFound)
            s = [s substringFromIndex:range.length];
    }

    return s;
}

+ (NSString *)bytesToString:(NSInteger)bytes {
    NSArray *units = @[@"б",@"Кб",@"Мб",@"Гб", @"Тб"];
    NSInteger pow = MAX(0, MIN(floor(log(bytes)/log(1024)), [units count] - 1));
    double b = bytes / powf(1024, pow);
    
    return [NSString stringWithFormat:@"%.0f %@", b, units[pow]];
}

@end
