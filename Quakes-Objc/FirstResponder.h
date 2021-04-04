//
//  FirstResponder.h
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/3/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstResponder : NSObject {
    // NSString *_name;
}


@property (nonatomic, copy) NSString *name;

/*
 
 Setter:
 - (void)setName:(NSString *)aName;
 
 Getter:
 - (NSString *)name;
 
 Instance Variable (in the class's @interface)
 NSString *_name;
 
 */

@end

NS_ASSUME_NONNULL_END
