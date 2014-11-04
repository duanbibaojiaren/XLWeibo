//
//  Account.m
//  xinlangweibo
//
//  Created by admin on 14-10-29.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "Account.h"

@implementation Account
+ (id)accountWithDict:(NSMutableDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
- (id)initWithDict:(NSMutableDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    };
    return self;
}
- (id)initWithCoder:(NSCoder *)decode
{
    if (self = [super init]) {
        //        NSLog(@"decode==%@",decode);
        self.access_token = [decode decodeObjectForKey:@"access_token"];
        self.expires_in = [decode decodeInt64ForKey:@"expires_in"];
        self.remind_in = [decode decodeInt64ForKey:@"remind_in"];
        self.uid = [decode decodeInt64ForKey:@"uid"];
        self.expiresTime = [decode decodeObjectForKey:@"expiresTime"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encode
{
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeInt64:self.expires_in forKey:@"expires_in"];
    [encode encodeInt64:self.remind_in forKey:@"remind_in"];
    [encode encodeInt64:self.uid forKey:@"uid"];
    [encode encodeObject:self.expiresTime forKey:@"expiresTime"];
}
@end
