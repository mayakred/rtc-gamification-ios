#ifndef MKRConsts_h
#define MKRConsts_h

#define ISDEV

#ifdef ISDEV
    #define SERVER_URL @"http://echeep.mayakdev.ru/api/mobile/v1/"
#else
    #define SERVER_URL @"http://echeep.com/api"
#endif

#define DATA_KEY @"data"
#define ERRORS_KEY @"errors"
#define EMPTY_KEY @""

#define APP_DOMAIN @"com.mayak.rostel"
#define PLATFORM @"ios"

#define ONE_SIGNAL_APP_ID @"9fc59e0b-0783-461c-8644-b04a03b4c79a"

enum {
    MKRNetworkError = 1001,
};

#define SUCCESS_STATUS_CODE @"Success"
#define UNKNOWN_CONNECTION_ERROR_CODE @"UnknownConnectionError"
#define ACCESS_TOKEN_INVALID_ERROR_CODE @"AccessTokenInvalid"

#define ERROR_CODES_TABLE @"errorCodes"

#endif /* MKRConsts_h */
