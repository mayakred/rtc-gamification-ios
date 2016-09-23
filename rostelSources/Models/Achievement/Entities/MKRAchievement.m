//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRAchievement.h"
#import <RestKit/RestKit.h>

@implementation MKRAchievement {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *achMapping = [RKObjectMapping mappingForClass:[self class]];
    [achMapping addAttributeMappingsFromDictionary:@{
            @"id"              : @"itemId",
            @"name"            : @"name",
    }];
    RKRelationshipMapping *imgMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"image" toKeyPath:@"image" withMapping:[MKRUser mapping]];
    [achMapping addPropertyMapping:imgMapping];
    return achMapping;
}


@end