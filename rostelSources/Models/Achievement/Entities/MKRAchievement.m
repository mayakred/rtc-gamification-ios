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
            @"max_value"       : @"maxValue",
    }];
    RKRelationshipMapping *imgMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"image" toKeyPath:@"image" withMapping:[MKRImage mapping]];
    [achMapping addPropertyMapping:imgMapping];
    RKRelationshipMapping *metricMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"metric" toKeyPath:@"metric" withMapping:[MKRMetric mapping]];
    [achMapping addPropertyMapping:metricMapping];
    return achMapping;
}


@end
