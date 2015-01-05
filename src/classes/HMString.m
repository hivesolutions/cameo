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

#import "HMString.h"

@implementation HMString

+ (NSString *)capitalizedString:(NSString *)value {
    NSString *first = [[value substringToIndex:1] uppercaseString];
    NSString *capitalized = [value stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                           withString:first];
    return capitalized;
}

+ (NSString *)quoteString:(NSString *)value {
    NSString *quoted = [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    quoted = [quoted stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    return quoted;
}

@end
