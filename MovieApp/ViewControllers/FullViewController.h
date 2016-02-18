//
//  FullViewController.h
//  MovieApp
//
//  Created by XtronLabs.inc on 11/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
#import "AsyncImageView.h"
#import "NavAnimation.h"
#import "CommentViewController.h"
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <Pinterest/Pinterest.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import "MovieDetailsTableViewCell.h"
#import "Teller.h"
#import "SingletonCenter.h"



@interface FullViewController : UIViewController<GPPSignInDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,TellerDelegate>{
    
    
    __weak IBOutlet FXBlurView *blurView;
    __weak IBOutlet AsyncImageView *mainImage;
    __weak IBOutlet UIButton *likButton;
    __weak IBOutlet UIButton *commentButton;
    __weak IBOutlet NSLayoutConstraint *blurHight;
    
    
    __weak IBOutlet UITableView *detailsTableView;
    __weak IBOutlet UILabel *movieName;
}

@property NSString* movieId;

- (IBAction)commentBtn:(id)sender;
- (IBAction)likeButton:(id)sender;
- (IBAction)shareButton:(id)sender;
- (IBAction)upButton:(id)sender;

@end
