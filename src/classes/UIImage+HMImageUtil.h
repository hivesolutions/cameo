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

#include "Dependencies.h"

@interface UIImage(HMImageUtil) {
}

/**
 Scales the current image to the provided size, note that a proper mechanism is going to be selected to determine the dimension to be used as pivot for scaling.
 
 @param size: The target size for the resulting image, a proper dimension will be selected for resizing.
 @return The resulting sacled image ready to be used in raster contexts.
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
 
 @param ovalWidth: The width of the oval/circle value for the round corners of the image.
 @param ovalHeight: The height of the oval/circle value for the round corners of the image.
 @return The resulting "rounded" imager eady to be used in raster contexts.
 */
- (UIImage *)roundWithWidth:(NSUInteger)ovalWidth height:(NSUInteger)ovalHeight;

/**
 Generates an image view with the animation defined with the provided sprite.
 
 @param sprite The (vertical) based sprite image that is going to be used as the basis for the animation.
 @param width The width in pixels of the provided sprite image.
 @param height The height in pixels of the provided sprite image.
 @return The resulting image view component with the proper associated animation.
 */
+ (UIImageView *)animationFromSprite:(UIImage *)sprite width:(NSUInteger)width height:(NSUInteger)height;

@end
