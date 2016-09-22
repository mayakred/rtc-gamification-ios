//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRParticipantStatisticElement.h"
#import <RestKit/RestKit.h>

@implementation MKRParticipantStatisticElement {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *statMapping = [RKObjectMapping mappingForClass:[self class]];
    [statMapping addAttributeMappingsFromDictionary:@{
            @"participant_value": @"participantValue",
            @"team_value"       : @"teamValue",
            @"threshold_value"  : @"thresholdValue",
            @"winner_value"     : @"winnerValue",
    }];
    RKRelationshipMapping *metMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"metric" toKeyPath:@"metric" withMapping:[MKRMetric mapping]];
    [statMapping addPropertyMapping:metMapping];
    return statMapping;
}

//+ (NSString *)primaryKey {
//    return @"original";
//}

@end