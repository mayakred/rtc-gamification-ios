//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import "MKRUser.h"
#import <RestKit/RestKit.h>

@implementation MKRUser {

}

+ (RKObjectMapping *)mappingForClass:(Class)mClass {
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:mClass];
    [userMapping addAttributeMappingsFromDictionary:@{
            @"id"          : @"itemId",
            @"first_name"  : @"firstName",
            @"middle_name" : @"middleName",
            @"second_name"   : @"lastName",
            @"gender"      : @"gender",
            @"top_position"      : @"topPosition",
            @"rating"            : @"rating",
    }];
    RKRelationshipMapping *avatarMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"avatar" toKeyPath:@"avatar" withMapping:[MKRImage mapping]];
    [userMapping addPropertyMapping:avatarMapping];
    RKRelationshipMapping *achMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"achievements" toKeyPath:@"achievements" withMapping:[MKRUserAchievement mapping]];
    [userMapping addPropertyMapping:achMapping];
    RKRelationshipMapping *depMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"department" toKeyPath:@"department" withMapping:[MKRDepartment mapping]];
    [userMapping addPropertyMapping:depMapping];

    return userMapping;
}

+ (RKObjectMapping *)mapping {
    return [MKRUser mappingForClass:[self class]];
}

- (NSArray *)orderedAchievements {
    NSMutableArray *result = [NSMutableArray new];
    for (MKRUserAchievement *ach in self.achievements) {
//        if (ach.currentValue.floatValue >= ach.achievement.maxValue.floatValue) {
            [result addObject:ach];
//        }
    }
    return [result sortedArrayUsingComparator:^NSComparisonResult(MKRUserAchievement *obj1, MKRUserAchievement *obj2) {
        float v1 = 0;
        if (obj1.achievement.maxValue.floatValue != 0) {
            v1 = obj1.currentValue.floatValue / obj1.achievement.maxValue.floatValue;
        }
        float v2 = 0;
        if (obj2.achievement.maxValue.floatValue != 0) {
            v2 = obj2.currentValue.floatValue / obj2.achievement.maxValue.floatValue;
        }
        if (v1 > v2) {
            return NSOrderedAscending;
        }
        if (v1 < v2) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}


- (NSString *)fullName {
    NSString *result = [NSString stringWithFormat:@"%@%@ %@", self.lastName ?: @"", self.firstName ? [@" " stringByAppendingString:self.firstName]: @"", self.middleName ?: @""];
    return [result isEqualToString:@" "] ? @"" : result;
}

@end
