//
//  Quake.m
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "Quake.h"

@implementation Quake

- (instancetype)init
{
    return [self initWithMagnitude:0
                             place:@""
                              time:NSDate.now
                          latitude:0
                         longitude:0
                              type:@""
                             alert:nil];
}

- (instancetype)initWithMagnitude:(double)aMagnitude
                            place:(NSString *)aPlace
                             time:(NSDate *)aTime
                         latitude:(double)aLatitude
                        longitude:(double)aLongitude
                             type:(NSString *)aType
                            alert:(NSString *)anAlert
{
    if (self = [super init]) {
        _magnitude = aMagnitude;
        _place = aPlace.copy;
        _time = aTime;
        _latitude = aLatitude;
        _longitude = aLongitude;
        _type = aType;
        _alert = anAlert;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSDictionary *properties = [aDictionary objectForKey: @"properties"];
    if (![properties isKindOfClass: NSDictionary.class]) return nil;
    
    NSNumber *magnitudeNumber = [properties objectForKey:@"mag"];
    if ([magnitudeNumber isKindOfClass:NSNull.class]) magnitudeNumber = nil;
    else if (![magnitudeNumber isKindOfClass:NSNumber.class]) return nil;
    
    NSString *place = [properties objectForKey:@"place"];
    if (![place isKindOfClass:NSString.class]) return nil;
    
    NSNumber *timeInMilliseconds = [properties objectForKey:@"time"];
    if (![timeInMilliseconds isKindOfClass:NSNumber.class]) return nil;
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:timeInMilliseconds.longValue/1000.];
    
    NSString *type = [properties objectForKey:@"type"];
    if (![type isKindOfClass:NSString.class]) return nil;
    
    NSString *alert = [properties objectForKey:@"alert"];
    if ([alert isKindOfClass:NSNull.class]) alert = nil;
    else if (![alert isKindOfClass:NSString.class]) return nil;
    
    NSDictionary *geometry = [aDictionary objectForKey:@"geometry"];
    if (![geometry isKindOfClass:NSDictionary.class]) return nil;
    
    NSArray *coordinates = [geometry objectForKey:@"coordinates"];
    if (![coordinates isKindOfClass:NSArray.class]) return nil;
    
    NSNumber *latitudeNumber = nil;
    NSNumber *longitudeNumber = nil;
    
    if (coordinates.count >= 2) {
        longitudeNumber = [coordinates objectAtIndex:0];
        latitudeNumber = [coordinates objectAtIndex:1];
        if (![latitudeNumber isKindOfClass:NSNumber.class]) return nil;
        if (![longitudeNumber isKindOfClass:NSNumber.class]) return nil;
    }
    
    return [self initWithMagnitude:magnitudeNumber.doubleValue
                             place:place
                              time:time
                          latitude:latitudeNumber.doubleValue
                         longitude:longitudeNumber.doubleValue
                              type:type
                             alert:alert];
}

- (NSDictionary *)dictionaryValue
{
    NSMutableDictionary *container = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *properties = [[NSMutableDictionary alloc] init];
    [container setObject:properties forKey:@"properties"];
    
    [properties setObject:@(self.magnitude) forKey:@"mag"];
    [properties setObject:self.place forKey:@"place"];
    [properties setObject:@(self.time.timeIntervalSince1970 * 1000) forKey:@"time"];
    [properties setObject:self.type forKey:@"type"];
    [properties setObject:(self.alert ?: NSNull.null) forKey:@"alert"];
    
    NSMutableDictionary *geometry = [[NSMutableDictionary alloc] init];
    [container setObject:geometry forKey:@"geometry"];
    
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    [geometry setObject:coordinates forKey:@"coordinates"];
    
    [coordinates addObject:@(self.latitude)];
    [coordinates addObject:@(self.longitude)];
    
    return container;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; M%.1f - %@>", NSStringFromClass(self.class), self, self.magnitude, self.place];
}

@end
