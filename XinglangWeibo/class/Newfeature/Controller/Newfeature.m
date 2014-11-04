//
//  Newfeature.m
//  xinlangweibo
//
//  Created by admin on 14-10-28.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "Newfeature.h"
#import "TabBarViewController.h"
@interface Newfeature ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation Newfeature

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupScrollView];
    [self setupPageControl];
}

// 添加scrollview
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    scrollView.frame = self.view.bounds;
    //    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
	// Do any additional setup after loading the view.
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index<3; index++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index + 1];
        imageView.image = [UIImage imageWithImageName:name];
        
        // 设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        // 在最后一个图片上面添加按钮
        if (index == 3 - 1) {
            [self setupLastImageView:imageView];
        }

    }
    
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * 3, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让imageView能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [startButton setBackgroundImage:[UIImage imageWithImageName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithImageName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 2.设置frame
    CGFloat centerX = imageView.frame.size.width * 0.5;
    CGFloat centerY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(centerX, centerY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 3.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    // 4.添加checkbox
    UIButton *checkbox = [[UIButton alloc] init];
    checkbox.selected = YES;
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithImageName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkbox setImage:[UIImage imageWithImageName:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    CGFloat checkboxCenterX = centerX;
    CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
    checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
    [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    //    checkbox.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    //    checkbox.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [imageView addSubview:checkbox];
}
- (void)checkboxClick:(UIButton *)button
{
    button.selected = !button.selected;
}
- (void)start
{
    // 显示状态栏
//    [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器

    [self.view.window setRootViewController:[[TabBarViewController alloc]init]];
}
/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
    pageControl.numberOfPages = 3;
    CGFloat centerX = self.view.bounds.size.width * 0.5;
    CGFloat centerY = self.view.bounds.size.height * 0.8;
    [pageControl setCenter:CGPointMake(centerX, centerY)];
    [pageControl setBounds:CGRectMake(0, 0, 100, 30)];
    [self.view addSubview:pageControl];
    
    // 设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
