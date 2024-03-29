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
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2022 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMRequest.h"

@implementation HMRequest

- (id)initWithUrl:(NSURL *)url {
    self = [super init];
    if(self) {
        self.url = url;
        self.method = @"GET";
        self.callback = nil;
    }
    return self;
}

- (id)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if(self) {
        self.url = [NSURL URLWithString:urlString];
        self.method = @"GET";
        self.callback = nil;
        self.serializer = HMJSONSerializer.singleton;
    }
    return self;
}

- (id)initWithUrlString:(NSString *)urlString callback:(RequestBlock)callback {
    self = [super init];
    if(self) {
        self.url = [NSURL URLWithString:urlString];
        self.method = @"GET";
        self.callback = callback;
        self.serializer = HMJSONSerializer.singleton;
    }
    return self;
}

- (id)initWithUrlString:(NSString *)urlString parameters:(NSArray *)parameters {
    self = [super init];
    if(self) {
        self.url = [NSURL URLWithString:urlString];
        self.method = @"GET";
        self.parameters = parameters;
        self.callback = nil;
        self.serializer = HMJSONSerializer.singleton;
    }
    return self;
}

- (id)initWithUrlString:(NSString *)urlString method:(NSString *)method parameters:(NSArray *)parameters callback:(RequestBlock)callback {
    self = [super init];
    if(self) {
        self.url = [NSURL URLWithString:urlString];
        self.method = method;
        self.parameters = parameters;
        self.callback = callback;
        self.serializer = HMJSONSerializer.singleton;
    }
    return self;
}

- (void)load {
    // in case there's currently no url defined
    // in the current instance must return immediately
    // (cannot load the resource)
    if(!self.url) { return; }

    // construct the "final" url value taking into account
    // the parameters sequence in the url value
    NSURL *url = [self constructUrl];

    // creates a request using the current url and then uses it
    // to create the connection to be used setting the current instace
    // as the delegate object for it, note that the request's method
    // is changed according to the defined in the request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = self.method;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    self.connection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self];

    // notifies the delegate about the sending of data to the remote
    // connection (initial communication)
    if(self.delegate && [self.delegate respondsToSelector:@selector(didSend)]) {
        [self.delegate didSend];
    }
}

- (NSURL *)constructUrl {
    // validates if the parameters array is defined and if
    // there's no query string in the current url structure
    // in case any of the validations fails returns the current
    // url structure immediately
    if(!self.parameters) { return self.url; }
    if(self.url.query) { return self.url; }

    // retrieves the (base) url string from the url and
    // constructs the parameters string (query) and uses
    // both to construct the "final" url string
    NSString *urlString = self.url.absoluteString;
    NSString *parameters = [self contructParameters];
    urlString = [NSString stringWithFormat:@"%@?%@", urlString, parameters];

    // creates the url structures using the url string and
    // then returns it to the caller method
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (NSString *)contructParameters {
    // retrives the remote sequence data enumerator
    NSEnumerator *parametersEnumerator = [self.parameters objectEnumerator];

    // allocates the object value
    id object;

    // creats the buffer to hold the string, this should be
    // a faster alternative to concatenate strings
    NSMutableArray *stringBuffer = [[NSMutableArray alloc] init];

    // sets the is first flag
    BOOL isFirst = YES;

    // iterates over the various parameter tuples to be
    // used to compose the url string
    while((object = [parametersEnumerator nextObject])) {
        // casts the object as an array (tuple)
        // that should contain both the key and value
        NSArray *tuple = (NSArray *) object;

        // retrieves the key and the value to create
        // the string tuple value (key value pair)
        NSString *key = [tuple objectAtIndex:0];
        NSString *value = [tuple objectAtIndex:1];

        // verifies if the current value in iteration is of
        // type string, so that some conditionals may be activated
        BOOL isString = [value isKindOfClass:[NSString class]];

        // in case the value is not defined or it's
        // an empty string
        if(value == nil || (NSNull *) value == [NSNull null] ||
           (isString && value.length < 1)) {
            // sets the value as an empty string
            value = @"";
        }

        // in case it's the first iteration
        // must unset the is first flag
        if(isFirst) { isFirst = NO; }
        // otherwise it must be a different iteration
        // and must add the "and" character
        else { [stringBuffer addObject:@"&"]; }

        // creates the line value and then adds the
        // line to the string buffer for joining
        NSString *lineValue = [NSString stringWithFormat:@"%@=%@", key, value];
        [stringBuffer addObject:lineValue];
    }

    // joins the http string buffer retrieving the string
    NSString *httpString = [stringBuffer componentsJoinedByString:@""];

    // escapes the http string unsing the correct escaping
    // characters to archieve the purpose
    NSString *escapedHttpString = [HMString quoteString:httpString];

    // returns the escaped http string with the encoded values
    // to the caller function (encoded parameters)
    return escapedHttpString;
}

- (void)handleError:(NSError *)error {
    // notifies the delegate about the receival from
    // the remote connection (must be done to avoid problems)
    if(self.delegate && [self.delegate respondsToSelector:@selector(didReceive)]) {
        [self.delegate didReceive];
    }

    // in case the callback is defined for the current request
    // it must be called with the raised error
    if(self.callback) { self.callback(nil, error); }

    // notifies the delegate about the receival of the error
    // value from the remote connection
    if(self.delegate) { [self.delegate didReceiveError:error]; }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // tries to determine the appropriate capacity to be used in the
    // received data mutable data structure defaulting to the default
    // value in case it's not possible to measure the capacity
    long long capacity = [response expectedContentLength];
    if(capacity == NSURLResponseUnknownLength) { capacity = 1000 * 1024; }

    // creates a new mutable data "holder" to gather
    // the data to be sent from the server
    self.receivedData = [[NSMutableData alloc] initWithCapacity:(NSUInteger) capacity];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // adds the "just" received data to the buffer containing
    // the complete set of received data
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // handles the eror using the current infra-structure
    // should be able to do it
    [self handleError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // allocates space for the variable that will hold
    // the error structure for error in load string process
    NSError *error = nil;
    id data = [self.serializer loads:self.receivedData error:&error];

    // in case there was an error handling the data must
    // handle it in the correct manner
    if(error) { [self handleError:error]; return; }

    // notifies the delegate about the receival from
    // the remote connection
    if(self.delegate && [self.delegate respondsToSelector:@selector(didReceive)]) {
        [self.delegate didReceive];
    }

    // in case the callback is defined for the current request
    // it must be called with the recieved and processed data
    if(self.callback) { self.callback(data, nil); }

    // notifies the delegate about the receival of the
    // value from the remote connection
    if(self.delegate) { [self.delegate didReceiveData:data]; }
}

+ (HMRequest *)requestWithUrlString:(NSString *)urlString callback:(RequestBlock) callback {
    HMRequest *request = [[HMRequest alloc] initWithUrlString:urlString callback:callback];
    [request load];
    return request;
}

@end
