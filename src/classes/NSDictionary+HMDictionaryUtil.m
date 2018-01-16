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

#import "NSDictionary+HMDictionaryUtil.h"

@implementation NSDictionary(HMDictionaryUtil)

- (NSMutableDictionary *)merged:(NSDictionary *)other {
    // creates a mutable copy of the dictionary
    // into which the contents are going to be merged
    // (otherwise the dictionary may not be editable)
    NSMutableDictionary *target = self.mutableCopy;

    // iterates over each of the key in the dictionary
    // that is going to be the base of merging
    for(NSString *key in other) {
        // retrieves the values from both
        // dictionaries for the current key
        id value = other[key];
        id base = target[key];

        // in case both dictionary values are dictionaries
        // then calls this method recursively to merge them
        BOOL isValueDict = [value isKindOfClass:NSDictionary.class];
        BOOL isBaseDict = base != nil && [base isKindOfClass:NSDictionary.class];
        if(isValueDict && isBaseDict) {
            target[key] = [base merged:value];
        }
        // otherwise assigns the value to the target directly
        // as there's no conflic of value
        else {
            target[key] = value;
        }
    }

    // returns the merged dictionary (considered the result)
    // should contain non overlapping values
    return target;
}

@end
