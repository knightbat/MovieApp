//
//  MainMenuViewController.m
//  Lendr
//
//  Created by XtronLabs.inc on 26/05/15.
//  Copyright (c) 2015 XtronLabs.inc. All rights reserved.
//
#import "MainMenuViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

/*----------------------------------------------------*/
#pragma mark - Overriden Methods -
/*----------------------------------------------------*/

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"";
    switch (indexPath.row) {
        case 0:
            identifier = @"movieList";
            break;
        case 1:
            identifier = @"login";
            break;
        case 2:
            identifier = @"movieList";
            break;

    }
    
    return identifier;
}

/**
 * NOTE! If you override this method, then segueIdentifierForIndexPathInLeftMenu will be ignored
 * Return instantiated navigation controller that will opened
 * when cell at indexPath will be selected from left menu
 * @param indexPath of left menu table
 * @return UINavigationController instance for input indexPath
 */
/*
 - (UINavigationController *)navigationControllerForIndexPathInLeftMenu:(NSIndexPath *)indexPath
 {
 NSString *storyboardId = @"";
 
 switch (indexPath.row) {
 case 0:
 storyboardId = @"FirstNC";
 break;
 case 1:
 storyboardId = @"SecondNC";
 break;
 }
 
 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
 UINavigationController *nc = [storyboard instantiateViewControllerWithIdentifier:storyboardId];
 return nc;
 }
 */

//- (NSString *)segueIdentifierForIndexPathInRightMenu:(NSIndexPath *)indexPath
//{
//    NSString *identifier = @"";
//    switch (indexPath.row) {
//        case 0:
//            identifier = @"first";
//            break;
//        case 1:
//            identifier = @"first";
//            break;
//    }
//    
//    return identifier;
//}

- (CGFloat)leftMenuWidth
{
    return 180;
}

- (CGFloat)rightMenuWidth
{
    return 180;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 25);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
}

- (void)configureRightMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(0, 0, 25, 25);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"simpleMenuButton"] forState:UIControlStateNormal];
}

- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 5;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
}

- (UIViewAnimationOptions) openAnimationCurve {
    return UIViewAnimationOptionCurveEaseOut;
}

- (UIViewAnimationOptions) closeAnimationCurve {
    return UIViewAnimationOptionCurveEaseOut;
}

- (AMPrimaryMenu)primaryMenu
{
    return AMPrimaryMenuLeft;
}


// Enabling Deepnes on left menu
- (BOOL)deepnessForLeftMenu
{ 
    return YES;
}

// Enabling Deepnes on left menu
- (BOOL)deepnessForRightMenu
{
    return YES;
}


// Enabling darkness while left menu is opening
- (CGFloat)maxDarknessWhileLeftMenu
{
    return 0.5;
}

// Enabling darkness while right menu is opening
- (CGFloat)maxDarknessWhileRightMenu
{
    return 0.5;
}

@end
