//
//  NSDate+xl.h
//  xinlangweibo
//
//  Created by admin on 14-11-1.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (xl)
- (BOOL)isToday;
- (BOOL)isYesterday;
/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)compentDate;
@end
