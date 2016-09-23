//
//  MKRAuthPhoneViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 20.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import <SHSPhoneComponent/SHSPhoneTextField.h>
#import "MKRAuthPhoneViewController.h"
#import "UIViewController+Errors.h"
#import "MKRAppDataProvider.h"
#import "MKRAuthCodeViewController.h"
#import "MKRNavigationController.h"

@interface MKRAuthPhoneViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet SHSPhoneTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendCodeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendCodeButtonBottomConstraint;
- (IBAction)sendCodeClick:(id)sender;

@end

static NSString *const kMKRSendCodeSegueIndentifer = @"sendCodeSegue";

@implementation MKRAuthPhoneViewController {
    BOOL keyboardShown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [(MKRNavigationController *)self.navigationController setWhiteStyle];
    [self setNeedsStatusBarAppearanceUpdate];
    keyboardShown = NO;
    [self.sendCodeButton setEnabled:NO];
    [self.phoneTextField.formatter setDefaultOutputPattern:@"(###) ###-##-##"];
    [self.phoneTextField.formatter setPrefix:@"+7 "];
    [self registerKeyboardActions];
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

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self.sendCodeButton setEnabled:NO];
    [textField setText:@"+7 "];
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self checkValidNumber:^{
        //
    }];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self checkValidNumber:^{
        //
    }];
    return YES;
}

- (void)checkValidNumber:(void(^)())validBlock {
    //TODO add regexp
    BOOL isValid = [self.phoneTextField.text length] == 18;
    [self.sendCodeButton setEnabled:isValid];
    if (isValid) {
        validBlock();
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kMKRSendCodeSegueIndentifer]) {
        MKRAuthCodeViewController *destinationController = [segue destinationViewController];
        [destinationController setPhone:self.phoneTextField.phoneNumber];
    }
}

- (IBAction)sendCodeClick:(id)sender {
    [self.view endEditing:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [[[MKRAppDataProvider shared] authService] sendCodeToPhone:self.phoneTextField.phoneNumber success:^{
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        [self performSegueWithIdentifier:kMKRSendCodeSegueIndentifer sender:self];
    } failure:^(MKRErrorContainer *errorContainer) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        [self showErrorForErrorContainer:errorContainer];
    }];
}
@end
