//
//  UIViewController+Errors.h
//  echeep
//
//  Created by Anton Zlotnikov on 04.04.16.
//  Copyright © 2016 MAYAK RED. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKRGlobalErrorsObserver.h"

@class MKRErrorContainer;

@interface UIViewController (Errors) <MKRErrorsObserverDelegate>

- (void)showErrorForErrorContainer:(MKRErrorContainer *)errorContainer;

- (void)backToLoginController;

- (void)registerKeyboardActions;
@end
