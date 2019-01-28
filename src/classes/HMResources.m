// Hive Cameo Framework
// Copyright (C) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

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
    NSString *path = [bundle pathForResource:imagePath ofType:type];
    return path;
}

+ (UIImage *)image:(NSString *)name type:(NSString *)type {
    NSString *path = [HMResources imagePath:name type:type];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

+ (UIImage *)imageNamed:(NSString *)name {
    NSString *fullName = [NSString stringWithFormat:@"HMBaseResources.bundle/static/images/%@", name];
    UIImage *image = [UIImage imageNamed:fullName];
    return image;
}

+ (NSString *)localizedString:(NSString *)key {
    return [HMResources localizedString:key withDefault:NSLocalizedString(key, key)];
}

+ (NSString *)localizedString:(NSString *)key withDefault:(NSString *)value {
    NSBundle *bundle = [HMResources getBundle];
    NSString *result = [bundle localizedStringForKey:key value:value table:nil];
    return result;
}

@end

NSString *HMLocalizedString(NSString * key) {
    return [HMResources localizedString:key];
}

NSString *HMDefaultString(NSString *key, NSString *value) {
    return [HMResources localizedString:key withDefault:value];
}
