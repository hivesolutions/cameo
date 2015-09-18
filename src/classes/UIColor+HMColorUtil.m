// Hive Cameo Framework
// Copyright (C) 2008-2015 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "UIColor+HMColorUtil.h"

@implementation UIColor(HMColorUtil)

- (NSString *)hexString {
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    NSInteger redI = (NSUInteger) (255.0 * red);
    NSInteger greenI = (NSUInteger) (255.0 * green);
    NSInteger blueI = (NSUInteger) (255.0 * blue);
    NSString *hexString = [NSString stringWithFormat:@"%02lx%02lx%02lx",
                           (long) redI, (long) greenI, (long) blueI];
    return hexString;
}

- (UIColor *)lighterByPercentage:(CGFloat)percentage {
    CGFloat red, green, blue, alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    red = MAX(MIN(red + percentage, 1.0), 0.0);
    green = MAX(MIN(green + percentage, 1.0), 0.0);
    blue = MAX(MIN(blue + percentage, 1.0), 0.0);
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIColor *)darkerByPercentage:(CGFloat)percentage {
    return [self lighterByPercentage:percentage * -1.0];
}

+ (UIColor *)colorWithHex:(NSInteger)hex {
    NSInteger red = (hex & 0xFF0000) >> 16;
    NSInteger green = (hex & 0xFF00) >> 8;
    NSInteger blue = (hex & 0xFF);
    UIColor *color = [UIColor colorWithRed:red / 255.0
                                     green:green / 255.0
                                      blue:blue / 255.0
                                     alpha:1.0];
    return color;
}

@end
