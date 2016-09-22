//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"

@class RKObjectMapping;

@interface MKRTournament : MKREntityWithId

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

+ (RKObjectMapping *)mappingForClass:(Class)mClass;

+ (RKObjectMapping *)mapping;

@end