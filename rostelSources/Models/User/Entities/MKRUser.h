//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKREntityWithId.h"
#import "MKRImage.h"
#import "MKRDepartment.h"
#import "MKRUserAchievement.h"

@class RKObjectMapping;

@interface MKRUser : MKREntityWithId

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSNumber<RLMInt> *rating;
@property (nonatomic, copy) NSNumber<RLMInt> *topPosition;
@property (nonatomic) MKRDepartment *department;
@property (nonatomic) MKRImage *avatar;
@property (nonatomic) RLMArray<MKRUserAchievement> *achievements;

- (NSArray *)orderedAchievements;

+ (RKObjectMapping *)mappingForClass:(Class)mClass;

+ (RKObjectMapping *)mapping;

- (NSString *)fullName;

@end