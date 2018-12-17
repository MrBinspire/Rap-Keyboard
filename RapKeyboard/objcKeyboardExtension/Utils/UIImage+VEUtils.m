//
//  UIImage+VEUtils.m
//  rides
//
//  Created by Tomasz Dubik on 08/01/15.
//  Copyright (c) 2015 Tomasz Dubik Consulting. All rights reserved.
//

#import "UIImage+VEUtils.h"

@implementation UIImage (VEUtils)

- (UIImage *)ve_roundedImageWithRect:(CGRect )rect
{
    CGRect bounds = rect;
    CGRect insetRect = CGRectInset(bounds, 1.0, 1.0);
    CGRect offsetRect = insetRect;
    offsetRect.origin = CGPointZero;
    
    UIImage *scaledImage = [self ve_scaleImageToSize:offsetRect.size fill:YES];
    CGRect cropRect = CGRectMake(floorf(scaledImage.size.width - offsetRect.size.width) * self.scale, floorf(scaledImage.size.height - offsetRect.size.height) * self.scale, offsetRect.size.width * self.scale, offsetRect.size.height * self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
    scaledImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    UIGraphicsBeginImageContextWithOptions(insetRect.size, NO, self.scale);
    CGContextRef imgContext = UIGraphicsGetCurrentContext();
    CGPathRef clippingPath = [UIBezierPath bezierPathWithRoundedRect:offsetRect cornerRadius:30.0].CGPath;
    CGContextAddPath(imgContext, clippingPath);
    CGContextClip(imgContext);
    // Draw the image
    [scaledImage drawInRect:offsetRect];
    // Get the image
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage *)ve_scaleImageToSize:(CGSize)newSize
{
    return [self ve_scaleImageToSize:newSize fill:NO];
}

- (UIImage *)ve_scaleImageToSize:(CGSize)newSize fill:(BOOL)fill
{
    CGRect scaledImageRect = CGRectZero;
    
    CGFloat aspectWidth = newSize.width / self.size.width;
    CGFloat aspectHeight = newSize.height / self.size.height;
    CGFloat aspectRatio = MIN ( aspectWidth, aspectHeight );
    if(fill){
        aspectRatio = MAX ( aspectWidth, aspectHeight );
    }
    
    scaledImageRect.size.width = self.size.width * aspectRatio;
    scaledImageRect.size.height = self.size.height * aspectRatio;
    //    scaledImageRect.origin.x = (newSize.width - scaledImageRect.size.width) / 2.0f;
    //    scaledImageRect.origin.y = (newSize.height - scaledImageRect.size.height) / 2.0f;
    
//    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
//    scaledImage = [UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:self.imageOrientation];
//    CGImageRelease(imageRef);
//    
    
    UIGraphicsBeginImageContextWithOptions( scaledImageRect.size, NO, [[UIScreen mainScreen] scale] );
    [self drawInRect:scaledImageRect];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage *)ve_croppedImageForWidth:(CGFloat )width
{
    UIImage *scaledImage = self;
    if(self.size.width > width)
        scaledImage = [self ve_scaleImageToSize:CGSizeMake(width, self.size.height)];
    
    CGFloat height = floorf(scaledImage.size.width / 1.91);
    CGRect bounds = CGRectMake(0, 0, scaledImage.size.width, height);
    CGRect offsetRect = bounds;
    offsetRect.origin = CGPointZero;
    
    CGRect cropRect = CGRectMake(floorf(scaledImage.size.width - offsetRect.size.width) * self.scale * 0.5, floorf(scaledImage.size.height - offsetRect.size.height) * [[UIScreen mainScreen] scale] * 0.5, offsetRect.size.width * self.scale, offsetRect.size.height * [[UIScreen mainScreen] scale]);
    CGImageRef imageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
    scaledImage = [UIImage imageWithCGImage:imageRef scale:[[UIScreen mainScreen] scale] orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
//    scaledImage = [scaledImage rotate:self.imageOrientation];
    
//    UIGraphicsBeginImageContextWithOptions(offsetRect.size, NO, self.scale);
//    CGContextRef imgContext = UIGraphicsGetCurrentContext();
//    CGPathRef clippingPath = [UIBezierPath bezierPathWithRoundedRect:offsetRect cornerRadius:30.0].CGPath;
//    CGContextAddPath(imgContext, clippingPath);
//    CGContextClip(imgContext);
//    // Draw the image
//    [scaledImage drawInRect:offsetRect];
//    // Get the image
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)ve_croppedImageWithSize:(CGSize )size
{
    UIImage *scaledImage = self;
    if(self.size.width > size.width){
        scaledImage = [self ve_scaleImageToSize:CGSizeMake(size.width, size.height) fill:YES];
    }
    [scaledImage ve_fixOrientation];
    
    CGFloat scale = scaledImage.scale;
    CGRect offsetRect = CGRectMake(0.0, 0.0, size.width, size.height);
    CGRect cropRect = CGRectMake(floorf(scaledImage.size.width - offsetRect.size.width) * scale * 0.5, floorf(scaledImage.size.height - offsetRect.size.height) * scale * 0.5, offsetRect.size.width * scale, offsetRect.size.height * scale);

    CGImageRef imageRef = CGImageCreateWithImageInRect([scaledImage CGImage], cropRect);
    scaledImage = [UIImage imageWithCGImage:imageRef scale:scale orientation:scaledImage.imageOrientation];
    CGImageRelease(imageRef);

    return scaledImage;
}


- (UIImage *)ve_fixOrientation
{
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end
