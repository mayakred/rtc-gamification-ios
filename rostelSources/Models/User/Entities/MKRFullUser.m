//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRFullUser.h"
#import <RestKit/RestKit.h>

@implementation MKRFullUser {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *userMapping = [MKRFullUser mappingForClass:[self class]];
    [userMapping addAttributeMappingsFromDictionary:@{
            @"phone"             : @"phone",
    }];
    return userMapping;

}

@end