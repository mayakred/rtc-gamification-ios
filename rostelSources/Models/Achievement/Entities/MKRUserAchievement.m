//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUserAchievement.h"
#import <RestKit/RestKit.h>

@implementation MKRUserAchievement {

}


+ (RKObjectMapping *)mapping {
    RKObjectMapping *uachMapping = [RKObjectMapping mappingForClass:[self class]];
    [uachMapping addAttributeMappingsFromDictionary:@{
            @"id"              : @"itemId",
            @"current_value"   : @"currentValue",
    }];
    RKRelationshipMapping *achMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"achievement" toKeyPath:@"achievement" withMapping:[MKRAchievement mapping]];
    [uachMapping addPropertyMapping:achMapping];
    return uachMapping;
}


@end