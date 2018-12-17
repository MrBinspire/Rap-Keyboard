//
//  VEGlobalDef.h
//  rides
//
//  Created by Tomasz Dubik on 15/01/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

extern NSString *const kVENotificationConversationUpdated;
extern NSString *const kVEGoogleAPIKey;
extern NSString *const kVEBrowserGoogleAPIKey;

extern NSString *const kVEAddressKeyLocation;
extern NSString *const kVEAddressKeyStreetName;
extern NSString *const kVEAddressKeyStreetNumber;
extern NSString *const kVEAddressKeyCity;
extern NSString *const kVEAddressKeyState;
extern NSString *const kVEAddressKeyCountry;
extern NSString *const kVEAddressKeyPostalCode;
extern NSString *const kVEAddressKeyGooglePlaceId;
extern NSString *const kVEAddressKeyFormattedAddress;

//UI
static CGFloat kVEUIMarginLeft = 15.0;
static CGFloat kVEUIMarginTop = 15.0;
static CGFloat kVEUIMarginRidePointsLeft = 70.0;
static CGFloat kVEUIHeightGreenSection = 30.0;
static CGFloat kVEUIDefaultFontMediumSize = 15.0;
static CGFloat kVEUIDefaultAvatarSize = 40.0;
static CGFloat kVEUIDefaultRideMenuSize = 40.0;
static CGFloat kVEUISearchHeaderSize = 140.0;
//Notifications
extern NSString *const kVENotificationRidesRefreshedIncoming;
extern NSString *const kVENotificationRidesRefreshedArchived;
extern NSString *const kVENotificationRidesRefreshedFeed;
extern NSString *const kVENotificationUserLoggedIn;
extern NSString *const kVENotificationUserLoggedOut;extern NSString *const kVEAddressKeyFormattedAddress;
extern NSString *const kVEShoutTypeCamera;// = @"camera";
extern NSString *const kVEShoutTypePolice;// = @"police";
extern NSString *const kVEShoutTypeWarning;// = @"warning";
extern NSString *const kVEShoutTypeChat;// = @"chat";
extern NSString *const kVEShoutTypeTrafficJam;
extern NSString *const kVEShoutSubTypeCameraStationary;// = @"camera_stationary";
extern NSString *const kVEShoutSubTypeCameraTrafficLight;// = @"camera_traffic_light";
extern NSString *const kVEShoutSubTypeCameraFake;// = @"camera_fake";
extern NSString *const kVEShoutSubTypeCameraSsugestioneRoad;// = @"camera_ssugestione_road";
extern NSString *const kVEShoutSubTypeHeavyTrafficJam;// = @"heavy_traffic_jam";
extern NSString *const kVEShoutSubTypeModerateTrafficJam;// = @"moderate_traffic_jam";
extern NSString *const kVEShoutSubTypeWarningConstructions;// = @"warning_construction";
extern NSString *const kVEShoutSubTypeWarningAccident;// = @"warning_acciddent";
extern NSString *const kVEShoutSubTypeWarningWeather;// = @"warning_weather";
extern NSString *const kVEShoutSubTypePoliceWithCam;// = @"police_with_cam";
extern NSString *const kVEShoutSubTypePoliceStandStill;// = @"police_stand_still";
extern NSString *const kVEShoutSubTypePoliceUndercover;// = @"police_undercover";

static CGFloat kVEDefaultMargin = 14.0;

typedef NS_ENUM(NSInteger, VEAddMenuItemType){
    VEAddMenuItemLens = 0,
    VEAddMenuItemJam,
    VEAddMenuItemCamera,
    VEAddMenuItemCaution,
    VEAddMenuItemChat,
    VEAddmenuItemNone
};

typedef void(^VESimpleCallback)();
