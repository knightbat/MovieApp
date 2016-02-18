//
//  ViewController.m
//  Test App
//
//  Created by XtronLabs.inc on 01/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "LoginViewController.h"
#import "SSKeychain.h"

@interface LoginViewController (){
    
    BOOL isChecked;
    
    CGPoint point;
    BOOL isFirst;

}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.banner.hidden = YES;
    
    
    
    
    isChecked = NO;
    isFirst = YES;
    NSString *myNewLineStr = @"\n";
    headerText.text = [headerText.text stringByReplacingOccurrencesOfString:@"\\n" withString:myNewLineStr];
    
    
//    CGSize labelSize = [headerText.text sizeWithAttributes:@{NSFontAttributeName:headerText.font}];
//    
//    headerText.frame = CGRectMake(
//                             headerText.frame.origin.x, headerText.frame.origin.y,
//                             headerText.frame.size.width, labelSize.height);
    

    if ([[GPPSignIn sharedInstance] authentication] || [FBSDKAccessToken currentAccessToken]) {

        NSLog(@"logged in ");
        
        
        
        profileView.hidden = NO;
    }else{
        
        profileView.hidden = YES;
    }

}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
//    isFirst = YES;
//    self.scrollView.contentOffset = point;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillLayoutSubviews {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    

    if (isFirst) {
        
        point = self.scrollView.contentOffset;
        isFirst = NO;
        
    }
    self.scrollView.contentOffset = CGPointMake(0, textField.frame.origin.y);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == username) {
        [password becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return true;
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.scrollView.contentOffset = point;


}


//
//- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
//{
//    return YES;
//}
//
//- (void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    self.banner.hidden = NO;
//
//}
//
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    
//    self.banner.hidden = YES;
//}

- (IBAction)signinButton:(id)sender {
    
    NSString *string = @"1,2,3,4,5";
    
    [SSKeychain setPassword:string forService:@"AnyService" account:@"testUser"];
    
    if ([username.text  isEqualToString: @""] || [password.text  isEqualToString: @""]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Empty Field(s)" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
- (IBAction)checkBox:(id)sender {
    
    checkBox.alpha = 0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    if(isChecked){
        
        isChecked = NO;
        
        [checkBox setImage:[UIImage imageNamed:@"unchecked_checkbox"] forState:UIControlStateNormal];
        checkBox.alpha = 1;

    }else{
        
        isChecked = YES;
        [checkBox setImage:[UIImage imageNamed:@"checked_checkbox"] forState:UIControlStateNormal];
        checkBox.alpha = 1;

    }
    

    [UIView commitAnimations];
}

- (IBAction)forgotPasswordBtn:(id)sender {
}

- (IBAction)fbButton:(id)sender {
    
    
        FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        [login logInWithReadPermissions:@[@"public_profile", @"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            if (error) {
                // Process error
            } else if (result.isCancelled) {
                // Handle cancellations
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Aborted by user" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
                [alert show];
                
            } else {
                // If you ask for multiple permissions at once, you
                // should check if specific permissions missing
                if ([result.grantedPermissions containsObject:@"email"] && [result.grantedPermissions containsObject:@"public_profile"]) {
                    
                    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil] startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                         if (!error) {
                             NSLog(@"user name:%@", [result valueForKey:@"name"]);
                             NSLog(@"email:%@", [result valueForKey:@"email"]);
                             profileView.hidden = NO;
                         }
                     }];
                    
                }
            }
        }];
    
    
    
    

}

- (IBAction)gPlusButton:(id)sender {
   
   
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
//    signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;    
    [signIn authenticate];
    
}

- (IBAction)logoutButton:(id)sender {
    
    [[GPPSignIn sharedInstance] signOut];
    [[[FBSDKLoginManager alloc] init] logOut];
    profileView.hidden = YES;
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    NSLog(@"%@",[GPPSignIn sharedInstance].userEmail);
    NSLog(@"%@",[GPPSignIn sharedInstance].googlePlusUser.displayName);

    if (!error) {
        profileView.hidden = NO;
    }
}

@end
