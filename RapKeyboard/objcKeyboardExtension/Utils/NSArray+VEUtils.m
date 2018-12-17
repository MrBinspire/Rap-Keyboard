//
//  NSArray+VEUtils.m
//  rides
//
//  Created by Tomasz Dubik on 06/01/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import "NSArray+VEUtils.h"

@implementation NSArray (VEUtils)

- (NSMutableDictionary *)cacheWithKeyPath:(NSString *)keyPath
{
    if( [self count] == 0 )
        return [NSMutableDictionary dictionary];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for(NSObject *object in self){
        if([object valueForKeyPath:keyPath]){
            [result setObject:object forKey:[object valueForKeyPath:keyPath]];
        }
    }
    return result;
}


@end
