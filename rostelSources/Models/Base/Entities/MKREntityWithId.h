//
// Created by Anton Zlotnikov on 02.03.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface MKREntityWithId : RLMObject

@property (nonatomic, copy) NSNumber<RLMInt> *itemId;

@end