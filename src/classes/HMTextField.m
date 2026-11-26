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
// __copyright__ = Copyright (c) 2008-2022 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMTextField.h"

@implementation HMTextField

- (void) drawPlaceholderInRect:(CGRect)rect {
    // uses the value of the light text color (white at 0.6 alpha) directly,
    // as the named color is not available on tvOS
    UIColor *color = [UIColor colorWithWhite:1.0 alpha:0.6];
    [self.placeholder drawInRect:rect withAttributes:@{NSFontAttributeName:self.font, NSForegroundColorAttributeName:color}];
}
@end
