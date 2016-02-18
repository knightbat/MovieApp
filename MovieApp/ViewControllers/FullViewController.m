//
//  FullViewController.m
//  MovieApp
//
//  Created by XtronLabs.inc on 11/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "FullViewController.h"

@interface FullViewController (){
    
    GPPSignIn *signIn;
    
    BOOL isFullView;
    NSArray *messageArray;
}

@end

@implementation FullViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    Teller *tlr = [[Teller alloc]init];
    tlr.delegate = self;
    [tlr getMovie:self.movieId];
   
    mainImage.showActivityIndicator = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:81.0/255.0 green:196.0/255 blue:212.0/255.0 alpha:.5];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_w"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    messageArray = [[NSArray alloc]initWithObjects:
                    @"kkk",
                    @"hjghghhgghhghgghhghghhghjjhjjjjjkjkjkjkjjjkkjkjkjjkjkjkkjkjjkjkjkklklkllkllklkkllllklklkllkl",
                    @"tdgfg",
                    @"bbbbbbbnbnbnbnbnbnbnbnnbnbbnbnbnbnbnnnbbnbnbnnbbnbnbnbnbnbnbnbnbnbnbnbnbbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnnbnbnbnbnbnbnbnbnbbnbnbnnbnbnbnbnbbnnbnbnbbnbnnbbnbnnb",
                    @"bjbjbjjkjkkjkjllklkklklklklklklklklklklkllkkl",
                    
                    nil];
    
//    tableView.dataSource = self;
//    tableView.delegate = self;
    [[GPPSignIn sharedInstance] trySilentAuthentication];
    isFullView = NO;
    detailsTableView.hidden = YES;
    blurHight.constant = self.view.frame.size.height/3.5;

}

- (void)viewWillLayoutSubviews {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void) goBack{
    
    [NavAnimation animationFlipFromLeft:self.navigationController.view];
    
    [self.navigationController popViewControllerAnimated:NO];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)viewDidAppear:(BOOL)animated{
    
    blurView.dynamic = YES;
    blurView.blurRadius = 10;
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)commentBtn:(id)sender {
    
    
    CommentViewController *destView = [self.storyboard instantiateViewControllerWithIdentifier:@"commentView"];
//    fullView.url = toNext;
    [NavAnimation animationMoveUp: self.navigationController.view];
    [self.navigationController pushViewController:destView animated:NO];
}

- (IBAction)likeButton:(id)sender {
  
    if ([likButton.imageView.image isEqual: [UIImage imageNamed:@"favorites_s"]]) {
        [likButton setImage:[UIImage imageNamed:@"favorites"] forState:UIControlStateNormal];
    }else{
        
        [likButton setImage:[UIImage imageNamed:@"favorites_s"] forState:UIControlStateNormal];

    }

    
}

- (IBAction)shareButton:(id)sender {
    
    
    if ([UIAlertController class]) {
        
        // UIAlertController code for ios8 with image
        
        
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"share"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController.view setTintColor:[UIColor colorWithRed:81.0/255.0 green:196.0/255 blue:212.0/255.0 alpha:1]];
        
        UIAlertAction* fbShare = [UIAlertAction actionWithTitle:@"Share on Facebook" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action){
                                                            
                                                            [self initFb];
                                                        }];
        [fbShare setValue:[UIImage imageNamed:@"fb"] forKey:@"image"];
        
        
        UIAlertAction* gplusShare = [UIAlertAction actionWithTitle:@"Share on Google Plus" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               [self initGplus];
                                                           }];
        [gplusShare setValue:[UIImage imageNamed:@"gplus"] forKey:@"image"];
        
        UIAlertAction* twitterShare = [UIAlertAction actionWithTitle:@"Share on Twitter" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action){
                                                                 
                                                                 [self initTwitter];
                                                             }];
        [twitterShare setValue:[UIImage imageNamed:@"twitter"] forKey:@"image"];
        
        
        UIAlertAction* pinterestShare = [UIAlertAction actionWithTitle:@"Share on Pinterest" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action){
                                                                   
                                                                   [self initPinterest];
                                                               }];
        [pinterestShare setValue:[UIImage imageNamed:@"pin"] forKey:@"image"];
        
        
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           [alertController dismissViewControllerAnimated:YES completion:nil];
                                                           
                                                       }];
        
        [alertController addAction:fbShare];
        [alertController addAction:gplusShare];
        [alertController addAction:twitterShare];
        [alertController addAction:pinterestShare];
        [alertController addAction:cancel];
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover)
        {
            popover.sourceView = sender;
            popover.sourceRect = ((UIButton *)sender).bounds;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
        
        
        
    } else {
        
        
        //uiactionsheet for ios 7 and below without image
        // need sdk 7 to test image in action sheet
        
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Sharing option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"Share on Facebook",
                                @"Share on Google+",
                                @"Share on Pinterest",
                                @"Share on Twitter",
                                nil];
        
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            // In this case the device is an iPad.
            [popup showFromRect:[(UIButton *)sender frame] inView:blurView animated:YES];
        }
        else{
            // In this case the device is an iPhone/iPod Touch.
            [popup showInView:[UIApplication sharedApplication].keyWindow];
            
            
        }
        
        
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    if (isFullView) {
        
        float mainHeight = self.view.frame.size.height;
        
        blurHight.constant = mainHeight;
        
        detailsTableView.frame = CGRectMake(0, 45, self.view.frame.size.width, mainHeight - 80);
        
    }else{
        blurHight.constant = self.view.frame.size.height/3.5;
    }
}


- (IBAction)upButton:(id)sender {
   
    float mainHeight = self.view.frame.size.height;
    
    if (isFullView) {

        
        [self.view layoutIfNeeded];
        
        blurHight.constant = mainHeight/3.5;

        [UIView animateWithDuration:1 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [((UIButton *)sender) setImage:[UIImage imageNamed:@"up_arrow"] forState:UIControlStateNormal];
            detailsTableView.hidden = YES;

        }];
        isFullView = NO;

    }else{
        

        [self.view layoutIfNeeded]; // Called on parent view

        blurHight.constant = mainHeight;
        detailsTableView.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            [((UIButton *)sender) setImage:[UIImage imageNamed:@"down_arrow"] forState:UIControlStateNormal];

        }];
        isFullView = YES;

    }

}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        
        [self initFb];
        
    }else if(buttonIndex == 1){
        
        [self initGplus];
        
    }else if (buttonIndex == 2){
        
        [self initPinterest];
        
    }else if(buttonIndex == 3){
        
        [self initTwitter];
    }
}


- (void) initFb{
    
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:@"http://www.fb.com"];
    content.contentTitle = @"title";
    //        NSString *imgUrl = [self.dict valueForKey:@"image"];
    content.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://upload.wikimedia.org/wikipedia/commons/a/af/Tux.png"]];
    content.contentDescription = @"desc";
    [FBSDKShareDialog showFromViewController:self
                                 withContent:content
                                    delegate:nil];

}
- (void) initGplus{
    
    

    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
    signIn.delegate = self;
    [signIn authenticate];
}

- (void) initPinterest{
    
    
    Pinterest *pinterest = [[Pinterest alloc]initWithClientId:@"1445909"];
    [pinterest createPinWithImageURL:[NSURL URLWithString: @"http://a.fsdn.com/con/app/proj/osltrix/screenshots/Screenshot%20-%20Sunday%2008%20June%202014%20-%2011:28:57%20%20IST.png"]
                            sourceURL:[NSURL URLWithString: @"http://osltrix.sf.net"]
                          description:@"osltrix"];
}

- (void) initTwitter{
    
    TWTRComposer *composer = [[TWTRComposer alloc] init];
    
    [composer setText:@"watching movie"];
    [composer setImage:mainImage.image];
//    [composer setURL:[NSURL URLWithString:@"http://a.fsdn.com/con/app/proj/osltrix/screenshots/Screenshot%20-%20Sunday%2008%20June%202014%20-%2011:28:57%20%20IST.png"]];
    [composer showWithCompletion:^(TWTRComposerResult result) {
        if (result == TWTRComposerResultCancelled) {
            NSLog(@"Tweet composition cancelled");
        }
        else {
            NSLog(@"Sending Tweet!");
        }
    }];
}

- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
    
    if (!error) {
        
        id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
        
//        [shareBuilder setURLToShare:[NSURL URLWithString:@"https://imdb.com"]];
        
        [shareBuilder setPrefillText:@"my movie"];
        
        [shareBuilder attachImage:mainImage.image];
        
        [shareBuilder open];
    }else {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"failed to connect gplus. try again later" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    float computedWidth = self.view.frame.size.width/2 - 18;
    
    CGSize  textSize = { computedWidth, 10000.0 };
    NSString* result = [[messageArray objectAtIndex:indexPath.row]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    CGSize size = [result sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:textSize lineBreakMode:NSLineBreakByWordWrapping];
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:result
                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    CGRect rect = [attributedText boundingRectWithSize:textSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    return size.height+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieDetailsTableViewCell"];
    cell.data.text = [messageArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return messageArray.count;
}

- (void)finishGettingMovie:(NSDictionary *)dict{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",[SingletonCenter sharedSingleton].baseUrl,[dict valueForKey:@"thumb"] ];
    mainImage.imageURL = [NSURL URLWithString:url];
    movieName.text = [dict valueForKey:@"name"];

}

@end
