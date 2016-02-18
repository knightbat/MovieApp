//
//  CommentTableViewCell.m
//  MovieApp
//
//  Created by XtronLabs.inc on 12/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2;
    self.userImage.clipsToBounds = YES;
    self.userImage.layer.borderColor = [[UIColor grayColor] CGColor];
    self.userImage.layer.borderWidth = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
