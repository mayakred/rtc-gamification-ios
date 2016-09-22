//
// Created by Anton Zlotnikov on 17.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Realm.h"

@class RKObjectMapping;

@interface MKRImage : RLMObject

@property (nonatomic, copy) NSString *thumbnail;
@property (nonatomic, copy) NSString *standard;
@property (nonatomic, copy) NSString *original;

+ (RKObjectMapping *)mapping;

@end