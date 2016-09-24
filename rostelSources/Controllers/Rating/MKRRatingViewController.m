//
//  MKRRatingViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 23.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRRatingViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MKRUsersListPresenter.h"
#import "UIViewController+Errors.h"
#import "UIColor+MKRColor.h"
#import "MKRRatingTableViewCell.h"
#import "MKRAppDataProvider.h"
#import "MKRFullUser.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKRRatingViewController () <UITableViewDataSource, UITableViewDelegate,
        DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, MKRUsersListDataDelegate>
@property (weak, nonatomic) IBOutlet UISegmentedControl *listTypeSegment;
@property (weak, nonatomic) IBOutlet UIView *curUserView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *curUserBlurView;
@property (weak, nonatomic) IBOutlet UILabel *curUserPositionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *curUserAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *curUserDepartmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *curUserFullNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *curUserTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *curUserBottomConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)listTypeSegmentChange:(id)sender;

@end

static NSString *const kMKRRatingCellIdentifier = @"ratingCell";

@implementation MKRRatingViewController {
    BOOL isLoadingUsers;
    UIRefreshControl *refreshControl;
    MKRUsersListPresenter *presenter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoadingUsers = NO;
    [self.tableView setTableFooterView:[UIView new]];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [refreshControl addTarget:self action:@selector(refreshTriggered) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];
    presenter = [[MKRUsersListPresenter alloc] init];
    [presenter setDelegate:self];
    [presenter updateUsers];
    [self.curUserBlurView setEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [self reloadCurUser];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
}

- (void)refreshTriggered {
    [refreshControl endRefreshing];
    [presenter updateUsers];
}

- (void)reloadCurUser {
    MKRUser *user = [[MKRAppDataProvider shared].userService userWithId:[MKRAppDataProvider shared].userService.currentUser.itemId];
    if (user) {
        [self.curUserView setHidden:NO];
        NSURL *headerUrl = [NSURL URLWithString:user.avatar.standard];
        [self.curUserAvatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            //
        }];
        [self.curUserFullNameLabel setText:[user fullName]];
        [self.curUserDepartmentLabel setText:user.department.name];
        [self.curUserPositionLabel setText:[NSString stringWithFormat:@"%d", [presenter getPosForUserWithId:user.itemId] + 1]];
    } else {
        [self.curUserView setHidden:YES];
    }
}

#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [presenter usersCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRRatingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMKRRatingCellIdentifier forIndexPath:indexPath];
    MKRUser *user = [presenter userWithIndex:indexPath.row];
    [cell setData:user andPosition:indexPath.row + 1];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoadingUsers) {
        return;
    }
    int p = 0;
    for (MKRRatingTableViewCell *cell in self.tableView.visibleCells) {
        if (p != [self.tableView.visibleCells count] - 1 && p != 0 && [cell.userId isEqualToNumber:[MKRAppDataProvider shared].userService.currentUser.itemId]) {
            [self.curUserView setHidden:YES];
            if (p == 1) {
                [self.curUserTopConstraint setPriority:UILayoutPriorityDefaultHigh];
                [self.curUserBottomConstraint setPriority:UILayoutPriorityDefaultLow];
                [self.tableView setContentInset:UIEdgeInsetsMake(0,0,0,0)];
                [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0,0,0,0)];
            } else {
                [self.curUserTopConstraint setPriority:UILayoutPriorityDefaultLow];
                [self.curUserBottomConstraint setPriority:UILayoutPriorityDefaultHigh];
                [self.tableView setContentInset:UIEdgeInsetsMake(0,0,100,0)];
                [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(0,0,100,0)];
            }
            [self.view setNeedsLayout];
            return;
        }
        p++;
    }
    [self.curUserView setHidden:NO];
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
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
        [self reloadCurUser];
    });
}

- (void)usersListDidUpdateWithError:(MKRErrorContainer *)errorContainer {
    isLoadingUsers = NO;
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
    [self showErrorForErrorContainer:errorContainer];
}

- (void)usersListWillUpdate {
    isLoadingUsers = YES;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
}

#pragma mark - User Actions

- (IBAction)listTypeSegmentChange:(id)sender {
    if (self.listTypeSegment.selectedSegmentIndex == 1) {
        [presenter applyDepartmentCode:[MKRAppDataProvider shared].userService.currentUser.department.code];
    } else {
        [presenter applyDepartmentCode:nil];
    }
}


@end
