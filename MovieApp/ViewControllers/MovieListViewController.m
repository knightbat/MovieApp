//
//  MovieListViewController.m
//  TestApp
//
//  Created by XtronLabs.inc on 02/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "MovieListViewController.h"

@interface MovieListViewController (){
    
    UISearchBar *topSearcBar;
    UIBarButtonItem *rightBtn;
    UIBarButtonItem *searchButton ;
    NSArray *movieList;
    NSInteger movieCount ;
    AsyncImageView *asyncImage;
    NSString *toNext;
    Teller *tlr;
}

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tlr = [[Teller alloc]init];
    tlr.delegate = self;
    [tlr getAllMovies];
    
    [self setupSearch];
    
    
    
    
    asyncImage = [[AsyncImageView alloc]init];
    
    
    
    NSNotificationCenter *notifyCenter = [NSNotificationCenter defaultCenter];
    [notifyCenter addObserverForName:nil
                              object:nil
                               queue:nil
                          usingBlock:^(NSNotification* notification){
                              // Explore notification
                              //                              NSLog(@"Notification found with:"
                              //                                    "\r\n     name:     %@"
                              //                                    "\r\n     object:   %@"
                              //                                    "\r\n     userInfo: %@",
                              //                                    [notification name],
                              //                                    [notification object],
                              //                                    [notification userInfo]);
                              
                              if ([[notification name] isEqualToString:@"AsyncImageLoadDidFinish"]) {
                                  
                                  [tableview1 reloadData];
                                  [tableview2 reloadData];
                              }
                          }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [tableview1 reloadData];
    [tableview2 reloadData];
    [tlr getAllMovies];
    
    //    self.navigationItem.titleView = nil;
    //    self.navigationItem.rightBarButtonItem = searchButton;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    UITableView *slaveTable = nil;
    
    if (tableview1 == scrollView) {
        slaveTable = tableview2;
    } else if (tableview2 == scrollView) {
        slaveTable = tableview1;
    }
    
    [slaveTable setContentOffset:scrollView.contentOffset];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag) {
        return movieCount/2;
    }else{
        
        return movieCount-(movieCount/2);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell"];
    
    if (tableView.tag) {
        
        if (2*indexPath.row+1 < movieCount) {
            
            NSString *url = [NSString stringWithFormat:@"%@%@",[SingletonCenter sharedSingleton].baseUrl, [[movieList objectAtIndex:2*indexPath.row+1] valueForKey:@"thumb"]];
            
            cell.movieImage.imageURL = [NSURL URLWithString:url];
            cell.movieName.text = [[movieList objectAtIndex:2*indexPath.row+1] valueForKey:@"name"];
            cell.cmtCount.text = @"300";
            cell.favCount.text = @"70";
            
        }
        return cell;
    }else{
        NSString *url = [NSString stringWithFormat:@"%@%@",[SingletonCenter sharedSingleton].baseUrl, [[movieList objectAtIndex:2*indexPath.row] valueForKey:@"thumb"]];
        cell.movieImage.imageURL = [NSURL URLWithString:url];
        cell.movieName.text = [[movieList objectAtIndex:2*indexPath.row] valueForKey:@"name"];
        cell.cmtCount.text = @"300";
        cell.favCount.text = @"70";
        return cell;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    if (tableView.tag) {
        
        if (indexPath.row == movieCount/2 - 1) {
            
            [self fixHeight];
        }
        asyncImage.image = [UIImage imageNamed:@"default-placeholder.png"];
        NSString *url = [NSString stringWithFormat:@"%@%@",[SingletonCenter sharedSingleton].baseUrl, [[movieList objectAtIndex:2*indexPath.row+1] valueForKey:@"thumb"]];
        asyncImage.imageURL=[NSURL URLWithString: url];
        
        float width = self.view.frame.size.width/2 - 4;
        float height = width*asyncImage.image.size.height/asyncImage.image.size.width;
        return height+64;
        
        
    }else{
        
        if (indexPath.row == movieCount- movieCount/2 - 1) {
            [self fixHeight];
        }
        
        asyncImage.image = [UIImage imageNamed:@"default-placeholder.png"];
        NSString *url = [NSString stringWithFormat:@"%@%@",[SingletonCenter sharedSingleton].baseUrl,[[movieList objectAtIndex:2*indexPath.row] valueForKey:@"thumb"]];
        asyncImage.imageURL=[NSURL URLWithString:url];
        float width = self.view.frame.size.width/2 - 4;
        float height = width*asyncImage.image.size.height/asyncImage.image.size.width;
        return height+64;
    }
    
}


- (void) fixHeight{
    
    // if two table view has diff height size it will be hard to scroll
    
    if (tableview2.contentSize.height > tableview1.contentSize.height) {
        
        tableview1.contentSize = CGSizeMake(tableview1.contentSize.width, tableview2.contentSize.height);
    }else{
        
        tableview2.contentSize = CGSizeMake(tableview2.contentSize.width, tableview1.contentSize.height);
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (tableView.tag) {
        
        toNext = [movieList objectAtIndex:2*indexPath.row+1];
        
    }else{
        
        toNext = [movieList objectAtIndex:2*indexPath.row];
        
    }
    
    FullViewController *fullView = [self.storyboard instantiateViewControllerWithIdentifier:@"fullView"];
    
    fullView.movieId = [toNext valueForKey:@"id"];
    [NavAnimation animationFlipFromRigh: self.navigationController.view];
    [self.navigationController pushViewController:fullView animated:NO];
    
}


- (void) setupSearch{
    
    self.searchBar = [[UISearchBar alloc] init];
    _searchBar.showsCancelButton = YES;
    _searchBar.tintColor = [UIColor colorWithRed:185.0/255.0 green:188.0/255 blue:189/255.0 alpha:1];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"search movies...";
    searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStyleBordered target:self action:@selector(search)];
    searchButton.tintColor = [UIColor colorWithRed:185.0/255.0 green:188.0/255 blue:189/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = searchButton;
}

- (void)search {
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
    } completion:^(BOOL finished) {
        
        // remove the search button
        self.navigationItem.rightBarButtonItem = nil;
        // add the search bar (which will start out hidden).
        self.navigationItem.titleView = _searchBar;
        _searchBar.alpha = 0.0;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             _searchBar.alpha = 1.0;
                         } completion:^(BOOL finished) {
                             [_searchBar becomeFirstResponder];
                         }];
        
    }];
}

#pragma mark UISearchBarDelegate methods
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [UIView animateWithDuration:0.5f animations:^{
        _searchBar.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.navigationItem.titleView = nil;
        self.navigationItem.rightBarButtonItem = searchButton;
        [UIView animateWithDuration:0.5f animations:^ {
        }];
    }];
    
}


- (IBAction)selectMovieType:(id)sender {
    
    NSLog(@"%ld",(long)[sender selectedSegmentIndex]);
}

- (void)finishGettingAllMovies:(NSDictionary *)dict{
    
    movieList =[ [NSArray alloc]initWithArray:(NSArray *)dict];
    movieCount = movieList.count;
    
    [tableview1 reloadData];
    [tableview2 reloadData];
}
@end
