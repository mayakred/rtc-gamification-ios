//
//  MKRDuelSelectuserViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 25.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRDuelSelectuserViewController.h"
#import "MKRUsersListPresenter.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MKRUser.h"
#import "MKRDuelSelectuserTableViewCell.h"
#import "UIColor+MKRColor.h"
#import "UIViewController+Errors.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRDuelSelectuserViewController () <DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, MKRUsersListDataDelegate>

@end

static NSString *const kMKRUserCellIdentifier = @"userCell";

@implementation MKRDuelSelectuserViewController {
    BOOL isLoadingUsers;
    MKRUsersListPresenter *presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoadingUsers = NO;
    [self.tableView setTableFooterView:[UIView new]];
    presenter = [[MKRUsersListPresenter alloc] init];
    [presenter setDelegate:self];
    [presenter updateUsers];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [presenter usersCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRDuelSelectuserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMKRUserCellIdentifier forIndexPath:indexPath];
    MKRUser *user = [presenter userWithIndex:indexPath.row];
    [cell setData:user];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRUser *user = [presenter userWithIndex:indexPath.row];
    if (self.delegate) {
        [self.delegate didSelectUser:user];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - DZNEmptyDataSet delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = isLoadingUsers ? @"Подождите" : @"Пользователи отсутствуют";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
            NSForegroundColorAttributeName: [UIColor darkGrayColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =  isLoadingUsers ? @"Загружаем рейтинг" : @"Никто не юзает эту прогу";

    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
            NSForegroundColorAttributeName: [UIColor lightGrayColor],
            NSParagraphStyleAttributeName: paragraph};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor mkr_emptyDataSetColor];
}

#pragma mark - Presenter Delegate

- (void)usersListDidUpdateSuccess {
    isLoadingUsers = NO;
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
}

- (void)usersListDidUpdateWithError:(MKRErrorContainer *)errorContainer {
    isLoadingUsers = NO;
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
    [self showErrorForErrorContainer:errorContainer];
}

- (void)usersListWillUpdate {
    isLoadingUsers = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
