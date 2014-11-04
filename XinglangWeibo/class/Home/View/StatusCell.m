//
//  StatusCell.m
//  xinlangweibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "StatusCell.h"
#import "Status.h"
#import "StatusToolbar.h"
#import "UIImage+tabbarView.h"
#import "StatusTopView.h"
@interface StatusCell()
/** 顶部的view */
@property (nonatomic, weak) StatusTopView *topView;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) UIImageView *retweetView;

/** 微博的工具条 */
@property (nonatomic, weak) StatusToolbar *statusToolbar;

@end
@implementation StatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // 1. 添加微博Top子控件
        [self setupTopView];
        
        // 2. 添加微博的工具条
        [self setupStatusToolBar];
        
        
    }
    return self;
}
- (void)setupTopView
{
    self.backgroundColor = [UIColor clearColor];
    StatusTopView *topView = [[StatusTopView alloc]init];
    self.topView = topView;
    [self.contentView addSubview:topView];
    
}

- (void)setupStatusToolBar
{
    /** 1.微博的工具条 */
    StatusToolbar *statusToolbar = [[StatusToolbar alloc] init];
    self.statusToolbar = statusToolbar;
    [self.contentView addSubview:statusToolbar];
}
/**
 *  传递Frame模型数据
 */
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    // 原创微博数据
    [self setupTopViewData];
    // toolbar
    [self setupToolbar];
}

- (void)setupTopViewData
{
    /** 顶部的view */
    [self.topView setFrame:self.statusFrame.topViewF];
    [self.topView setStatusFrame:self.statusFrame];
}

- (void)setupToolbar
{
    self.statusToolbar.frame = self.statusFrame.statusToolbarF;
    [self.statusToolbar setStatuses:self.statusFrame.status];
    
}

// 拦截frame的设置
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 20;
    frame.size.height -= 10;
    [super setFrame:frame];
}

@end
