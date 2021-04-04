//
//  QuakeResults.h
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Quake;

NS_ASSUME_NONNULL_BEGIN

@interface QuakeResults : NSObject

- (instancetype)initWithQuakes:(NSArray<Quake *> *)quakes NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWithDictionary:(NSDictionary *)aDictionary;

@property (nonatomic, readonly, copy) NSArray<Quake *> *quakes;

@end

NS_ASSUME_NONNULL_END
