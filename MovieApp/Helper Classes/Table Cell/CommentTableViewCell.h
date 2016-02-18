//
//  CommentTableViewCell.h
//  MovieApp
//
//  Created by XtronLabs.inc on 12/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *commentText;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;

@end
