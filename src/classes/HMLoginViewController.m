// Hive Cameo Framework
// Copyright (C) 2008-2012 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

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
    
    // retrieves the current view, casting it as a login view
    // this is an unsafe operation
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
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    return [self shouldAutorotateToInterfaceOrientation:orientation];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPhone) { return YES; }
    
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) { return NO; }
    return YES;
}

- (IBAction)textFieldFinished:(id)sender {
    // retrieves the current view, casting it as a login view
    // this is an unsafe operation
    HMLoginView *loginView = (HMLoginView *) self.view;
    
    // retrieves both the username and the password text field and uses
    // them to retrieve these values to be used in the authentication
    NSString *username = loginView.usernameField.text;
    NSString *password = loginView.passwordField.text;
    
    // creates the base path template containing both the username and
    // the password values than formats the value using these values
    NSString *basePath = @"%@?username=%@&password=%@";
    NSString *path = [NSString stringWithFormat:basePath, self.loginPath, username, password];
    
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
    
    // creates the alert window that will be used to display the error
    // associated with the current authentication failure and then shows
    // it in a modal fashion, then returns immediately to the caller method
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[HMResources localizedString:@"LoginError" withDefault:@"Login Error"]
                                                    message:[HMResources localizedString:message withDefault:message]
                                                   delegate:nil
                                          cancelButtonTitle:[HMResources localizedString:@"Confirm" withDefault:@"Confirm"]
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)didReceive {
}

- (void)didReceiveData:(NSDictionary *)data {
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
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveError:(NSError *)error {
}

@end
