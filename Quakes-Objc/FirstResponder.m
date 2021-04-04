//
//  FirstResponder.m
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/3/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "FirstResponder.h"

//@interface FirstResponder () {
//    NSString *myInternalName;
//}
//
//@end


@implementation FirstResponder

//@synthesize name = _name; // Default
@synthesize name = myInternalName;

// myFirstResponder.name = @"Name";
// [myFirstResponder setName:@"Name";
// msgSend(myFirstResponder, @selector(setName:), @"Name")

// NSString *name = myFirstResponder.name;
// NSString *name = [myFirstResponder name];

- (void)setName:(NSString *)aName
{
     // willSet
    
    myInternalName = aName.copy;
    
    // didSet
}

- (NSString *)name
{
    // willGet
    
    return myInternalName.copy;
}

@end
