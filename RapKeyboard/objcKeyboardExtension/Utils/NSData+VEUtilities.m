//
//  NSData+VEUtilities.m
//  rides
//
//  Created by Tomasz Dubik on 06/01/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import "NSData+VEUtilities.h"

@implementation NSData (VEUtilities)

- (NSString *)HEXPushToken
{
    NSUInteger capacity = [self length];
    NSMutableString *stringBuffer = [NSMutableString stringWithCapacity:capacity];
    const unsigned char *dataBuffer = [self bytes];
    
    // Iterate over the bytes
    for (int i=0; i < [self length]; i++) {
        
        [stringBuffer appendFormat:@"%02.2hhX", dataBuffer[i]];
    }
    return stringBuffer;
}


@end
