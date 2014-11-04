//
//  Status.m
//  xinlangweibo
//
//  Created by admin on 14-10-31.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "Status.h"
#import "User.h"
#import "MJExtension.h"
#import "NSDate+xl.h"
#import "Photo.h"
@implementation Status
// 将pic_urls 转化成model  photo
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [Photo class]};
}

- (NSString *)created_at
{
    //    "Fri Aug 28 00:00:00 +0800 2009
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *creDate = [formatter dateFromString:_created_at];
    if (creDate.isToday) {
        if (creDate.compentDate.minute <= 1 && creDate.compentDate.hour == 0)
        {
            NSLog(@"getvget");
            return @"刚刚";
        }else if ((creDate.compentDate.minute + creDate.compentDate.hour * 60) < 60){
            return [NSString stringWithFormat:@"%d分钟前",creDate.compentDate.minute + creDate.compentDate.hour * 60];
        }else{
            return [NSString stringWithFormat:@"%d小时前",creDate.compentDate.hour];
        }
        
    }else{
        // 昨天
        formatter.dateFormat = @"昨天 HH:mm";
        
        return [formatter stringFromDate:creDate];
    }
}

- (void)setSource:(NSString *)source
{
    int loc = [source rangeOfString:@">"].location + 1;
    int length = [source rangeOfString:@"</"].location - loc;
    source = [source substringWithRange:NSMakeRange(loc, length)];
    
    _source = [NSString stringWithFormat:@"来自%@", source];
}

@end
