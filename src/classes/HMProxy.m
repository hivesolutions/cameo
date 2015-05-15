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

- (id)init {
    self = [super init];
    if(self) {
        self.baseUrl = nil;
        self.sessionId = nil;
        self.requests = [[NSMutableArray alloc] init];
        self.delegates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithBaseUrl:(NSString *)baseUrl sessionId:(NSString *)sessionId {
    self = [super init];
    if(self) {
        self.baseUrl = baseUrl;
        self.sessionId = sessionId;
        self.requests = [[NSMutableArray alloc] init];
        self.delegates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (HMProxyRequest *)get:(NSString *)url callback:(JsonBlock)callback {
    return [self get:url parameters:nil callback:callback];
}

- (HMProxyRequest *)get:(NSString *)url parameters:(NSDictionary *)parameters callback:(JsonBlock)callback {
    url = [self getAbsoluteUrl:url];
    return [self buildRequest:@"GET"
                          url:url
                         data:nil
                   parameters:parameters
                     callback:callback];}

- (HMProxyRequest *)post:(NSString *)url data:(NSData *)data callback:(JsonBlock)callback {
    return [self post:url data:data parameters:nil callback:callback];
}

- (HMProxyRequest *)post:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters callback:(JsonBlock)callback {
    url = [self getAbsoluteUrl:url];
    return [self buildRequest:@"POST"
                          url:url
                         data:data
                   parameters:parameters
                     callback:callback];
}

- (HMProxyRequest *)put:(NSString *)url data:(NSData *)data callback:(JsonBlock)callback {
    return [self put:url data:data parameters:nil callback:callback];
}

- (HMProxyRequest *)put:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters callback:(JsonBlock)callback {
    url = [self getAbsoluteUrl:url];
    return [self buildRequest:@"PUT"
                          url:url
                         data:data
                   parameters:parameters
                     callback:callback];
}

- (HMProxyRequest *)_delete:(NSString *)url callback:(JsonBlock)callback {
    return [self _delete:url parameters:nil callback:callback];
}

- (HMProxyRequest *)_delete:(NSString *)url parameters:(NSDictionary *)parameters callback:(JsonBlock)callback {
    url = [self getAbsoluteUrl:url];
    return [self buildRequest:@"DELETE"
                          url:url
                         data:nil
                   parameters:parameters
                     callback:callback];
}

- (HMProxyRequest *)buildRequest:(NSString *)method
                             url:(NSString *)url
                            data:(NSData *)data
                      parameters:(NSDictionary *)parameters
                        callback:(JsonBlock)callback {
    HMCallbackDelegate *delegate =[[HMCallbackDelegate alloc] initWithCallback:callback];
    HMProxyRequest *request = [[HMProxyRequest alloc] init];
    request.baseUrl = @"";
    request.sessionId = self.sessionId;
    request.path = url;
    request.method = method;
    request.parameters = [self toParametersArray:parameters];
    request.delegate = delegate;
    [self.requests addObject:request];
    [self.delegates addObject:request];
    [request load];
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
