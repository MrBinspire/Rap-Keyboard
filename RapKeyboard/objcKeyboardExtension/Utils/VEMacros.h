//
//  VEMacros
//  rides
//
//  Created by Tomasz Dubik on 11/12/13.
//  Copyright (c) 2013 Tomasz Dubik Consulting. All rights reserved.
//

#import "AppDelegate.h"
#import "VELogManager.h"

#ifndef rides_Header_h
#define rides_Header_h

#define VE_APPDELEGATE (AppDelegate*)[[UIApplication sharedApplication] delegate]

#ifdef DEBUG
#define VEDebugLog(fmt,...) NSLog(@"%@",[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);
#else
#define VEDebugLog(...)
#endif

// Log using the same parameters above but include the function name and source code line number in the log statement
#ifdef DEBUG
#define VEDebugLogDetailed(fmt, ...) [[VELogManager sharedInstance] logDebug:[NSString stringWithFormat:fmt, ##__VA_ARGS__]]// fromPath:[NSString stringWithFormat"Func: %s, Line: %d", __PRETTY_FUNCTION__, __LINE__]]
#define VELogErr(err)// if(err)VEDebugLogDetailed("%@",err);
#else
#define VEDebugLogDetailed(fmt,...) [[VELogManager sharedInstance] logDebug:[NSString stringWithFormat:fmt, ##__VA_ARGS__]]// fromPath:[NSString
#define VELogErr(err)
#endif

#define VE_AUTH_SERVER_URL [[[NSBundle mainBundle] infoDictionary] objectForKey:@"VEAPI_AUTH_URL"]
#define VE_MEDIA_SERVER_URL [[[NSBundle mainBundle] infoDictionary] objectForKey:@"VEAPI_MEDIA_URL"]
#define VE_NOTIFY_SERVER_URL [[[NSBundle mainBundle] infoDictionary] objectForKey:@"VEAPI_NOTIFY_URL"]

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

// This macro will create a detailed log message and run even during a production build
#define VELog(fmt, ...) NSLog((@"Func: %s, Line: %d, " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//IS_IPAD by checking idiom for iphone only application doesn't work
#define IS_IPAD ([[[UIDevice currentDevice].model lowercaseString] containsString:@"ipad"])
#define IS_IPHONE (!IS_IPAD)

static CGFloat kVEMenuWidth = 90.0;

typedef NS_ENUM(NSInteger, VEChatStatus){
    VEChatSending,
    VEChatSent,
    VEChatDelivered,
    VEChatRed
};

#endif
