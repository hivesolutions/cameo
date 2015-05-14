// Hive Cameo Framework
// Copyright (C) 2008-2015 Hive Solutions Lda.
//
// This file is part of Hive Cameo Framework.
//
// Hive Cameo Framework is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Cameo Framework is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Cameo Framework. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#include "UIImage+HMImageUtil.h"

@implementation UIImage(HMImageUtil)

- (UIImage *)scaleImage:(CGSize)size {
    // calulates the scale factor value, taking into account
    // the with of the current image instance
    float scaleFactor = size.width / self.size.width;

    // re-calculates the new width and height values using the
    // scale factor that has just been calculated
    float width = self.size.width * scaleFactor;
    float height = self.size.height * scaleFactor;

    // creates a new graphic context for the (new) scaled image
    // and then draws the current image to the created context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // returns the (final) scaled image object to the caller
    // method so that it may be used for operations
    return scaledImage;
}

- (UIImage *)roundWithRadius:(NSUInteger)radius {
    return [self roundWithWidth:radius height:radius];
}

- (UIImage *)roundWithWidth:(NSUInteger)ovalWidth height:(NSUInteger)ovalHeight {
    // in case the provided with or height is zero
    // must return immediately (invalid values)
    if(ovalWidth == 0 || ovalHeight == 0) { return self; }

    // retrieves the scale factor currently in use from
    // the image object (scale in object)
    float scaleFactor = self.scale;

    // retrieves both dimensions of the current image
    // object, to be used in the new context
    int width = self.size.width;
    int height = self.size.height;
    int widthS = width * scaleFactor;
    int heightS = height * scaleFactor;

    // creates a new color space object and uses it to create
    // a new bitmap context for drawing of the new image then
    // sets the correct scale for the creeated context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(
        NULL, widthS, heightS, 8, widthS * 4, colorSpace, (CGBitmapInfo) kCGImageAlphaPremultipliedFirst
    );
    CGContextScaleCTM(context, scaleFactor, scaleFactor);

    // creates a new path in the context and a rectangle with
    // the same size
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, width, height);

    // allocates space for the "scaled" oval width and
    // height values to be calculated and used
    float ovalWidthS;
    float ovalHeightS;

    // creates a series of arc objects to be used to mask
    // the image to be drawn in the context
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    ovalWidthS = CGRectGetWidth(rect) / ovalWidth;
    ovalHeightS = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, ovalWidthS, ovalHeightS / 2);
    CGContextAddArcToPoint(context, ovalWidthS, ovalHeightS, ovalWidthS / 2, ovalHeightS, 1);
    CGContextAddArcToPoint(context, 0, ovalHeightS, 0, ovalHeightS / 2, 1);
    CGContextAddArcToPoint(context, 0, 0, ovalWidthS / 2, 0, 1);
    CGContextAddArcToPoint(context, ovalWidthS, 0, ovalWidthS, ovalHeightS / 2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);

    // cleanups the context by closing the current path
    // and clipping it "against" the boundaries, this should
    // be able to create a mask the "soon to be" drawn image
    CGContextClosePath(context);
    CGContextClip(context);

    // "draws" the current image to the current context, the
    // image should be masked agains the round corners
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);

    // creates a new cgi image object from the context from the
    // current context and then releases both the context and the
    // color space objects
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);

    // retrives the image file from the image reference and
    // then releases the image reference (direct control)
    UIImage *roundImage = [UIImage imageWithCGImage:imageMasked scale:scaleFactor orientation:UIImageOrientationUp];
    CGImageRelease(imageMasked);

    // returns the "transformed" round image to the
    // caller method
    return roundImage;
}

- (UIImage *)blendImage:(UIImage *)top algorithm:(NSString *)algorithm {
    // defines the initial values for both the bytes per pixel to be used
    // and the number of bits per chanel component
    NSInteger bytesPerPixel = 4;
    NSInteger bitsPerComponents = 8;

    // loads the bottom image, this is considered to be the current image in
    // context as expected by the current specification
    CGImageRef bottomImageCG = self.CGImage;
    NSUInteger bottomW = CGImageGetWidth(bottomImageCG);
    NSUInteger bottomH = CGImageGetHeight(bottomImageCG);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bottomBytesPerRow = bytesPerPixel * bottomW;
    UInt32 *bottomPixels = (UInt32 *)calloc(bottomH * bottomW, sizeof(UInt32));
    CGContextRef context = CGBitmapContextCreate(
        bottomPixels,
        bottomW, bottomH,
        bitsPerComponents, bottomBytesPerRow, colorSpace,
        kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
    );
    CGContextDrawImage(context, CGRectMake(0, 0, bottomW, bottomH), bottomImageCG);

    // loads the top image, this is considered to be the image that was provided
    // as an argument to the current function/method
    CGImageRef topImageCG = top.CGImage;
    CGSize topSize = top.size;
    NSUInteger topBytesPerRow = bytesPerPixel * topSize.width;
    UInt32 *topPixels = (UInt32 *)calloc(topSize.width * topSize.height, sizeof(UInt32));
    CGContextRef topContext = CGBitmapContextCreate(
         topPixels,
         topSize.width, topSize.height,
         bitsPerComponents, topBytesPerRow, colorSpace,
         kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big
    );
    CGContextDrawImage(topContext, CGRectMake(0, 0, topSize.width, topSize.height), topImageCG);

    // tries to retrieve the proper selector for the currently selected
    // algorithm and in case it's not valid returns an invalid picture
    SEL operation = [HMBlend getBlendAlgorithm:algorithm];
    if(![[HMBlend class] respondsToSelector:operation]) {
        return nil;
    }

    // creates a new invocation that will be used for every iteration of
    // the blending operation in order to perform the blend in a pixel basis
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[[HMBlend class] methodSignatureForSelector:operation]];
    [invocation setSelector:operation];
    [invocation setTarget:[HMBlend class]];

    // iterates over the complete set of pixels from the current context
    // in order to blend them according to the selected algorithm
    for(NSUInteger y = 0; y < topSize.height; y++) {
        for(NSUInteger x = 0; x < topSize.width; x++) {
            // retrieves the pixel color from the
            // bottom image for the current coordinates
            UInt32 *bottomPixel = bottomPixels + y * bottomW + x;
            UInt32 bottomColor = *bottomPixel;

            // retrieves the pixel color from the
            // top image for the current coordinates
            UInt32 *topPixel = topPixels + y * (int) topSize.width + x;
            UInt32 topColor = *topPixel;

            // populates the invocation for the current pixel blending
            // iteration and then updates the proper value for the bottom
            [invocation setArgument:&topColor atIndex:2];
            [invocation setArgument:&bottomColor atIndex:3];
            [invocation invoke];
            [invocation getReturnValue:bottomPixel];
        }
    }

    // creates an image with the blended result and returns it to
    // the caller function so that it may be used in raster contexts
    CGImageRef blendedImageCG = CGBitmapContextCreateImage(context);
    UIImage *blendedImage = [UIImage imageWithCGImage:blendedImageCG];
    return blendedImage;
}

- (UIImage *)blendImageFast:(UIImage *)top algorithm:(CGBlendMode)algorithm {
    algorithm = algorithm == 0 ? kCGBlendModeMultiply : algorithm;
    CGSize size = self.size;
    UIGraphicsBeginImageContext(size);
    [self drawAtPoint:CGPointZero blendMode:algorithm alpha:1.0];
    [top drawAtPoint:CGPointZero blendMode:algorithm alpha:1.0];
    UIImage *blendedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blendedImage;
}

+ (UIImageView *)animationFromSprite:(UIImage *)sprite width:(NSUInteger)width height:(NSUInteger)height {
    // creates the "base" animation image view to be used for the
    // placing of the sprite animation and then allocated a new array
    // for the holding of the various images for the animation
    UIImageView *animation = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    NSMutableArray *images = [[NSMutableArray alloc] init];

    // retrieves the scale factor currently in use from
    // the sprite object (scale in object)
    float scaleFactor = sprite.scale;

    // runs the scale operation ob both the width and the height
    // of the base image size so tatht the cut operation is corerctly
    // applied (according to the scale factor)
    NSUInteger widthS = width * scaleFactor;
    NSUInteger heightS = height * scaleFactor;

    // regtrieves the "underlying" core graphics image structure
    // from the provided sprite image
    CGImageRef spriteImage = sprite.CGImage;

    // calculates the number of (partial) images contained in the sprite
    // an then iterates to extract them from it and populate the images
    // array to be used in the animation
    int numberImages = (int) floor(sprite.size.height / (CGFloat) height);
    for(int index = 0; index < numberImages; index++) {
        CGImageRef partialImage = CGImageCreateWithImageInRect(spriteImage, CGRectMake(0, index * heightS, widthS, heightS));
        UIImage *partial = [UIImage imageWithCGImage:partialImage scale:scaleFactor orientation:UIImageOrientationUp];
        CGImageRelease(partialImage);
        [images addObject:partial];
    }

    // populates the various attributes of the animation with the
    // images an the duration of the animation
    animation.animationImages = images;
    animation.animationDuration = 5.0f;

    // returns the constructed animation image to the caller
    // function so that it can be used and placed in the correct
    // position
    return animation;
}

@end
