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
#import "HttpTool.h"
#import "Account.h"
#import "IWAccountTool.h"
#import "UIImageView+WebCache.h"
#import "TitleButton.h"
#import "User.h"
#import "MJExtension.h"
#import "StatusFrame.h"
#import "StatusCell.h"
#import "Status.h"
static NSString *CellIdentifier = @"myCell";
@interface HomeViewController ()
//@property (nonatomic, strong) NSArray *statuses;
@property (nonatomic, strong) NSMutableArray *statusesArrayM;

@end

@implementation HomeViewController

- (NSMutableArray *)statusesArrayM
{
    if (_statusesArrayM == nil) {
        _statusesArrayM = [NSMutableArray array];
    }
    return _statusesArrayM;
}

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
    
     // 下拉列表
    [self setupRefreshView];
    
    [self setupNav];
    
    
    [self.tableView registerClass:[StatusCell class] forCellReuseIdentifier:CellIdentifier];
}
- (void)setupRefreshView
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    [refreshControl beginRefreshing];
    [self refreshControlStateChange:refreshControl];
}

/**
 *  监听刷新控件的状态改变(手动进入刷新状态才会调用这个方法)
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    Account *account = [IWAccountTool account];
    
    dict[@"access_token"] = account.access_token;
    dict[@"count"] = @5;
    if (self.statusesArrayM.count) {
        StatusFrame *statusFrame = self.statusesArrayM[0];
        // 加载ID比since_id大的微博
        dict[@"since_id"] = @([statusFrame.status.idstr longLongValue]);
    }

    
    [HttpTool getWithUrl:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dict success:^(id responseObject) {
        NSArray *dictArray = responseObject[@"statuses"];
        
        // 模型封装
        NSArray *statusesArray = [Status objectArrayWithKeyValuesArray:dictArray];
        
        NSMutableArray *array = [NSMutableArray array];
        for (Status *statuses in statusesArray) {
            StatusFrame *statusFrame = [[StatusFrame alloc]init];
            statusFrame.status = statuses;
            [array addObject:statusFrame];
        }
        
        // 新旧数据连接
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObjectsFromArray:array];
        [tempArray addObjectsFromArray:self.statusesArrayM];
        self.statusesArrayM = tempArray;
        
        [self.tableView reloadData];
        [refreshControl endRefreshing];
        // 显示刷新了多少数据
        [self showCount:array.count];

    } failure:^(NSError *error) {
         [refreshControl endRefreshing];
    }];

}
#pragma make - 显示刷新了多少数据
- (void)showCount:(int)count
{
    UIButton *but = [[UIButton alloc]init];
    [but setFrame:CGRectMake(0, 34, self.view.bounds.size.width, 30)];
    [but setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    [but setUserInteractionEnabled:NO];
    [self.navigationController.view insertSubview:but belowSubview:self.navigationController.navigationBar];
    
    if (count) {
        [but setTitle:[NSString stringWithFormat:@"共有%d条新的微博",count] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }else{
        [but setTitle:[NSString stringWithFormat:@"没有新的微博数据"] forState:UIControlStateNormal];
    }
    [UIView animateWithDuration:1.0 animations:^{
        but.transform = CGAffineTransformMakeTranslation(0, 30 + 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            but.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [but removeFromSuperview];
        }];
    }];
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
    // 获取用户名
    Account *account = [IWAccountTool account];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"access_token"] = account.access_token;
    dict[@"uid"] = [NSString stringWithFormat:@"%lld",account.uid];

    [HttpTool getWithUrl:@"https://api.weibo.com/2/users/show.json" parameters:dict success:^(id responseObject) {
        NSDictionary *dict = responseObject;
        NSString *name = dict[@"screen_name"];
        titleButton.name = name;
    } failure:^(NSError *error) {
          NSLog(@"error%@",error);
    }];
 
    [titleButton setImage:[UIImage imageWithImageName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setTag:0];
    [titleButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    // 位置和尺寸

    titleButton.frame = CGRectMake(0, 0, 150, 30);
    self.navigationItem.titleView = titleButton;
    
    self.tableView.backgroundColor = IWColor(226, 226, 226);
    [self.tableView setContentInset:UIEdgeInsetsMake(70, 0, 10, 0)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    // Return the number of rows in the section.
    return self.statusesArrayM.count;
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
    cell.statusFrame = self.statusesArrayM[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *statusFrame = self.statusesArrayM[indexPath.row];
    return statusFrame.cellHeight;
}
@end
