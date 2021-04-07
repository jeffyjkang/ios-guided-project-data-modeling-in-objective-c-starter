//
//  QuakeFetcher.m
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/7/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "QuakeFetcher.h"
#import "NSDateInterval+DayAdditions.h"
#import "QuakeResults.h"
#import "Quake.h"
#import "LSIErrors.h"

static NSString *const QuakeFetcherBaseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";

@implementation QuakeFetcher

+ (void)fetchQuakesWithCompletionHandler:(QuakeFetcherCompletionHandler)completionHandler
{
    NSDateInterval *pastWeek = [NSDateInterval lsi_dateIntervalByAddingDays:-7];
    
    [self fetchQuakesInTimeInterval:pastWeek completionHandler:completionHandler];
}

+ (void)fetchQuakesInTimeInterval:(NSDateInterval *)interval completionHandler:(QuakeFetcherCompletionHandler)completionHandler
{
    if (!completionHandler) return;
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:QuakeFetcherBaseURLString];
    
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    
    NSString *startTimeString = [formatter stringFromDate:interval.startDate];
    NSString *endTimeString = [formatter stringFromDate:interval.endDate];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:@"format" value:@"geojson"],
        [NSURLQueryItem queryItemWithName:@"starttime" value:startTimeString],
        [NSURLQueryItem queryItemWithName:@"endtime" value:endTimeString]
    ];
    
    NSURL *url = urlComponents.URL;
    NSLog(@"Fetching Quakes: %@", url);
    
//    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        <#code#>
//    }];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url
                               completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching quakes: %@", error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, error);
            });
            
            return;
        }
        
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!dictionary || ![dictionary isKindOfClass:NSDictionary.class]) {
            NSLog(@"Error decoding JSON: %@", jsonError);
            return;
        }
        
        QuakeResults *results = [[QuakeResults alloc] initWithDictionary:dictionary];
        if (!results) {
            
            NSError *apiError = errorWithMessage(@"Invalid JSON dictionary", LSIAPIError);
            
            NSLog(@"Error decoding results dictionary: %@", apiError);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(nil, apiError);
            });
            
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(results.quakes, nil);
        });
        
    }] resume];
}

@end
