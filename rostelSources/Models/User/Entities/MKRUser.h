//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRImage.h"

@class RKObjectMapping;

@interface MKRUser : MKREntityWithId

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic) MKRImage *avatar;

+ (RKObjectMapping *)mappingForClass:(Class)mClass;

+ (RKObjectMapping *)mapping;

- (NSString *)fullName;

@end