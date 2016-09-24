//
//  UIViewController+Errors.m
//  echeep
//
//  Created by Anton Zlotnikov on 04.04.16.
//  Copyright © 2016 MAYAK RED. All rights reserved.
//

#import "UIViewController+Errors.h"
#import "MKRAppDataProvider.h"
#import "MKRLocalizableConsts.h"
#import "MKRErrorContainer.h"
#import "UIWindows+Additions.h"
#import "MKRNavigationController.h"
@implementation UIViewController (Errors)

- (void)viewWillAppear:(BOOL)animated {
    [[[MKRAppDataProvider shared] globalErrorsObserver] addDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[[MKRAppDataProvider shared] globalErrorsObserver] removeDelegate:self];
}

- (void)globalError:(NSError *)error {
    [self showErrorForErrorContainer:[MKRErrorContainer errorContainerWithError:error andServerErrors:nil]];
}

- (void)showErrorForErrorContainer:(MKRErrorContainer *)errorContainer {
    [self showErrorForErrorContainer:errorContainer withCompletion:NULL];
}

- (void)showErrorForErrorContainer:(MKRErrorContainer *)errorContainer withCompletion:(void (^)(void))completion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:errorContainer.message
                                                                             message:[errorContainer getFieldsErrorsText]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* closeAction = [UIAlertAction actionWithTitle:NSLocalizedString(LOC_CLOSE_ERROR_DIALOG_BUTTON_TITLE, @"Close error dialog button")
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [alertController dismissViewControllerAnimated:YES completion:NULL];
                                                            if (completion) {
                                                                completion();
                                                            }
                                                            if ([errorContainer isNeededToLogout]) {
                                                                [self backToLoginController];
                                                            }
                                                        }];
    [alertController addAction:closeAction];
    [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)backToLoginController {
    [[MKRAppDataProvider shared].authService setTokenIsInvalid];
    [[MKRAppDataProvider shared].pushService unregisterForPushNotifications];
    [[MKRAppDataProvider shared].userService clearAllCache];
    [[MKRAppDataProvider shared].duelsService clearAllCache];
    [[MKRAppDataProvider shared].statsService clearAllCache];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"auth" bundle:nil];
    [[[UIApplication sharedApplication] keyWindow] setRootViewController:[storyboard instantiateInitialViewController] animated:YES];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:[[NSBundle mainBundle] bundleIdentifier]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)registerKeyboardActions {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note {
    NSValue *keyboardFrameBegin = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *animationDuration = [note.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGFloat keyboardHeight = [keyboardFrameBegin CGRectValue].size.height;
    if (!keyboardHeight) {
        return;
    }
    [self keyboardWillShowWithHeight:keyboardHeight andDuration:[animationDuration floatValue]];

}

- (void)keyboardWillHide:(NSNotification *)note {
    NSValue *keyboardFrameBegin = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    NSNumber *animationDuration = [note.userInfo valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    CGFloat keyboardHeight = [keyboardFrameBegin CGRectValue].size.height;
    [self keyboardWillHideWithHeight:keyboardHeight andDuration:[animationDuration floatValue]];
}

//override it
- (void)keyboardWillShowWithHeight:(CGFloat)height andDuration:(CGFloat)duration {

}

//override it
- (void)keyboardWillHideWithHeight:(CGFloat)height andDuration:(CGFloat)duration {

}

@end
