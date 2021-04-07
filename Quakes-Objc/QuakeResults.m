//
//  QuakeResults.m
//  Quakes-Objc
//
//  Created by Jeff Kang on 4/4/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "QuakeResults.h"
#import "Quake.h"

@implementation QuakeResults

- (instancetype)init
{
    return [self initWithQuakes:@[]];
}

-(instancetype)initWithQuakes:(NSArray<Quake *> *)someQuakes
{
    if (self = [super init]) {
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"magnitude" ascending:NO];
        
//        _quakes = someQuakes.copy;
        _quakes = [someQuakes sortedArrayUsingDescriptors:@[sortDescriptor]];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
    NSArray *quakeDictionaries = [aDictionary objectForKey:@"features"];
    if (![quakeDictionaries isKindOfClass:NSArray.class]) return nil;
    
    NSMutableArray *quakes = [[NSMutableArray alloc] initWithCapacity:quakeDictionaries.count];
    
    for (NSDictionary *quakeDictionary in quakeDictionaries) {
        if (![quakeDictionary isKindOfClass:NSDictionary.class]) continue;
        
        Quake *quake = [[Quake alloc] initWithDictionary:quakeDictionary];
        
        if (quake) {
            [quakes addObject:quake];
        } else {
            // TODO: One of our required fields might be optional and we may need to debug this with real data
            NSLog(@"Unable to parse quake dictionary: %@", quakeDictionary);
        }
    }
    return [self initWithQuakes:quakes];
}

@end
