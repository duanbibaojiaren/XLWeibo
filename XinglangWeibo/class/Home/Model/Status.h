//
//  Status.h
//  xinlangweibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Status : NSObject
/**
 *  微博的内容(文字)
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博的来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  微博的时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  微博的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博的单张配图   配图
 */
//@property (nonatomic, copy) NSString *thumbnail_pic;
@property (nonatomic, strong) NSArray *pic_urls;



/** 被转发微博的信息 */
@property (nonatomic, strong) Status *retweeted_status;
/**
 *  微博的转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  微博的评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  微博的表态数(被赞数)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  微博的作者
 */
@property (nonatomic, strong) User *user;
@end
