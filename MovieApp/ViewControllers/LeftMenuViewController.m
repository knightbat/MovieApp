//
//  LeftMenuViewController.m
//  Lendr
//
//  Created by XtronLabs.inc on 26/05/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "LeftMenuViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     Do any additional setup after loading the view.

    profilePic.layer.cornerRadius = profilePic.frame.size.width/2;
    profilePic.clipsToBounds = YES;
    profilePic.layer.borderWidth = 1.0;
    profilePic.layer.borderColor = [[UIColor colorWithRed:59.0/255.0 green:59.0/255.0 blue:59.0/255.0 alpha:1] CGColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
