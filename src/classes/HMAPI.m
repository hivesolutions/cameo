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

#import "HMAPI.h"

@implementation HMAPI

- (id)init {
    self = [super init];
    if(self) {
        self.name = @"API";
        self.proxy = [[HMProxy alloc] init];
        self.proxy.delegate = self;
    }
    return self;
}

- (id)initWithProxy:(HMProxy *)proxy {
    self = [super init];
    if(self) {
        self.name = @"API";
        self.proxy = proxy;
        self.proxy.delegate = self;
    }
    return self;
}

- (void)build:(NSString *)method
          url:(NSString *)url
         data:(NSData *)data
   parameters:(NSDictionary *)parameters
   useSession:(BOOL)useSession
   serializer:(NSObject<HMSerializer> *)serializer
     callback:(RequestBlock)callback {
    [HMLog debug:@"[%@] [build] %@ %@", self.name, method, url];
}

@end
