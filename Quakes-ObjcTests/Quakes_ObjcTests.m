//
//  Quakes_ObjcTests.m
//  Quakes-ObjcTests
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LSILog.h"
#import "LSIFileHelper.h"
#import "Quake.h"
#import "QuakeResults.h"

@interface Quakes_ObjcTests : XCTestCase

@end

@implementation Quakes_ObjcTests

- (void)testQuakeParsing
{
    NSData *quakeData = loadFile(@"Quake.json", Quakes_ObjcTests.class);
    
//    NSLog(@"🤖 Quake (as data): %@", quakeData);
//    NSString *quakeJSONString = [[NSString alloc] initWithData:quakeData encoding:NSUTF8StringEncoding];
//    NSLog(@"🤖 Quake (as string): %@", quakeJSONString);
    
//    NSDictionary *quakeDictionary = [NSJSONSerialization JSONObjectWithData:quakeData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:NULL];
//    NSLog(@"🤖 Quake (as dictionary): %@", quakeDictionary);
    // Bit Masking
    // 0000 0001
    // 0000 0010
    // ==== ====
    // 0000 0011
    
    NSError *jsonError = nil;
    NSDictionary *quakeDictionary = [NSJSONSerialization JSONObjectWithData:quakeData options:0 error:&jsonError];
    
    XCTAssertNotNil(quakeDictionary);
    if (!quakeDictionary) {
        NSLog(@"🤖 We've got an error: %@", jsonError);
    }
    
    XCTAssertTrue([quakeDictionary isKindOfClass:NSDictionary.class]);
    if (![quakeDictionary isKindOfClass:NSDictionary.class]) {
        NSLog(@"🤖 quakeDictionary is now a dictionary!");
        return;
    }
    NSLog(@"🤖 Quake (as dictionary): %@", quakeDictionary);
    
    Quake *quake = [[Quake alloc] initWithDictionary:quakeDictionary];
    NSLog(@"🤖 Quake (as Quake): %@", quake);
    
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1388620296020 / 1000.0];
    
    XCTAssertEqualWithAccuracy(1.29, quake.magnitude, 0.0001);
    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
    XCTAssertEqualObjects(time, quake.time);
    XCTAssertNil(quake.alert);
    XCTAssertEqualObjects(@"earthquake", quake.type);
    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);
}

- (void)testQuakesParsing
{
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:1388620296020 / 1000.0];
    
    NSData *quakeData = loadFile(@"Quakes.json", [Quakes_ObjcTests class]);
    NSLog(@"quake: %@", quakeData); // Remove print statements in final code, only for "sanity check" when implementing
    
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:quakeData options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"JSON Parsing error: %@", jsonError);
    }
    
    QuakeResults *quakeResults = [[QuakeResults alloc] initWithDictionary:json];
    XCTAssertNotNil(quakeResults);
    XCTAssertEqual(2, quakeResults.quakes.count);
    
    NSLog(@"Quake Results: %@", quakeResults.quakes);
    
    Quake *quake = quakeResults.quakes[0];
    
    XCTAssertEqualWithAccuracy(1.29, quake.magnitude, 0.0001);
    XCTAssertEqualObjects(@"10km SSW of Idyllwild, CA", quake.place);
    XCTAssertEqualObjects(time, quake.time);
    
    XCTAssertNil(quake.alert);
    
    XCTAssertEqualObjects(@"earthquake", quake.type);
    XCTAssertEqualWithAccuracy(33.663333299999998, quake.latitude, 0.0001);
    XCTAssertEqualWithAccuracy(-116.7776667, quake.longitude, 0.0001);
}

@end
