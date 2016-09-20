//
// Created by Anton Zlotnikov on 01.04.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MKRErrorsObserverDelegate <NSObject>
@required
- (void)globalError:(NSError *)error;
@end


@interface MKRGlobalErrorsObserver : NSObject

+ (void)sendGlobalError:(NSError *)error;

- (void)addDelegate:(id <MKRErrorsObserverDelegate>)delegate;

- (void)removeDelegate:(id <MKRErrorsObserverDelegate>)delegate;
@end