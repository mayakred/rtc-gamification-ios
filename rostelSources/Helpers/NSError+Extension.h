#import <Foundation/Foundation.h>

@class MKRServerError;

@interface NSError (Extension)

- (BOOL)isNoInternetConnectionError;

+ (NSError *)networkErrorWithErrorCode:(NSString *)errorCode;

@end