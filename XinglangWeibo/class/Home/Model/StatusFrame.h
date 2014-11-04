//
//  StatusFrame.h
//  xinlangweibo
//
//  Created by admin on 14-11-1.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 昵称的字体 */
#define IWStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define IWRetweetStatusNameFont IWStatusNameFont

/** 时间的字体 */
#define IWStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define IWStatusSourceFont IWStatusTimeFont

/** 正文的字体 */
#define IWStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define IWRetweetStatusContentFont IWStatusContentFont
@class Status;
@interface StatusFrame : NSObject
- (CGRect)timeLabelFrame;
@property (nonatomic, strong) Status *status;
/** 顶部的view */
@property (nonatomic, assign) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign) CGRect retweetPhotoViewF;

/** 微博的工具条 */
@property (nonatomic, assign) CGRect statusToolbarF;
/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;
@end
