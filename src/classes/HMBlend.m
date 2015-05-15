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

#import "HMBlend.h"

@implementation HMBlend

+ (SEL)getBlendAlgorithm:(NSString *)algorithm {
    if([algorithm isEqualToString:@"multiplicative"]) return @selector(blendMultiplicative:belowColor:);
    else if([algorithm isEqualToString:@"disjoint_debug"]) return @selector(blendDisjointDebug:belowColor:);
    else if([algorithm isEqualToString:@"disjoint_under"]) return @selector(blendDisjointUnder:belowColor:);
    else if([algorithm isEqualToString:@"disjoint_over"]) return @selector(blendDisjointOver:belowColor:);
    return nil;
}

+ (UInt32)blendMultiplicative:(UInt32)bottom belowColor:(UInt32)top {
    CGFloat at = 1.0f * (A(top) / 255.0f);
    UInt8 r = R(bottom) * (1 - at) + R(top) * at;
    UInt8 g = G(bottom) * (1 - at) + G(top) * at;
    UInt8 b = B(bottom) * (1 - at) + B(top) * at;
    UInt8 a = MAX(0, MIN(255, A(top) + A(bottom)));
    r = MAX(0, MIN(255, r));
    g = MAX(0, MIN(255, g));
    b = MAX(0, MIN(255, b));
    UInt32 pixel = RGBA(r, g, b, a);
    return pixel;
}

+ (UInt32)blendDisjointDebug:(UInt32)bottom belowColor:(UInt32)top {
    CGFloat at =  1.0f * (A(top) / 255.0f);
    CGFloat ab = 1.0f * (A(bottom) / 255.0f);
    UInt8 r = at + ab < 1.0f ? 0 : 255;
    UInt8 g = at + ab < 1.0f ? 255 : 0;
    UInt8 b = at + ab < 1.0f ? 0 : 0;
    UInt8 a = MAX(0, MIN(255, A(top) + A(bottom)));
    UInt32 pixel = RGBA(r, g, b, a);
    return pixel;
}

+ (UInt32)blendDisjointUnder:(UInt32)bottom belowColor:(UInt32)top {
    CGFloat at =  1.0f * (A(top) / 255.0f);
    CGFloat ab = 1.0f * (A(bottom) / 255.0f);
    UInt8 r = at * ab > 0.0f ? (float) R(top) / at * (1.0f - ab) + R(bottom) : R(top) * (1.0f - ab) + R(bottom);
    UInt8 g = at * ab > 0.0f ? (float) G(top) / at * (1.0f - ab) + G(bottom) : G(top) * (1.0f - ab) + G(bottom);
    UInt8 b = at * ab > 0.0f ? (float) B(top) / at * (1.0f - ab) + B(bottom) : B(top) * (1.0f - ab) + B(bottom);
    r = MAX(0, MIN(255, r));
    g = MAX(0, MIN(255, g));
    b = MAX(0, MIN(255, b));
    UInt8 a = MAX(0, MIN(255, A(top) + A(bottom)));
    UInt32 pixel = RGBA(r, g, b, a);
    return pixel;
}

+ (UInt32)blendDisjointOver:(UInt32)bottom belowColor:(UInt32)top {
    CGFloat at =  1.0f * (A(top) / 255.0f);
    CGFloat ab = 1.0f * (A(bottom) / 255.0f);
    UInt8 r = at + ab < 1.0f ? R(top) + R(bottom) * (1.0f - at) / ab : R(top) + R(bottom);
    UInt8 g = at + ab < 1.0f ? G(top) + G(bottom) * (1.0f - at) / ab : G(top) + G(bottom);
    UInt8 b = at + ab < 1.0f ? B(top) + B(bottom) * (1.0f - at) / ab : B(top) + B(bottom);
    r = MAX(0, MIN(255, r));
    g = MAX(0, MIN(255, g));
    b = MAX(0, MIN(255, b));
    UInt8 a = MAX(0, MIN(255, A(top) + A(bottom)));
    UInt32 pixel = RGBA(r, g, b, a);
    return pixel;
}

@end
