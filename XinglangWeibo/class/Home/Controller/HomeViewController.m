//
//  HomeViewController.m
//  新浪微博
//
//  Created by admin on 14-10-21.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "HomeViewController.h"
#import "BarButtonItem.h"
#import "TitleButton.h"
#import "AFNetworking.h"
#import "Account.h"
#import "IWAccountTool.h"
#import "UIImageView+WebCache.h"
#import "Status.h"
#import "User.h"
#import "MJExtension.h"
#import "StatusFrame.h"
#import "StatusCell.h"
static NSString *CellIdentifier = @"myCell";
@interface HomeViewController ()
//@property (nonatomic, strong) NSArray *statuses;
@property (nonatomic, strong) NSArray *statusesArray;
@end

@implementation HomeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupStatusData];
    
    [self.tableView registerClass:[StatusCell class] forCellReuseIdentifier:CellIdentifier];
}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [BarButtonItem initWithicon:@"navigationbar_friendsearch" heighlightedIcon:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [BarButtonItem initWithicon:@"navigationbar_pop" heighlightedIcon:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    
    // 中间按钮
    TitleButton *titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
    [titleButton setImage:[UIImage imageWithImageName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setTag:0];
    [titleButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 30);
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = IWColor(226, 226, 226);
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 20, 0)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}
/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 创建请求管理对象
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    Account *account = [IWAccountTool account];
    parameters[@"access_token"] = account.access_token;
    // 默认20条
    //    parameters[@"count"] = @1;
    // 封装请求
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        //        NSLog(@"==%@",responseObject);
        // 模型封装
        NSArray *statusesArray = [Status objectArrayWithKeyValuesArray:dictArray];
        
        NSMutableArray *array = [NSMutableArray array];
        for (Status *statuses in statusesArray) {
            StatusFrame *statusFrame = [[StatusFrame alloc]init];
            statusFrame.status = statuses;
            [array addObject:statusFrame];
        }
        self.statusesArray = array;
        
        //        NSLog(@"self.statues==%@",self.statuses);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error ==%@",error);
    }];
}

- (void)findFriend
{
    NSLog(@"findFriend");
}

- (void)pop
{
    NSLog(@"pop");
}
- (void)click:(UIButton *)button
{
    if (button.tag == 0) {
        [button setImage:[UIImage imageWithImageName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        button.tag = 1;
    }else{
        [button setImage:[UIImage imageWithImageName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        button.tag = 0;
    }
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statusesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //    NSDictionary *statuses = self.statuses[indexPath.row];
    //    NSLog(@"statuses ==%@",statuses);
    //    [cell.textLabel setText:statuses[@"text"]];
    //    NSDictionary *user = statuses[@"user"];
    //    [cell.detailTextLabel setText:user[@"name"]];
    //    // 此方法在主线程中，会出现错误
    //    NSString *path = user[@"profile_image_url"];
    
    
    // mj 模型
    cell.statusFrame = self.statusesArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *statusFrame = self.statusesArray[indexPath.row];
    return statusFrame.cellHeight;
}
@end
