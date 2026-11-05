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

#import "HMLoginViewController.h"

@implementation HMLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // only the default login view is wired here, custom login
    // controllers (subclasses) set up their own view and actions
    if(![self.view isKindOfClass:HMLoginView.class]) { return; }
    HMLoginView *loginView = (HMLoginView *) self.view;

    // forces the username field to become the first
    // responder (focus on the text field element)
    [loginView.usernameField becomeFirstResponder];

    // sets the current view controller as the delagate for both text
    // fields and then sets the return key as the done key and the text
    // field finished as the handler of such behavior
    [loginView.usernameField setDelegate:self];
    [loginView.passwordField setDelegate:self];
    [loginView.usernameField setReturnKeyType:UIReturnKeyDone];
    [loginView.passwordField setReturnKeyType:UIReturnKeyDone];
    [loginView.usernameField addTarget:self
                                action:@selector(textFieldFinished:)
                      forControlEvents:UIControlEventEditingDidEndOnExit];
    [loginView.passwordField addTarget:self
                                action:@selector(textFieldFinished:)
                      forControlEvents:UIControlEventEditingDidEndOnExit];

    // registers the signin button fot the "tap" event so that the
    // text field finished action is triggered
    [loginView.signinButton addTarget:self
                    action:@selector(textFieldFinished:)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate {
    if([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) { return YES; }
    return NO;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) { return YES; }
    return NO;
}
#pragma GCC diagnostic pop

- (IBAction)textFieldFinished:(id)sender {
    // retrieves both the username and the password from the default
    // login view and starts the authentication with them
    if(![self.view isKindOfClass:HMLoginView.class]) { return; }
    HMLoginView *loginView = (HMLoginView *) self.view;
    [self loginWithUsername:loginView.usernameField.text password:loginView.passwordField.text];
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    // creates the base path template containing both the username and
    // the password values than formats the value using these values, each
    // value is encoded on its own so that characters like "&" or "+" in a
    // password do not break the query string
    NSString *basePath = @"%@?username=%@&password=%@";
    NSString *path = [NSString stringWithFormat:basePath, self.loginPath,
                      [HMString quoteComponent:username], [HMString quoteComponent:password]];

    // creates a new proxy request to be used in the authentication procedure
    // note that this is an asynchronous call and may take some time
    _proxyRequest = [[HMProxyRequest alloc] initWithPath:self path:path];
    _proxyRequest.delegate = self;
    _proxyRequest.useSession = NO;
    [_proxyRequest load];

    // sends the resign as first responder to the "broadcast" application
    // this should hide the currently present keyboard
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder)
                                               to:nil
                                             from:nil
                                         forEvent:nil];
}

- (void)handleException:(NSDictionary *)exception {
    // retrieves the message contained in the exception structure
    // to be able to display it in a window
    NSString *message = [exception objectForKey:@"message"];
    message = [HMString capitalizedString:message];
    message = [HMResources localizedString:message withDefault:message];

    // creates the alert window that will be used to display the error
    // associated with the current authentication failure and then shows
    // it in a modal fashion, then returns immediately to the caller method
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[HMResources localizedString:@"LoginError" withDefault:@"Login Error"]
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:[HMResources localizedString:@"Confirm" withDefault:@"Confirm"]
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceive {
}

- (void)didReceiveData:(id)data {
    // checks if the current data contains an exception value and
    // in such case handles it and returns immediately
    NSDictionary *exception = [data valueForKey:@"exception"];
    if(exception) { [self handleException:exception]; return; }

    // retrieves the username, the object id and the session id
    // values from the authentication structure to be used in the
    // current persistent storage
    NSString *username = [data valueForKey:@"username"];
    NSString *objectId = [data valueForKey:@"object_id"];
    NSString *sessionId = [data valueForKey:@"session_id"];

    // retrieves the preferences object and uses it to set the "new"
    // session identifier value in it
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setValue:username forKey:@"username"];
    [preferences setValue:objectId forKey:@"objectId"];
    [preferences setValue:sessionId forKey:@"sessionId"];
    [preferences synchronize];

    // closes the current modal window triggering the pop of the
    // previous panel (will show it again)
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveError:(NSError *)error {
}

@end
