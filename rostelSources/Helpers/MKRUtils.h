//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MKRUtils : NSObject

+ (NSString *)deviceId;

+ (NSString *)humanReadableDate:(NSDate *)date;
+ (NSString *)humanReadableDate:(NSDate *)date cutToday:(BOOL)cutToday;


+ (NSString *)humanReadableTimeDate:(NSDate *)date;

+ (NSString *)humanReadableTimeDate:(NSDate *)date cutToday:(BOOL)cutToday;

+ (NSString *)bytesToString:(NSInteger)bytes;

@end
