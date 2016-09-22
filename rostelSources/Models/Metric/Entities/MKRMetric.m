//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetric.h"
#import <RestKit/RestKit.h>

@implementation MKRMetric {

}


+ (RKObjectMapping *)mapping {
    RKObjectMapping *metricMapping = [RKObjectMapping mappingForClass:[self class]];
    [metricMapping addAttributeMappingsFromDictionary:@{
            @"code"       : @"code",
            @"name"       : @"name",
            @"unit_type"  : @"unitType",
    }];
    return metricMapping;
}

//+ (NSString *)primaryKey {
//    return @"original";
//}


@end