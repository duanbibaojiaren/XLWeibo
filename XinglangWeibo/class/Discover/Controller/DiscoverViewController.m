//
//  DiscoverViewController.m
//  新浪微博
//
//  Created by admin on 14-10-21.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SearchBar.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        SearchBar *searchBar = [SearchBar search];
        // 尺寸
        searchBar.frame = CGRectMake(0, 0, 300, 30);
        // 设置中间的标题内容
        self.navigationItem.titleView = searchBar;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
