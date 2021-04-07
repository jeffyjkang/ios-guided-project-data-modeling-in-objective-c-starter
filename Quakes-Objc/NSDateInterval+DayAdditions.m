//
//  NSDateInterval+DayAdditions.m
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/7/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "NSDateInterval+DayAdditions.h"

@implementation NSDateInterval (DayAdditions)

+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)someDays
{
    return [self lsi_dateIntervalByAddingDays:someDays toDate:NSDate.now];
}

+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)someDays toDate:(NSDate *)aDate
{
    NSDate *startDate = nil;
    NSDate *endDate = nil;
    
    if (someDays < 0) {
        endDate = aDate;
        startDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay
                                                           value:someDays
                                                          toDate:endDate
                                                         options:0];
    } else {
        startDate = aDate;
        endDate = [NSCalendar.currentCalendar dateByAddingUnit:NSCalendarUnitDay
                                                         value:someDays
                                                        toDate:startDate
                                                       options:0];
    }
    return [[self alloc] initWithStartDate:startDate endDate:endDate];
}

@end
