//
// Created by Anton Zlotnikov on 24.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRStrangeObject.h"
#import <RestKit/RestKit.h>

@implementation MKRStrangeObject {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *statMapping = [RKObjectMapping mappingForClass:[self class]];
    [statMapping addAttributeMappingsFromDictionary:@{
            @"id"               : @"itemId",
            @"team_value"       : @"teamValue",
            @"threshold_value"  : @"thresholdValue",
            @"winner_value"     : @"winnerValue",
            @"user_id"     : @"userId",
            @"participant_value"     : @"participantValue",
            @"is_perviy_subview"     : @"isPerviySubview",
            @"is_vtoroy_subview"     : @"isVtoroySubview",
    }];
    RKRelationshipMapping *metMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"metric" toKeyPath:@"metric" withMapping:[MKRMetric mapping]];
    [statMapping addPropertyMapping:metMapping];
    RKRelationshipMapping *depMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"department" toKeyPath:@"department" withMapping:[MKRDepartment mapping]];
    [statMapping addPropertyMapping:depMapping];
    return statMapping;
}

@end