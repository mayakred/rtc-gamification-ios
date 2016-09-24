//
//  MKRProfileViewController.m
//  rostel
//
//  Created by Anton Zlotnikov on 24.09.16.
//  Copyright © 2016 mayak. All rights reserved.
//

#import "MKRProfileViewController.h"
#import "MKRAppDataProvider.h"
#import "MKRFullUser.h"
#import "MKRUtils.h"
#import "UIViewController+Errors.h"
#import "MKRStatsPresenter.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MKRProfileGraphTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MKRProfileAchievementCollectionViewCell.h"
#import "MKRUserAchievement.h"
#import "MKRStrangeObject.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface MKRProfileViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, MKRStatsListDataDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingTypeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statTypeSegment;
- (IBAction)statTypeSegmentChange:(id)sender;

@end

static NSString * const reuseIdentifier = @"achievementCell";

@implementation MKRProfileViewController {
    NSArray *achievements;
    MKRStatsPresenter *statsPresenter;
    UIRefreshControl *refreshControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!achievements) {
        achievements = @[];
    }
    
//    [self.collectionView registerClass:[MKRProfileAchievementCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    [self.tableView setTableFooterView:[UIView new]];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl setAttributedTitle:[[NSAttributedString alloc] initWithString:@""]];
    [refreshControl addTarget:self action:@selector(refreshTriggered) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    [self.tableView sendSubviewToBack:refreshControl];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = YES;
    MKRFullUser *fullUser = [[MKRAppDataProvider shared].userService fullUserWithId:self.userId];
    if (fullUser) {
        [self showUserInfo:fullUser];
    }

    statsPresenter = [[MKRStatsPresenter alloc] initWithUserId:self.userId andIsIndividual:YES];
    [statsPresenter setDelegate:self];
    [statsPresenter updateStats];

    [self reloadUserInfo];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refreshTriggered {
    [refreshControl endRefreshing];
    [self reloadUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showUserInfo:(MKRFullUser *)user {
    achievements = user.achievements;
    if (!achievements) {
        achievements = @[];
    }
    NSURL *headerUrl = [NSURL URLWithString:user.avatar.standard];
    [self.avatarImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    [self.fullNameLabel setText:[user fullName]];
    [self.departmentLabel setText:user.department.name];
    [self.positionLabel setText:[NSString stringWithFormat:@"%@", user.topPosition]];
    NSString *ratingStr = [MKRUtils bytesToString:[user.rating integerValue]];
    [self.ratingLabel setText:[ratingStr componentsSeparatedByString:@" "][0]];
    [self.ratingTypeLabel setText:[ratingStr componentsSeparatedByString:@" "][1]];
    [self.collectionView reloadData];
}

- (void)reloadUserInfo {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    [hud.bezelView setStyle:MBProgressHUDBackgroundStyleSolidColor];
    [[MKRAppDataProvider shared].userService getUserWithId:self.userId success:^(MKRFullUser *user) {
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        [self showUserInfo:user];
    } failure:^(MKRErrorContainer *errorContainer) {
        [MBProgressHUD hideHUDForView:self.tableView animated:YES];
        [self showErrorForErrorContainer:errorContainer];
    }];

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [statsPresenter statsCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRProfileGraphTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileGraphIdentifier" forIndexPath:indexPath];
    MKRStrangeObject *stat = [statsPresenter statWithIndex:indexPath.row];
    [cell setFirstNumber:stat.participantValue.floatValue secondNumber:stat.winnerValue.floatValue setTypeTitle:stat.metric.name];
    return cell;
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [achievements count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MKRProfileAchievementCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    MKRUserAchievement *userAchievement = achievements[indexPath.row];
    NSLog(@"%@", userAchievement);
    NSURL *headerUrl = [NSURL URLWithString:userAchievement.achievement.image.standard];
    [cell.achievementImageView sd_setImageWithURL:headerUrl placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //
    }];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

#pragma mark - EmptyDataSet Delegate

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"Достижения отсуствуют";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (void)statsListDidUpdateSuccess {
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
}

- (void)statsListDidUpdateWithError:(MKRErrorContainer *)errorContainer {
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.tableView reloadData];
    });
    [self showErrorForErrorContainer:errorContainer];
}

- (void)statsListWillUpdate {

}

- (IBAction)statTypeSegmentChange:(id)sender {
    [statsPresenter setIsIndividual:self.statTypeSegment.selectedSegmentIndex == 0];
    [statsPresenter loadDuelsIds];
    [self.tableView reloadData];
}
@end
