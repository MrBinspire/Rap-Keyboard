//
//  UIImage+VEUtils.h
//  rides
//
//  Created by Tomasz Dubik on 08/01/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VEGlobalDef.h"

@interface UIImage (VEUtils)

- (UIImage *)ve_roundedImageWithRect:(CGRect )rect;

- (UIImage *)ve_scaleImageToSize:(CGSize)newSize;
- (UIImage *)ve_scaleImageToSize:(CGSize)newSize fill:(BOOL)fill;

//+ (UIImage *)ve_imageWithColor:(UIColor *)color;
- (UIImage *)ve_croppedImageForWidth:(CGFloat )width;
- (UIImage *)ve_croppedImageWithSize:(CGSize )size;

- (UIImage *)ve_fixOrientation;

@end
