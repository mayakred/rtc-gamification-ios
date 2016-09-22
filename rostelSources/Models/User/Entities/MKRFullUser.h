//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKRUser.h"
#import "MKRDepartment.h"

@interface MKRFullUser : MKRUser

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSNumber<RLMInt> *rating;
@property (nonatomic, strong) NSNumber<RLMInt> *topPosition;
@property (nonatomic) MKRDepartment *department;

@end