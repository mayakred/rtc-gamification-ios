//
// Created by Anton Zlotnikov on 15.02.16.
// Copyright (c) 2016 MAYAK RED. All rights reserved.
//

#import "MKRErrorContainer.h"
#import "MKRServerError.h"
#import "MKRConsts.h"


@implementation MKRErrorContainer {
    NSError *originalError;
}

- (instancetype)initWithOriginalError:(NSError *)error {
    self = [super init];
    if (!self) {
        return nil;
    }
    originalError = error;
    [self setIncorrectFields:@{}];

    return self;
}

+ (MKRErrorContainer *)errorContainerWithError:(NSError *)error andServerErrors:(NSArray *)serverErrors {
    MKRErrorContainer *errorContainer = [[MKRErrorContainer alloc] initWithOriginalError:error];
    [errorContainer setMessage:[error localizedDescription]];
    NSMutableDictionary *newIncorrectFields = [NSMutableDictionary new];
    if (serverErrors) {
        for (MKRServerError *serverError in serverErrors) {
            if (serverError.field && serverError.error) {
                [newIncorrectFields setValue:NSLocalizedStringFromTable([serverError.field stringByAppendingString:serverError.error], ERROR_CODES_TABLE, @"") forKey:serverError.field];
            }
        }
    }
    [errorContainer setIncorrectFields:[NSDictionary dictionaryWithDictionary:newIncorrectFields]];

    return errorContainer;
}

- (BOOL)isNeededToLogout {
    return (originalError && [originalError.userInfo[NSLocalizedFailureReasonErrorKey] isEqualToString:ACCESS_TOKEN_INVALID_ERROR_CODE]);
}

- (NSString *)getFieldsErrorsText {
    NSString *result = @"";
    for (NSString *errorText in [self.incorrectFields allValues]) {
        result = [result stringByAppendingFormat:@"%@\n", errorText];
    }

    return result;
}

@end