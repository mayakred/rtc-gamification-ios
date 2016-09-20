//
//  MKRAuthCodeViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 20.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "MKRAuthCodeViewController.h"
#import "UIViewController+Errors.h"
#import "MKRLoginCodeInputView.h"
#import "MKRAppDataProvider.h"

@interface MKRAuthCodeViewController () <MKRLoginCodeInputDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendCodeButtonBottomConstraint;
@property (weak, nonatomic) IBOutlet MKRLoginCodeInputView *codeInputView;
- (IBAction)sendCodeClick:(id)sender;

@end

@implementation MKRAuthCodeViewController {
    BOOL keyboardShown;
    NSString *phone;
}

- (void)setPhone:(NSString *)newPhone {
    phone = newPhone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    keyboardShown = NO;
    [self.sendCodeButton setEnabled:NO];
    [self.codeInputView setDelegate:self];
    [self registerKeyboardActions];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.codeInputView setCodeFieldAsFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShow:(NSNotification *)note {
    NSValue *keyboardFrameBegin = [note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    float keyboardHeight = [keyboardFrameBegin CGRectValue].size.height;
    if (!keyboardHeight || keyboardShown) {
        return;
    }
    keyboardShown = YES;
    [self.sendCodeButtonBottomConstraint setConstant:keyboardHeight];
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)note {
    if (!keyboardShown) {
        return;
    }
    keyboardShown = NO;
    [self.sendCodeButtonBottomConstraint setConstant:0];
    [UIView animateWithDuration:0.4 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)codeSymbolEntered {
    BOOL codeEntered = [[self.codeInputView getCode] length] == 5;
    [self.sendCodeButton setEnabled:codeEntered];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendCodeClick:(id)sender {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [[[MKRAppDataProvider shared] authService] authWithPhone:phone andCode:[self.codeInputView getCode] success:^(BOOL isFirstAuth) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        MKRMapViewController *mapViewController = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MKRMapViewController class])];
//        [[[UIApplication sharedApplication] keyWindow] setRootViewController:mapViewController animated:YES];
    } failure:^(MKRErrorContainer *errorContainer) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        [self showErrorForErrorContainer:errorContainer];
    }];
}
@end
