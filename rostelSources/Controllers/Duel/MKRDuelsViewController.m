//
//  MKRDuelsViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRDuelsViewController.h"
#import "MKRDuelsListPresenter.h"
#import "MKRDuelTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIColor+MKRColor.h"
#import "UIViewController+Errors.h"
#import "MKRDuel.h"
#import "MKRAppDataProvider.h"
#import "MKRFullUser.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRDuelsViewController () <MKRDuelsListDataDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, MGSwipeTableCellDelegate>

@end

static NSString *const kMKRDuelCellIdentifier = @"duelCell";

@implementation MKRDuelsViewController {
    MKRDuelsListPresenter *presenter;
    BOOL isLoadingDuels;
    UIRefreshControl *refreshControl;
    IBOutlet UILabel *loseCountLabel;
    IBOutlet UILabel *drawCountLabel;
    IBOutlet UILabel *winCountLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoadingDuels = NO;
    [self.tableView setTableFooterView:[UIView new]];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [refreshControl addTarget:self action:@selector(refreshTriggered) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];
    presenter = [[MKRDuelsListPresenter alloc] init];
    [presenter setDelegate:self];
    [presenter updateDuels];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    // Uncomment the following line to preserve selection between presentations.
    [self setClearsSelectionOnViewWillAppear:YES];
    [self reloadData];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)reloadData {
    [self.tableView reloadData];
    [self updateDuelsStats];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTriggered {
    [refreshControl endRefreshing];
    [presenter updateDuels];
}

- (void)updateDuelsStats {
    [loseCountLabel setText:[NSString stringWithFormat:@"%d", [MKRAppDataProvider shared].duelsService.lostDuelsCount]];
    [winCountLabel setText:[NSString stringWithFormat:@"%d", [MKRAppDataProvider shared].duelsService.wonDuelsCount]];
    [drawCountLabel setText:[NSString stringWithFormat:@"%d", [MKRAppDataProvider shared].duelsService.drawDuelsCount]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [presenter duelsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRDuelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMKRDuelCellIdentifier forIndexPath:indexPath];
    MKRDuel *duel = [presenter duelWithIndex:indexPath.row];
    [cell setData:duel];
    [cell setDelegate:self]; //optional
    if ([duel.status isEqualToString:DUEL_STATUS_WAITING_VICTIM] && [duel.victim.itemId isEqualToNumber:[MKRAppDataProvider shared].userService.currentUser.itemId]) {
        //configure left buttons
        [cell setLeftButtons:@[[MGSwipeButton buttonWithTitle:@"Отказаться" backgroundColor:[UIColor mkr_orangeColor] callback:^BOOL(MGSwipeTableCell *sender) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
            [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
            [[MKRAppDataProvider shared].duelsService declineDuelWithId:duel.itemId success:^{
                [MBProgressHUD hideHUDForView:self.tableView animated:YES];
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [self.tableView reloadData];
                });
            } failure:^(MKRErrorContainer *errorContainer) {
                [self showErrorForErrorContainer:errorContainer];
            }];
            return YES;
        }]]];
        [cell.leftSwipeSettings setTransition:MGSwipeTransitionStatic];

        //configure right buttons
        [cell setRightButtons:@[[MGSwipeButton buttonWithTitle:@"Принять" backgroundColor:[UIColor mkr_blueColor] callback:^BOOL(MGSwipeTableCell *sender) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
            [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
            [[MKRAppDataProvider shared].duelsService acceptDuelWithId:duel.itemId success:^{
                [MBProgressHUD hideHUDForView:self.tableView animated:YES];
                dispatch_async(dispatch_get_main_queue(), ^(){
                    [self.tableView reloadData];
                });
            } failure:^(MKRErrorContainer *errorContainer) {
                [self showErrorForErrorContainer:errorContainer];
            }];
            return YES;
        }]]];
        [cell.rightSwipeSettings setTransition:MGSwipeTransitionStatic];
    } else {
        [cell setRightButtons:nil];
        [cell setLeftButtons:nil];
    }
    return cell;
}

#pragma mark - DZNEmptyDataSet delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = isLoadingDuels ? @"Подождите" : @"Дуэлей нет";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
            NSForegroundColorAttributeName: [UIColor darkGrayColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text =  isLoadingDuels ? @"Загружаем дуэли" : @"Вызовите кого-нить на дуэль";

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

- (void)duelsListDidUpdateSuccess {
    isLoadingDuels = NO;
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self reloadData];
    });
}

- (void)duelsListDidUpdateWithError:(MKRErrorContainer *)errorContainer {
    isLoadingDuels = NO;
    [MBProgressHUD hideHUDForView:self.tableView animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self reloadData];
    });
    [self showErrorForErrorContainer:errorContainer];
}

- (void)duelsListWillUpdate {
    isLoadingDuels = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
