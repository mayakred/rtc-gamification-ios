//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRMetric.h"
#import <RestKit/RestKit.h>

@implementation MKRMetric {

}


+ (RKObjectMapping *)mapping {
    RKObjectMapping *metricMapping = [RKObjectMapping mappingForClass:[self class]];
    [metricMapping addAttributeMappingsFromDictionary:@{
            @"id"         : @"itemId",
            @"code"       : @"code",
            @"name"       : @"name",
            @"unit_type"  : @"unitType",
            @"available_for_individual_tournaments"  : @"availableForIndividualTournaments",
            @"available_for_team_tournaments"  : @"availableForTeamTournaments",
            @"available_for_duel"  : @"availableForDuel",
    }];
    return metricMapping;
}

@end