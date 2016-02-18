//
//  MovieListViewController.h
//  TestApp
//
//  Created by XtronLabs.inc on 02/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"
#import "MovieTableViewCell.h"
#import "FullViewController.h"
#import "NavAnimation.h"
#import "Teller.h"
#import "SingletonCenter.h"

@interface MovieListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,TellerDelegate>{
    

    __weak IBOutlet UITableView *tableview1;
    __weak IBOutlet UITableView *tableview2;
}

- (IBAction)selectMovieType:(id)sender;

@property UISearchBar *searchBar ;
@end
