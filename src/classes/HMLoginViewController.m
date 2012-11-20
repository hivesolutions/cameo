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
    if (self) {}
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // retrieves the references for both the username and the password
    // text field element to be used for behavior change
 /*   UITextField *usernameField = (UITextField *) [self.view viewWithTag:1];
    UITextField *passwordField = (UITextField *) [self.view viewWithTag:2];
    
    // retrieves the reference to both the signin button and the forgor label and
    // updates their text values to the appropriate localizable labels
    UIButton *signinButton = (UIButton *) [self.view viewWithTag:4];
    UILabel *forgotLabel = (UILabel *) [self.view viewWithTag:5];
    [signinButton setTitle:NSLocalizedString(@"Sign In", @"Sign In") forState:UIControlStateNormal];
    forgotLabel.text = NSLocalizedString(@"Forgot your password ?", @"Forgot your password ?");
    
    // forces the username field to become the first
    // responder (focus on the text field element)
    [usernameField becomeFirstResponder];
    
    // sets the current view controller as the delagate for both text
    // fields and then sets the return key as the done key and the text
    // field finished as the handler of such behavior
    [usernameField setDelegate:self];
    [passwordField setDelegate:self];
    [usernameField setReturnKeyType:UIReturnKeyDone];
    [passwordField setReturnKeyType:UIReturnKeyDone];
    [usernameField addTarget:self
                      action:@selector(textFieldFinished:)
            forControlEvents:UIControlEventEditingDidEndOnExit];
    [passwordField addTarget:self
                      action:@selector(textFieldFinished:)
            forControlEvents:UIControlEventEditingDidEndOnExit];*/
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
    
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        interfaceOrientation == UIInterfaceOrientationLandscapeRight) { return NO; }
    return YES;
}

- (IBAction)textFieldFinished:(id)sender {
    // retrieves both the username and the password text field and uses
    // them to retrieve these values to be used in the authentication
    UITextField *usernameField = (UITextField *) [self.view viewWithTag:1];
    UITextField *passwordField = (UITextField *) [self.view viewWithTag:2];
    NSString *username = usernameField.text;
    NSString *password = passwordField.text;
    
    // creates the base path template containing both the username and
    // the password values than formats the value using these values
    NSString *basePath = @"login.json?username=%@&password=%@";
    NSString *path = [NSString stringWithFormat:basePath, username, password];
    
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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"LoginError", @"Login Error")
                                                    message:NSLocalizedString(message, message)
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Confirm", @"Confirm")
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
