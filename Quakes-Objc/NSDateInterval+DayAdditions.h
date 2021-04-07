//
//  NSDateInterval+DayAdditions.h
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/7/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateInterval (DayAdditions)

+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)someDays;
+ (instancetype)lsi_dateIntervalByAddingDays:(NSInteger)someDays toDate:(NSDate *)aDate;

@end

NS_ASSUME_NONNULL_END
