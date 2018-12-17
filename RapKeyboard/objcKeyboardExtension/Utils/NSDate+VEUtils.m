//
//  NSDate+VEUtils.m
//  rides
//
//  Created by Tomasz Dubik on 3/31/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import "NSDate+VEUtils.h"

@implementation NSDate (VEUtils)

- (NSDate *)dayDate
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    return [calendar dateFromComponents:comp1];
}

- (BOOL)hasTheSameDayAsDate:(NSDate *)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date];
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

- (NSString *)stringSocialFromDate
{
    NSDate * today = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:self toDate:today options:0];
    if(components.day == 1){
        return [NSString stringWithFormat:@"%@ %@",@(components.day), NSLocalizedString(@"day ago", @"one day")];
    }else if(components.day > 1){
        return [NSString stringWithFormat:@"%@ %@",@(components.day), NSLocalizedString(@"days ago", @"many days")];
    }else if( components.hour > 1 && components.hour < 24){
        return [NSString stringWithFormat:@"%@ %@",@(components.hour), NSLocalizedString(@"hours ago", @"hours plural")];
    }else if(components.hour == 1){
        return [NSString stringWithFormat:@"%@ %@",@(components.hour), NSLocalizedString(@"hour ago", @"one hour")];
    }else if(components.minute == 1){
        return [NSString stringWithFormat:@"%@ %@",@(components.minute), NSLocalizedString(@"minute ago", @"one minute")];
    }else if(components.minute > 1){
        return [NSString stringWithFormat:@"%@ %@",@(components.minute), NSLocalizedString(@"minutes ago", @"many minutes")];
    }else if(components.minute == 0){
        return NSLocalizedString(@"now", @"date string now");
    }
    return @"";
}

+ (NSDate *)ve_lastWeekDay{
    NSDate *now = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:now];
    
    [comps setDay:[comps day] - 7];
    NSDate *lastWeekDate = [calendar dateFromComponents:comps];
    return lastWeekDate;
}

+ (NSDate *)ve_lastMonthDate
{
    NSDate *now = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:now];
    [comps setMonth:[comps month]];
    [comps setDay:0];
    
    NSDate *lastMonthDate = [calendar dateFromComponents:comps];
    return lastMonthDate;
}

+ (NSDate *)ve_yesterday
{
    NSDate *now = [NSDate dateWithTimeIntervalSinceNow:-86400];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:now];
    [comps setHour:0];
    return [calendar dateFromComponents:comps];
}

+ (NSDate *)ve_today
{
    NSDate *now = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay | NSCalendarUnitHour fromDate:now];
    [comps setHour:0];
    return [calendar dateFromComponents:comps];
}


@end
