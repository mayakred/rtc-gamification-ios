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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:errorContainer.message
                                                                             message:[errorContainer getFieldsErrorsText]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* closeAction = [UIAlertAction actionWithTitle:NSLocalizedString(LOC_CLOSE_ERROR_DIALOG_BUTTON_TITLE, @"Close error dialog button")
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            [alertController dismissViewControllerAnimated:YES completion:nil];
                                                            if ([errorContainer isNeededToLogout]) {
                                                                [self backToLoginController];
                                                            }
                                                        }];
    [alertController addAction:closeAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)backToLoginController {
    
}

@end
