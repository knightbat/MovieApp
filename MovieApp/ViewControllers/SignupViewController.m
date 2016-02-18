//
//  SignupViewController.m
//  Test App
//
//  Created by XtronLabs.inc on 01/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "SignupViewController.h"
#import "SSKeychain.h"

@interface SignupViewController (){
    
    CGPoint point;
    BOOL isFirst;
}

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isFirst = YES;
    [self fixKeyboard];
    NSString *password = [SSKeychain passwordForService:@"AnyService" account:@"testUser"];
    NSLog(@"%@  %@",password, [password componentsSeparatedByString:@","]);

    

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
    
    if (textField == tfUsername) {
        [tfPassword becomeFirstResponder];
    }else if(textField == tfPassword){
        [tfConfirmedPassword becomeFirstResponder];
    }else if(textField == tfConfirmedPassword){
        
        [tfPhoneNumber becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.scrollView.contentOffset = point;

}
- (void) fixKeyboard
{
//    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
//    [keyboardDoneButtonView sizeToFit];
//    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
//                                                                   style:UIBarButtonItemStyleBordered target:self
//                                                                  action:@selector(doneClicked:)];
//    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
//    tfPhoneNumber.inputAccessoryView = keyboardDoneButtonView;
   
    //update done button right side
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                      target:self action:@selector(doneClicked:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    tfPhoneNumber.inputAccessoryView = keyboardToolbar;
}

- (IBAction)doneClicked:(id)sender{
    
    [tfEmailId becomeFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
