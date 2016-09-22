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
            @"last_name"   : @"lastName",
            @"gender"      : @"gender",
    }];
    RKRelationshipMapping *avatarMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"avatar" toKeyPath:@"avatar" withMapping:[MKRImage mapping]];
    [userMapping addPropertyMapping:avatarMapping];

    return userMapping;
}

+ (RKObjectMapping *)mapping {
    return [MKRUser mappingForClass:[self class]];
}

- (NSString *)fullName {
    NSString *result = [NSString stringWithFormat:@"%@%@ %@", self.lastName ?: @"", self.firstName ? [@" " stringByAppendingString:self.firstName]: @"", self.middleName ?: @""];
    return [result isEqualToString:@" "] ? @"" : result;
}

@end