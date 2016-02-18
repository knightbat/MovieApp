//
//  LeftMenuViewController.h
//  Lendr
//
//  Created by XtronLabs.inc on 26/05/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMSlideMenuLeftTableViewController.h"

@interface LeftMenuViewController : AMSlideMenuLeftTableViewController<UITableViewDataSource,UITableViewDelegate>{
    
    __weak IBOutlet UIImageView *profilePic;
    
}



@end
