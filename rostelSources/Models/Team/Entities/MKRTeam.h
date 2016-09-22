//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRDepartment.h"
#import "MKRParticipant.h"
#import "MKRTeamStatisticElement.h"

@class RKObjectMapping;

@interface MKRTeam : MKREntityWithId

@property (nonatomic) MKRDepartment *department;
@property (nonatomic) RLMArray<MKRParticipant> *participants;
@property (nonatomic) RLMArray<MKRTeamStatisticElement> *statistic;

+ (RKObjectMapping *)mapping;

@end

RLM_ARRAY_TYPE(MKRTeam)