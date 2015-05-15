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

#import "HMProxy.h"

@implementation HMProxy

- (id)initWithBaseUrl:(NSString *)baseUrl sessionId:(NSString *)sessionId {
    self = [super init];
    if(self) {
        self.baseUrl = baseUrl;
        self.sessionId = sessionId;
    }
    return self;
}

- (HMProxyRequest *)get:(NSString *)url {
    return [self get:url parameters:nil];
}

- (HMProxyRequest *)get:(NSString *)url parameters:(NSDictionary *)parameters {
    url = [self getAbsoluteUrl:url];
    HMProxyRequest *request = [[HMProxyRequest alloc] init];
    request.baseUrl = @"";
    request.sessionId = self.sessionId;
    request.path = url;
    request.method = @"GET";
    request.parameters = [self toParametersArray:parameters];
    return request;
}

- (HMProxyRequest *)post:(NSString *)url data:(NSData *)data {
    return [self post:url data:data parameters:nil];
}

- (HMProxyRequest *)post:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters {
    url = [self getAbsoluteUrl:url];
    HMProxyRequest *request = [[HMProxyRequest alloc] init];
    request.baseUrl = @"";
    request.sessionId = self.sessionId;
    request.path = url;
    request.method = @"POST";
    request.parameters = [self toParametersArray:parameters];
    return request;
}

- (HMProxyRequest *)put:(NSString *)url data:(NSData *)data {
    return [self put:url data:data parameters:nil];
}

- (HMProxyRequest *)put:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters {
    url = [self getAbsoluteUrl:url];
    HMProxyRequest *request = [[HMProxyRequest alloc] init];
    request.baseUrl = @"";
    request.sessionId = self.sessionId;
    request.path = url;
    request.method = @"PUT";
    request.parameters = [self toParametersArray:parameters];
    return request;
}

- (HMProxyRequest *)_delete:(NSString *)url {
    return [self _delete:url parameters:nil];
}

- (HMProxyRequest *)_delete:(NSString *)url parameters:(NSDictionary *)parameters {
    url = [self getAbsoluteUrl:url];
    HMProxyRequest *request = [[HMProxyRequest alloc] init];
    request.baseUrl = @"";
    request.sessionId = self.sessionId;
    request.path = url;
    request.method = @"DELETE";
    request.parameters = [self toParametersArray:parameters];
    return request;
}

- (NSString *)getAbsoluteUrl:(NSString *)url {
    bool isAbsolute = [url hasPrefix:@"http://"] || [url hasPrefix:@"https://"];
    if(isAbsolute) { return url; }
    return [self.baseUrl stringByAppendingString:url];
}

- (NSArray *)toParametersArray:(NSDictionary *)parameters {
    NSMutableArray *parametersArray = [[NSMutableArray alloc] init];

    for(NSString *key in parameters) {
        NSObject *value = parameters[key];

        BOOL isArray = [value isKindOfClass:[NSArray class]];

        if(isArray == NO) {
            [parametersArray addObject:@[key, value]];
        }

        for(NSObject *_value in (NSArray *) value) {
            [parametersArray addObject:@[key, _value]];
        }
    }

    return [NSArray arrayWithArray:parametersArray];
}

@end
