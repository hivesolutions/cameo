// Hive Cameo Framework
// Copyright (C) 2008-2022 Hive Solutions Lda.
//
// This file is part of Hive Cameo Framework.
//
// Hive Cameo Framework is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Cameo Framework is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Cameo Framework. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2022 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMBlend.h"

@interface UIImage(HMImageUtil) {
}

/**
 Scales the current image to the provided size, note that a proper mechanism is going to be selected to determine the dimension to be used as pivot for scaling.

 @param size The target size for the resulting image, a proper dimension will be selected for resizing.
 @return The resulting scaled image ready to be used in raster contexts.
 */
- (UIImage *)scaleImage:(CGSize)size;

/**
 Creates rounded corners for the current image using a radius based approach, meaning that the radius of round circle will be provided an all of the corners will have such rounding value.

 @param radius The radius of the circle to be applied to each of the image's corners.
 @return The resulting "rounded" imager eady to be used in raster contexts.
 */
- (UIImage *)roundWithRadius:(NSUInteger)radius;

/**
 Creates rounded corners for the current image using a oval dimensions based approach, meaning that the proper dimensions of the round circle are provided explicitly and used accordingly.

 @param ovalWidth The width of the oval/circle value for the round corners of the image.
 @param ovalHeight The height of the oval/circle value for the round corners of the image.
 @return The resulting "rounded" imager eady to be used in raster contexts.
 */
- (UIImage *)roundWithWidth:(NSUInteger)ovalWidth height:(NSUInteger)ovalHeight;

/**
 Blends the current image with a provided (top) image using the provided algorithm, all of the operations are performed using software base strategies.

 @param top The image to be blended on top of the current image in scope.
 @param algorithm The name of the belding algorithm to be used in the operation.
 @return The resulting blended image that that may be used in a raster context.
 */
- (UIImage *)blendImage:(UIImage *)top algorithm:(NSString *)algorithm;

/**
 Faster version of the blending operation that uses the "native" infra-structure to provide the best performance in bleanding.

 @param top The image to be blended on top of the current image in scope.
 @param algorithm The name of the belding algorithm to be used in the operation.
 @return The resulting blended image that that may be used in a raster context.
 */
- (UIImage *)blendImageFast:(UIImage *)top algorithm:(CGBlendMode)algorithm;

/**
 Generates an image view with the animation defined with the provided sprite.

 @param sprite The (vertical) based sprite image that is going to be used as the basis for the animation.
 @param width The width in pixels of the provided sprite image.
 @param height The height in pixels of the provided sprite image.
 @return The resulting image view component with the proper associated animation.
 */
+ (UIImageView *)animationFromSprite:(UIImage *)sprite width:(NSUInteger)width height:(NSUInteger)height;

/**
 Generates an image instance with the provided color value filling the image.

 @param color The color that is going to be used for the image generation.
 @return The image that is completely filled with the provided color.
*/
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
