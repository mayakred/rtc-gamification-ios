//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRDuel.h"
#import <RestKit/RestKit.h>

@implementation MKRDuel {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *parMapping = [RKObjectMapping mappingForClass:[self class]];
    [parMapping addAttributeMappingsFromDictionary:@{
            @"id"              : @"itemId",
            @"start_at"        : @"startAt",
            @"end_at"          : @"endAt",
            @"victim_value"    : @"victimValue",
            @"initiator_value" : @"initiatorValue",
            @"status"          : @"status",
    }];
    RKRelationshipMapping *user1Mapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"initiator" toKeyPath:@"initiator" withMapping:[MKRUser mapping]];
    [parMapping addPropertyMapping:user1Mapping];
    RKRelationshipMapping *user2Mapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"victim" toKeyPath:@"victim" withMapping:[MKRUser mapping]];
    [parMapping addPropertyMapping:user2Mapping];
    RKRelationshipMapping *statMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"metric" toKeyPath:@"metric" withMapping:[MKRMetric mapping]];
    [parMapping addPropertyMapping:statMapping];
    return parMapping;
}


@end