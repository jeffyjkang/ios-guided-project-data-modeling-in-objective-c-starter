//
//  ViewController.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSILog.h"
#import "FirstResponder.h"
#import "NSDateInterval+DayAdditions.h"
#import "QuakeFetcher.h"

typedef int(^ViewControllerOperationBlock)(int a, int b);

@interface ViewController ()

@property (nonatomic, copy) ViewControllerOperationBlock blockPropertyName;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Hey Quakes!");
    
    FirstResponder *firstResponder = [[FirstResponder alloc] init];
    
    NSLog(@"firstResponder: %@", firstResponder);
    NSLog(@"firstResponder.name: %@", firstResponder.name);
    
    // C: NULL
    // Primitives: 0, false, NO
    // Objective-C: nil
    // For NSArray contents, etc...: [NSNull null]
    
    firstResponder.name = @"Name";
    NSLog(@"firstResponder.name: %@", firstResponder.name);
    
    ViewControllerOperationBlock performMathOnNumbers = ^int(int a, int b) {
        return a + b;
    };
    
    int result = performMathOnNumbers(5, 8);
    NSLog(@"The sum is: %d", result);
    
    performMathOnNumbers = ^int(int a, int b) {
        return a * b;
    };
    
    result = performMathOnNumbers(5, 8);
    NSLog(@"The product is: %d", result);
    
    self.blockPropertyName = performMathOnNumbers;
    result = self.blockPropertyName(5, 8);
    NSLog(@"The product is: %d", result);
    
//    int c = 17;
    __block int c = 17;
    
    self.blockPropertyName = ^int(int a, int b) {
        NSLog(@"Before we do math, the first responder is: %@; c is %d", firstResponder.name, c);
        
        c = 12;
        
        return a * 2 + b * 3;
    };
    
    firstResponder = [[FirstResponder alloc] init];
    firstResponder.name = @"NewName";
    
    c = 42;
    
    result = self.blockPropertyName(5, 8);
    NSLog(@"The new result is: %d", result);
    NSLog(@"C is now: %d", result);
    
    // 1.
    [self doWorkWithOperation:^int(int a, int b) {
        // 3.
        return a * 3 - b * 2;
    }];
    // 6.
    [self doWorkWithOperation:NULL];
    
    NSDateInterval *dateInterval = [NSDateInterval lsi_dateIntervalByAddingDays:5];
    NSLog(@"The interval is %@", dateInterval);
    
    [QuakeFetcher fetchQuakesWithCompletionHandler:^(NSArray *quakes, NSError *error) {
        NSLog(@"Got this error: %@", error);
        NSLog(@"Got these quakes: %@", quakes);
    }];
}

- (void)doWorkWithOperation:(ViewControllerOperationBlock)operation
{
    if (operation == NULL) return;
//    if (!operation) return;
    
    // 2.
    int result = operation(5, 7);
    // 4.
    NSLog(@"The operation gave back: %d", result);
    // 5.
}


@end
