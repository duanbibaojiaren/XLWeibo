//
//  User.h
//  xinlangweibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
/**
 *  用户的ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  用户的头像
 */
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员图标 */
@property (nonatomic, assign, getter = isVip) BOOL vip;
@end
