//
//  ViewController.m
//  Demo
//
//  Created by zhangming on 17/7/25.
//  Copyright © 2017年 youjiesi. All rights reserved.
//

#import "ViewController.h"
#import "MeHeaderView.h"
#import "UIView+Extension.h"
#import "UIImage+Extension.h"
#import "UIBarButtonItem+Extension.h"

#define BASECOLOR [UIColor colorWithRed:244.0/255.0 green:21.0/255.0 blue:61.0/255.0 alpha:1]
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MeHeaderViewDelegate>

@property (copy , nonatomic) NSArray *titles;
@property (copy , nonatomic) NSArray *images;
@property (weak, nonatomic) UITableView *tableView;
@property (weak , nonatomic) MeHeaderView *headerView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (NSArray *)titles{
    
    if (!_titles) {
        _titles = @[@[@"我的订单",@"我的地址",@"我的收藏"],@[@"分享有礼",@"系统设置"]];
    }
    return _titles;
}

- (NSArray *)images{
    
    if (!_images) {
        
        _images = @[@[@"mine_dingdan",@"mine_dianziqianbao",@"mine_shoucang"],@[@"my_subscribe",@"icon_myset"]];
    }
    return _images;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setup];
    
}

- (void)setupNavBar
{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:navBar];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    [navBar pushNavigationItem:navItem animated:YES];
    [navBar setBackgroundImage:[UIImage imageWithColor:BASECOLOR size:CGSizeMake(self.view.frame.size.width, 64)] forBarMetrics:UIBarMetricsDefault];
    navItem.title = @"我的";
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [navBar setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *item1 = [UIBarButtonItem itemWithImageName:@"my_message" highImageName:@"my" target:self action:@selector(navItemClick:)];
    
    
    UIBarButtonItem *item2 = [UIBarButtonItem itemWithImageName:@"my_setting" highImageName:@"my" target:self action:@selector(navItemClick:)];
    
    navItem.rightBarButtonItems = @[item1,item2];
    navBar.translucent = NO;
    
}

- (void)setup{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    MeHeaderView *headerView = [[MeHeaderView alloc] init];
    headerView.delegate = self;
    headerView.height = 150;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MeViewCellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MeViewCellId];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MeViewCellId];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor blackColor];
        
    }
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.section][indexPath.row]];
    cell.textLabel.text = self.titles[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0.5;
    }else{
        return 9.5;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",self.titles[indexPath.section][indexPath.row]);
}


#pragma mark - 我的钱包
- (void)onLeft{
    
    NSLog(@"我的钱包");
}

#pragma mark - 我的卡券
- (void)onRight{
    
    NSLog(@"我的卡券");
}

- (void)onLogin{
    
    NSLog(@"登录");
}

- (void)navItemClick:(UIBarButtonItem *)sender{
    
    NSLog(@"点击我");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
