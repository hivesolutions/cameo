// Hive Cameo Framework
// Copyright (C) 2008-2018 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2018 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#define MASK8(x) ((x) & 0xff)
#define R(x) (MASK8(x))
#define G(x) (MASK8(x >> 8 ))
#define B(x) (MASK8(x >> 16))
#define A(x) (MASK8(x >> 24))
#define RGBA(r, g, b, a) (MASK8(r) | MASK8(g) << 8 | MASK8(b) << 16 | MASK8(a) << 24)

@interface HMBlend : NSObject {
}

+ (SEL)getBlendAlgorithm:(NSString *)algorithm;
+ (UInt32)blendMultiplicative:(UInt32)bottom belowColor:(UInt32)top;
+ (UInt32)blendDisjointDebug:(UInt32)bottom belowColor:(UInt32)top;
+ (UInt32)blendDisjointUnder:(UInt32)bottom belowColor:(UInt32)top;
+ (UInt32)blendDisjointOver:(UInt32)bottom belowColor:(UInt32)top;

@end
