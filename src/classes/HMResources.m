// Hive Cameo Framework
// Copyright (C) 2008-2012 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMResources.h"

@implementation HMResources

static NSBundle *bundle = nil;

+ (NSBundle *)getBundle {
    // in case the bundle satic reference is already defined
    // must return it immediately
    if(bundle != nil) { return bundle; }
    
    // creates the path to the base resources bundle and then
    // uses it to retrieve the bundle reference, returning it
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HMBaseResources"
                                                     ofType:@"bundle"];
    bundle = [NSBundle bundleWithPath:path];
    return bundle;
}

+ (NSString *)imagePath:(NSString *)name type:(NSString *)type {
    NSBundle *bundle = [HMResources getBundle];
    NSString *imagePath = [NSString stringWithFormat:@"static/images/%@", name];
    NSString *path =[bundle pathForResource:imagePath ofType:type];
    return path;
}

+ (UIImage *)image:(NSString *)name type:(NSString *)type {
    NSString *path = [HMResources imagePath:name type:type];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

@end
