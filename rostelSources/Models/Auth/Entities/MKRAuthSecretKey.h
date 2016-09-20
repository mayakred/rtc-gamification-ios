//
// Created by Anton Zlotnikov on 11.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKObjectMapping;

@interface MKRAuthSecretKey : NSObject

@property (nonatomic, copy) NSString *secret;

+ (RKObjectMapping *)mapping;



@end