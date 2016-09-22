//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDepartment.h"
#import <RestKit/RestKit.h>

@implementation MKRDepartment {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *departmentMapping = [RKObjectMapping mappingForClass:[self class]];
    [departmentMapping addAttributeMappingsFromDictionary:@{
            @"id"    : @"itemId",
            @"code"  : @"code",
            @"name"  : @"name",
    }];
    return departmentMapping;
}

@end