//
//  CommentViewController.m
//  MovieApp
//
//  Created by XtronLabs.inc on 12/06/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController (){
    
    
    NSArray *messageArray;
}

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    messageArray = [[NSArray alloc]initWithObjects:
                    @"kkk",
                    @"hjghghhgghhghgghhghghhghjjhjjjjjkjkjkjkjjjkkjkjkjjkjkjkkjkjjkjkjkklklkllkllklkkllllklklkllkl",
                    @"tdgfg",
                    @"bbbbbbbnbnbnbnbnbnbnbnnbnbbnbnbnbnbnnnbbnbnbnnbbnbnbnbnbnbnbnbnbnbnbnbnbbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnbnnbnbnbnbnbnbnbnbnbbnbnbnnbnbnbnbnbbnnbnbnbbnbnnbbnbnnb",
                    @"bjbjbjjkjkkjkjllklkklklklklklklklklklklkllkkl",
    
                    nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_w"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];

    // geting notifications
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
}

- (void)viewWillLayoutSubviews {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void) goBack{
    
    [NavAnimation animationRevealFromBottom:self.navigationController.view];
    
    [self.navigationController popViewControllerAnimated:NO];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.commentText.text = [messageArray objectAtIndex:indexPath.row];
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    float computedWidth = self.view.frame.size.width - 80;
    
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
    
//    NSLog(@"%f %f",size.height,newSize.height);
    
    return size.height+55;
}

-(void)keyboardOnScreen:(NSNotification *)notification
{
    
    //dynamic keyboard changer by jk
    
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    
    NSLog(@"keyboardFrame: %f", keyboardFrame.size.height);
    float changeValue = self.view.frame.origin.x-keyboardFrame.size.height+self.navigationController.navigationBar.frame.size.height+20; // orgin - keyboard hight +navbar+statusbar
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.2];
    self.view.frame = CGRectMake(self.view.frame.origin.x, changeValue , self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return  true;
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
  
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.1];
    self.view.frame = CGRectMake(self.view.frame.origin.x,self.navigationController.navigationBar.frame.size.height+20, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (IBAction)sendButton:(id)sender {
    
    NSLog(@"sel");
}
@end
