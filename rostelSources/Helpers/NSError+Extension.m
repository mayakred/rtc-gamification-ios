#import "NSError+Extension.h"
#import "MKRServerError.h"
#import "MKRConsts.h"

@implementation NSError (Extension)

- (BOOL)isNoInternetConnectionError {
    return ([self.domain isEqualToString:NSURLErrorDomain] && (self.code == NSURLErrorNotConnectedToInternet));
}

+ (NSError *)networkErrorWithErrorCode:(NSString *)errorCode {
    NSString *description = NSLocalizedStringFromTable(errorCode, ERROR_CODES_TABLE, @"");
    return [NSError errorWithDomain:APP_DOMAIN code:MKRNetworkError userInfo:@{
            NSLocalizedDescriptionKey:description,
            NSLocalizedFailureReasonErrorKey:errorCode
    }];
}

@end