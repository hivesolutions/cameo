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

#import "HMString.h"
#import "HMJsonRequestDelegate.h"

typedef void (^JsonBlock)(NSDictionary *, NSError *);

@interface HMJsonRequest : NSObject {
}

/**
 The url of the resource to be retrieved by the json request.
 */
@property (nonatomic) NSURL *url;

/**
 The name of the http emthod that is going to be used for the request operation, by default this value is always considered to be get.
 */
@property (nonatomic) NSString *method;

/**
 The sequence of tuples containing the various parameters to be sent to the server.

 These parameters will be encoded into get parameters (under the url) in case the current request is of type get.
 */
@property (nonatomic) NSArray *parameters;

/**
 The connection to be used for the retrieval of the resources.
 */
@property (nonatomic) NSURLConnection *connection;

/**
 The buffer to be used to store the received data while the data transfer is not complete.
 */
@property (nonatomic) NSMutableData *receivedData;

/**
 The delegate object that will be notified about the changes in the connection from a json point of view.

 In case this value is set notifications will be sent for both errors and data receivals.
 */
@property (nonatomic, weak) NSObject<HMJsonRequestDelegate> *delegate;

/**
The callback block that is going to be called for both the success and error situations, note that even if this callback is defined the delegate will be called the same way.
 */
@property (readwrite, copy) JsonBlock callback;

- (id)initWithUrl:(NSURL *)url;
- (id)initWithUrlString:(NSString *)urlString;
- (id)initWithUrlString:(NSString *)urlString callback:(JsonBlock)callback;
- (id)initWithUrlString:(NSString *)urlString parameters:(NSArray *)parameters;
- (id)initWithUrlString:(NSString *)urlString method:(NSString *)method parameters:(NSArray *)parameters callback:(JsonBlock)callback;

/**
 Starts the loading process fot the json request from this moment on some network activity may be created and the proper/associated delegate will be called for each of the state changes (as expected).
 */
- (void)load;

/**
 Utility method meant to be used for quick/easy creation of json based remote call, the response should be "returned" as an argument to the provided callback block.

 @param urlString The string containing the url that is going to be called.
 @param callback The block to be called for the various state changes (including completion).
 @return The request object that was created for the handling of this call.
 */
+ (HMJsonRequest *)jsonRequestWithUrlString:(NSString *)urlString callback:(JsonBlock) callback;

@end
