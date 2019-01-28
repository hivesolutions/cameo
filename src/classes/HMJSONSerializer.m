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

#import "HMJSONSerializer.h"

@implementation HMJSONSerializer

- (id)initWithClass:(Class)mapper {
    self = [super init];
    if(self) {
        self.mapper = mapper;
    }
    return self;
}

- (NSData *)dumps:(id)object error:(NSError **)error {
    return nil;
}

- (id)loads:(NSData *)data error:(NSError **)error {
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions
                                                  error:error];
    if(*error == nil && self.mapper) {
        object = [self map:object error:error];
    }
    return object;
}

- (id)map:(id)object error:(NSError **)error {
    BOOL isMany = [object isKindOfClass:[NSArray class]];
    if(isMany) {
        NSMutableArray *result = [[NSMutableArray alloc] init];
        for(id _object in object) {
            id item = [[self.mapper alloc] init];
            [item setValuesForKeysWithDictionary:_object];
            [result addObject:item];
        }
        return result;
    } else {
        id result = [[self.mapper alloc] init];
        [result setValuesForKeysWithDictionary:object];
        return result;
    }
}

+ (HMJSONSerializer *)singleton {
    static dispatch_once_t onceToken;
    static HMJSONSerializer *singleton = nil;
    dispatch_once(&onceToken, ^{
        singleton = [[HMJSONSerializer alloc] init];
    });
    return singleton;
}

+ (HMJSONSerializer *)getSingleton {
    return [HMJSONSerializer singleton];
}

+ (HMJSONSerializer *)getForClass:(Class)mapper {
    return [[HMJSONSerializer alloc] initWithClass:mapper];
}

@end
