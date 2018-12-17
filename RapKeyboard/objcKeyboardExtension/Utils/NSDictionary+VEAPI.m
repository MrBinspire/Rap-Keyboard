//
//  NSDictionary+VEAPI.m
//  rides
//
//  Created by Tomasz Dubik on 16/12/14.
//  Copyright (c) 2014 Tomasz Dubik Consulting. All rights reserved.
//

#import "NSDictionary+VEAPI.h"
#import <UIKit/UIKit.h>

@implementation NSDictionary (VEAPI)

- (NSString *)errorMessage
{
    return self[@"error"];
}

- (NSString *)urlWithScale
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    if(scale == 2.0){
        return [self objectForKey:@"retina"];
    }else if (scale == 3.0){
        return [self objectForKey:@"plus"];
    }
    return [self objectForKey:@"plus"];
}

- (BOOL)hasValidObjectForKey:(NSString *)key
{
    NSObject *object = [self objectForKey:key];
    if(!object){
        return NO;
    }
    if([object isEqual:[NSNull null]]){
        return NO;
    }
    return YES;
}

- (id)validObjectForKey:(NSString *)key
{
    if([self hasValidObjectForKey:key]){
        return [self objectForKey:key];
    }else{
        return nil;
    }
}

@end
