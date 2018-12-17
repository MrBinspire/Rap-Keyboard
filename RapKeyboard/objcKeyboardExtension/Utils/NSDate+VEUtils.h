//
//  NSDate+VEUtils.h
//  rides
//
//  Created by Tomasz Dubik on 3/31/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (VEUtils)
- (NSDate *)dayDate;
- (BOOL)hasTheSameDayAsDate:(NSDate *)date;
- (NSString *)stringSocialFromDate;

+ (NSDate *)ve_yesterday;
+ (NSDate *)ve_lastWeekDay;
+ (NSDate *)ve_lastMonthDate;
+ (NSDate *)ve_today;

@end
