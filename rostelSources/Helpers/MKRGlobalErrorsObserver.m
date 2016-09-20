//
// Created by Anton Zlotnikov on 01.04.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRGlobalErrorsObserver.h"

static NSString *const kMKRErrorChannel = @"global_errors_channel";

@implementation MKRGlobalErrorsObserver {
    NSHashTable *delegates;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    delegates = [NSHashTable weakObjectsHashTable];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveErrorNotification:)
                                                 name:kMKRErrorChannel
                                               object:nil];

    return self;
}

- (void)receiveErrorNotification:(NSNotification *)notification {
    if ([[notification name] isEqualToString:kMKRErrorChannel]) {
        for (id <MKRErrorsObserverDelegate> delegate in delegates) {
            [delegate globalError:notification.object];
        }
    }
}

+ (void)sendGlobalError:(NSError *)error {
    [[NSNotificationCenter defaultCenter] postNotificationName:kMKRErrorChannel object:error];
}

- (void)addDelegate:(id<MKRErrorsObserverDelegate>) delegate {
    [delegates addObject: delegate];
}

- (void)removeDelegate:(id<MKRErrorsObserverDelegate>) delegate {
    [delegates removeObject: delegate];
}

@end