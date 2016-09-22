//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRFullUser.h"
#import "MKRParticipantStatisticElement.h"

@class RKObjectMapping;

@interface MKRParticipant : MKREntityWithId

@property (nonatomic) MKRFullUser *user;
@property (nonatomic) RLMArray<MKRParticipantStatisticElement> *statistic;

+ (RKObjectMapping *)mapping;

@end

RLM_ARRAY_TYPE(MKRParticipant)