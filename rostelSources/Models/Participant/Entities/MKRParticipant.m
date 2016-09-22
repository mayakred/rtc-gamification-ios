//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRParticipant.h"
#import <RestKit/RestKit.h>

@implementation MKRParticipant {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *parMapping = [RKObjectMapping mappingForClass:[self class]];
    [parMapping addAttributeMappingsFromDictionary:@{
            @"id"    : @"itemId",
    }];
    RKRelationshipMapping *userMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"user" toKeyPath:@"user" withMapping:[MKRFullUser mapping]];
    [parMapping addPropertyMapping:userMapping];
    RKRelationshipMapping *statMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"statistic" toKeyPath:@"statistic" withMapping:[MKRParticipantStatisticElement mapping]];
    [parMapping addPropertyMapping:statMapping];
    return parMapping;
}


@end