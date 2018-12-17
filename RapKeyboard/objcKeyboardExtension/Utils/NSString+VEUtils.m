//
//  NSString+VEUtils.m
//  rides
//
//  Created by Tomasz Dubik on 21/05/14.
//  Copyright (c) 2014 Tomasz Dubik Consulting. All rights reserved.
//

#import "NSString+VEUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (VEUtils)

- (NSString *)stringWithCamelCase
{
    NSRange rangeOfUnderscore = [self rangeOfString:@"_"];
    if(rangeOfUnderscore.location == NSNotFound){
        return self;
    }
    NSArray *components = [self componentsSeparatedByString:@"_"];
    NSMutableString *result = [NSMutableString stringWithString:components[0]];
    for(NSInteger i = 1; i < [components count]; ++i){
        [result appendString:[components[i] capitalizedString]];
    }
    return result;
}

- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
