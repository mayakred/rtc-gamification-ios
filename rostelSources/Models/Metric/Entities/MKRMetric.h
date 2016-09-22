//
// Created by Anton Zlotnikov on 22.09.16.
// Copyright (c) 2016 mayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class RKObjectMapping;

@interface MKRMetric : RLMObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *unitType;
@property (nonatomic, strong) NSString *name;

+ (RKObjectMapping *)mapping;

@end