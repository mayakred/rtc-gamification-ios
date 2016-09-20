//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRServerError.h"
#import <RestKit/RestKit.h>


@implementation MKRServerError {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[self class]];
    [errorMapping addAttributeMappingsFromDictionary:@{
            @"error" : @"error",
            @"field"   : @"field"
    }];
    return errorMapping;
}


@end