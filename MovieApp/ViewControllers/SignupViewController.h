//
//  SignupViewController.h
//  Test App
//
//  Created by XtronLabs.inc on 01/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController<UITextFieldDelegate>{
    
    
    __weak IBOutlet UITextField *tfUsername;
    __weak IBOutlet UITextField *tfPassword;
    __weak IBOutlet UITextField *tfConfirmedPassword;
    __weak IBOutlet UITextField *tfPhoneNumber;
    __weak IBOutlet UITextField *tfEmailId;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end
