//
//  NSDate+xl.m
//  xinlangweibo
//
//  Created by admin on 14-11-1.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "NSDate+xl.h"

@implementation NSDate (xl)
// 判断是否为今天
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear |  NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *creatDate = [calendar components:unit fromDate:self ];
    NSDateComponents *currentDate = [calendar components:unit fromDate:[NSDate date]];
    
    return (creatDate.year == currentDate.year) &&
    (creatDate.month == currentDate.month) &&
    (creatDate.day == currentDate.day)
    ;
}
- (BOOL)isYesterday
{
    // 2014-05-01
    
    // 2014-04-30
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay |NSCalendarUnitMonth |NSCalendarUnitYear| NSCalendarUnitHour| NSCalendarUnitMinute;
    NSDateComponents *compentDate = [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
    
    return compentDate.day == 1;
}
- (NSDateComponents *)compentDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear |  NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *compentDate = [calendar components:unit fromDate:self toDate:[NSDate date] options:NO];
    return compentDate;
}
@end
