// Hive Cameo Framework
// Copyright (C) 2008-2014 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMJsonRequestDelegate.h"

@interface HMJsonRequest : NSObject {
}

/**
 * The url of the resource to be retrieved
 * by the json request.
 */
@property (nonatomic) NSURL *url;

/**
 * The name of the http emthod that is going
 * to be used for the request operation, by default
 * this value is always considered to be get.
 */
@property (nonatomic) NSString *method;

/**
 * The sequence of tuples containing the various
 * parameters to be sent to the server.
 *
 * These parameters will be encoded into get parameters
 * (under the url) in case the current request is of
 * type get.
 */
@property (nonatomic) NSArray *parameters;

/**
 * The connection to be used for the retrieval
 * of the resources.
 */
@property (nonatomic) NSURLConnection *connection;

/**
 * The buffer to be used to store the received
 * data while the data transfer is not complete.
 */
@property (nonatomic) NSMutableData *receivedData;

/**
 * The delegate object that will be notified about
 * the changes in the connection from a json point
 * of view.
 *
 * In case this value is set notifications will be sent
 * for both errors and data receivals.
 */
@property (nonatomic, weak) NSObject<HMJsonRequestDelegate> *delegate;

- initWithUrl:(NSURL *)url;
- initWithUrlString:(NSString *)urlString;
- initWithUrlString:(NSString *)urlString parameters:(NSArray *)parameters;
- (void)load;

@end
