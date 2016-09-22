//
// Created by Anton Zlotnikov on 17.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRImage.h"
#import <RestKit/RestKit.h>


@implementation MKRImage {

}

+ (RKObjectMapping *)mapping {
    RKObjectMapping *logoMapping = [RKObjectMapping mappingForClass:[self class]];
    [logoMapping addAttributeMappingsFromDictionary:@{
            @"standard"  : @"standard",
            @"thumbnail" : @"thumbnail",
            @"original"  : @"original",
    }];
    return logoMapping;
}

+ (NSString *)primaryKey {
    return @"original";
}

@end