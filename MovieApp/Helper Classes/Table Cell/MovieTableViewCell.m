//
//  MovieTableViewCell.m
//  TestApp
//
//  Created by XtronLabs.inc on 02/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.movieImage.showActivityIndicator = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
