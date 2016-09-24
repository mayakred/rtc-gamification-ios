//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRTournament.h"
#import <RestKit/RestKit.h>

@implementation MKRTournament {

}


+ (RKObjectMapping *)mappingForClass:(Class)mClass {
    RKObjectMapping *tourMapping = [RKObjectMapping mappingForClass:mClass];
    [tourMapping addAttributeMappingsFromDictionary:@{
            @"id"    : @"itemId",
            @"name"  : @"name",
            @"type"  : @"type",
            @"start_at"  : @"startAt",
    }];
    RKRelationshipMapping *teamsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"teams" toKeyPath:@"teams" withMapping:[MKRTeam mapping]];
    [tourMapping addPropertyMapping:teamsMapping];
    return tourMapping;
}

+ (RKObjectMapping *)mapping {
    return [MKRTournament mappingForClass:[self class]];
}

@end