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
#import <SDWebImage/UIImageView+WebCache.h>
#import "MKRProfileGraphTableViewCell.h"
#import "UIScrollView+EmptyDataSet.h"
#import "MKRProfileAchievementCollectionViewCell.h"
#import "MKRUserAchievement.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MKRProfileViewController () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingTypeLabel;

@end

static NSString * const reuseIdentifier = @"achievementCell";

@implementation MKRProfileViewController {
    NSArray *achievements;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!achievements) {
        achievements = @[];
    }
    
//    [self.collectionView registerClass:[MKRProfileAchievementCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    [self.tableView setTableFooterView:[UIView new]];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;

    [self reloadUserInfo];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadUserInfo {
    MKRFullUser *user = [MKRAppDataProvider shared].userService.currentUser;
    achievements = user.achievements;
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
    
    if (!achievements) {
        achievements = @[];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKRProfileGraphTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileGraphIdentifier" forIndexPath:indexPath];
    
    [cell setFirstNumber:(arc4random()%40+10) secondNumber:(arc4random()%40+50) setTypeTitle:@"По бабкам"];
    
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

@end
