//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRResponseInfo.h"
#import "MKRServerError.h"
#import <RestKit/RestKit.h>

@implementation MKRResponseInfo {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *responseObjectMapping = [RKObjectMapping mappingForClass:[self class]];
    [responseObjectMapping addAttributeMappingsFromDictionary:@{
            @"status" : @"status",
            @"message" : @"message"
    }];
    RKRelationshipMapping *errorsMapping = [RKRelationshipMapping relationshipMappingFromKeyPath:@"errors" toKeyPath:@"errors" withMapping:[MKRServerError mapping]];
    [responseObjectMapping addPropertyMapping:errorsMapping];
    return responseObjectMapping;
}

@end