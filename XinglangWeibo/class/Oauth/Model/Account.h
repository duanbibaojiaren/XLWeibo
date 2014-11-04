//
//  Account.h
//  xinlangweibo
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;
@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间
+ (id)accountWithDict:(NSMutableDictionary *)dict;
- (id)initWithDict:(NSMutableDictionary *)dict;
@end
