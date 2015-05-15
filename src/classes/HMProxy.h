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

#import "Dependencies.h"

#import "HMJsonRequest.h"
#import "HMProxyRequest.h"
#import "HMCallbackDelegate.h"

@interface HMProxy : NSObject {
}

@property (nonatomic) NSString *baseUrl;
@property (nonatomic) NSString *sessionId;
@property (nonatomic) NSMutableArray *requests;
@property (nonatomic) NSMutableArray *delegates;

- (id)initWithBaseUrl:(NSString *)baseUrl sessionId:(NSString *)sessionId;
- (HMProxyRequest *)get:(NSString *)url callback:(JsonBlock)callback;
- (HMProxyRequest *)get:(NSString *)url parameters:(NSDictionary *)parameters callback:(JsonBlock)callback;
- (HMProxyRequest *)post:(NSString *)url data:(NSData *)data callback:(JsonBlock)callback;
- (HMProxyRequest *)post:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters callback:(JsonBlock)callback;
- (HMProxyRequest *)put:(NSString *)url data:(NSData *)data callback:(JsonBlock)callback;
- (HMProxyRequest *)put:(NSString *)url data:(NSData *)data parameters:(NSDictionary *)parameters callback:(JsonBlock)callback;
- (HMProxyRequest *)_delete:(NSString *)url callback:(JsonBlock)callback;
- (HMProxyRequest *)_delete:(NSString *)url parameters:(NSDictionary *)parameters callback:(JsonBlock)callback;

@end
