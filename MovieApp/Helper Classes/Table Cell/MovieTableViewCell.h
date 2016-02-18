//
//  MovieTableViewCell.h
//  TestApp
//
//  Created by XtronLabs.inc on 02/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MovieTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *movieName;

@property (weak, nonatomic) IBOutlet AsyncImageView *movieImage;
@property (weak, nonatomic) IBOutlet UIButton *movieButton;
@property (weak, nonatomic) IBOutlet UILabel *favCount;
@property (weak, nonatomic) IBOutlet UILabel *cmtCount;

@end
