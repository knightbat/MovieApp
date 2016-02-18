//
//  ViewController.h
//  Test App
//
//  Created by XtronLabs.inc on 01/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import "ProfileViewController.h"
@interface LoginViewController : UIViewController <ADBannerViewDelegate,UITextFieldDelegate,GPPSignInDelegate>{
    
    
    __weak IBOutlet UITextField *username;
    __weak IBOutlet UITextField *password;
    
    __weak IBOutlet UILabel *headerText;
    
    __weak IBOutlet UIButton *checkBox;
    
    __weak IBOutlet UIView *profileView;
}

//@property (weak, nonatomic) IBOutlet ADBannerView *banner;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)signinButton:(id)sender;

- (IBAction)checkBox:(id)sender;
- (IBAction)forgotPasswordBtn:(id)sender;
- (IBAction)fbButton:(id)sender;
- (IBAction)gPlusButton:(id)sender;

- (IBAction)logoutButton:(id)sender;

@end

