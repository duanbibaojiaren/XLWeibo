//
//  IWAccountTool.h
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  账号管理工具类

#import <Foundation/Foundation.h>


@class Account;

@interface IWAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(Account *)account;

/**
 *  返回存储的账号信息
 */
+ (Account *)account;
@end
