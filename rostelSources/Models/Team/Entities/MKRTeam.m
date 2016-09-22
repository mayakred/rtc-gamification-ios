//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRTeam.h"
#import <RestKit/RestKit.h>

@implementation MKRTeam {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *teamMapping = [RKObjectMapping mappingForClass:[self class]];
    [teamMapping addAttributeMappingsFromDictionary:@{
            @"id"    : @"itemId",
    }];
    RKRelationshipMapping *userMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"participants" toKeyPath:@"participants" withMapping:[MKRParticipant mapping]];
    [teamMapping addPropertyMapping:userMapping];
    RKRelationshipMapping *statMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"statistic" toKeyPath:@"statistic" withMapping:[MKRTeamStatisticElement mapping]];
    [teamMapping addPropertyMapping:statMapping];
    return teamMapping;
}

@end