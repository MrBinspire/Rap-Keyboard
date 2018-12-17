//
//  VESugestion.m
//  Arbo
//
//  Created by Marcin Mierzejewski on 21/08/2017.
//  Copyright © 2017 VESTIONE Sp. z o.o. All rights reserved.
//

#import "VESugestion.h"

@implementation VESugestion
- (BOOL)isEqual:(id)other
{
    if (other == self) {
        return YES;
    } else {
        
        if([other isKindOfClass:[VESugestion class]]){
            return [self.name isEqual:((VESugestion *)other).name];
        } else if([other isKindOfClass:[NSString class]]){
            return [self.name isEqual:other];
        } else {
            return NO;
        }
    }
}

- (NSUInteger)hash
{
    return [[self name] hash];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"VESugestion %@", self.name];
}


@end
