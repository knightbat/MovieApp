//
//  CommentViewController.h
//  MovieApp
//
//  Created by XtronLabs.inc on 12/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentTableViewCell.h"
#import "NavAnimation.h"

@interface CommentViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    
    
    __weak IBOutlet UITextField *commentText;
    
    
}
- (IBAction)sendButton:(id)sender;

@end
