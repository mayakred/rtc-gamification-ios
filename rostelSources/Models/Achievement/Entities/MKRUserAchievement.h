//
// Created by Anton Zlotnikov on 23.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRAchievement.h"

@class RKObjectMapping;

@interface MKRUserAchievement : MKREntityWithId

@property (nonatomic, copy) NSNumber<RLMDouble> *currentValue;
@property (nonatomic) MKRAchievement *achievement;

+ (RKObjectMapping *)mapping;

@end

RLM_ARRAY_TYPE(MKRUserAchievement)