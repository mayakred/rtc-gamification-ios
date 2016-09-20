//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRAuthSecretKey.h"
#import <RestKit/RestKit.h>


@implementation MKRAuthSecretKey {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *secretMapping = [RKObjectMapping mappingForClass:[self class]];
    [secretMapping addAttributeMappingsFromDictionary:@{
            @"secret" : @"secret"
    }];
    return secretMapping;
}

@end