//
// Created by Anton Zlotnikov on 10.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAuthCredentials.h"
#import <RestKit/RestKit.h>

@implementation MKRAuthCredentials {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *authMapping = [RKObjectMapping mappingForClass:[self class]];
    [authMapping addAttributeMappingsFromDictionary:@{
            @"access_token" : @"token",
            @"id"           : @"userId",
            @"is_new"       : @"isFirstAuth"
    }];
    return authMapping;
}

@end