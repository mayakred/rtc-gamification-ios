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
#import "CALayer+RuntimeAttribute.h"
#import "MKRUsersMetricsViewController.h"
#import "MKRAchivCollectionViewController.h"

@interface MKRProfileViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, MKRStatsListDataDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *achAreaView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *statTypeSegment;
- (IBAction)statTypeSegmentChange:(id)sender;

@end

static NSString * const reuseIdentifier = @"achievementCell";
static NSString * const kMKRMetricSegue = @"metricSegue";

@implementation MKRProfileViewController {
    NSArray *achievements;
    MKRStatsPresenter *statsPresenter;
    UIRefreshControl *refreshControl;
    MKRMetric *selectedMetrics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!achievements) {
        achievements = @[];
    }

    [self.achAreaView setUserInteractionEnabled:YES];
    UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(achAreaTap)];
    [self.achAreaView addGestureRecognizer:singleFingerTap];

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

- (void)achAreaTap {
    if (!achievements) {
        return;
    }
    UIStoryboard *achievementStoryboard = [UIStoryboard storyboardWithName:@"achiv" bundle:nil];
    MKRAchivCollectionViewController *achievementController = [achievementStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass([MKRAchivCollectionViewController class])];
    [achievementController setUserAchievements:achievements];
    [self.navigationController pushViewController:achievementController animated:YES];
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
    achievements = [user orderedAchievements];
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
        [statsPresenter updateStats];
        [self.tableView reloadData];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRStrangeObject *stat = [statsPresenter statWithIndex:indexPath.row];
    selectedMetrics = stat.metric;
    [self performSegueWithIdentifier:kMKRMetricSegue sender:self];
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
        if (![userAchievement isDone]) {
            [cell.achievementImageView setImage:[MKRUtils grayscaleImage:image]];
        }
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
    [statsPresenter loadStatsIds];
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kMKRMetricSegue]) {
        [(MKRUsersMetricsViewController *)segue.destinationViewController setMetricCode:selectedMetrics.code];
        [(MKRUsersMetricsViewController *)segue.destinationViewController setPerviySubview:self.statTypeSegment.selectedSegmentIndex == 0];
        [segue.destinationViewController setTitle:selectedMetrics.name];
    }
}

@end
