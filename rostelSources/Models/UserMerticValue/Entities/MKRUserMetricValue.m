//
// Created by Anton Zlotnikov on 25.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUserMetricValue.h"
#import "RestKit.h"

@implementation MKRUserMetricValue {

}


+ (RKObjectMapping *)mapping {
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[self class]];
    [userMapping addAttributeMappingsFromDictionary:@{
            @"id"               : @"itemId",
            @"user_name"        : @"userFullName",
            @"metric_value"     : @"metricValue",
            @"is_perviy_subview" : @"isPerviySubview"
    }];
    RKRelationshipMapping *metricMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"metric" toKeyPath:@"metric" withMapping:[MKRMetric mapping]];
    [userMapping addPropertyMapping:metricMapping];
    RKRelationshipMapping *avatarMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"user_avatar" toKeyPath:@"userAvatar" withMapping:[MKRImage mapping]];
    [userMapping addPropertyMapping:avatarMapping];
    RKRelationshipMapping *depMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"user_department" toKeyPath:@"userDepartment" withMapping:[MKRDepartment mapping]];
    [userMapping addPropertyMapping:depMapping];

    return userMapping;
}

@end