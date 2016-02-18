//
//  Animation.h
//
//NavigationController
//

#import <Foundation/Foundation.h>
#import "QuartzCore/QuartzCore.h"
#import <UIKit/UIKit.h>

@interface NavAnimation : NSObject

//reveal
+ (void)animationRevealFromBottom:(UIView *)view;
+ (void)animationRevealFromTop:(UIView *)view;
+ (void)animationRevealFromLeft:(UIView *)view;
+ (void)animationRevealFromRight:(UIView *)view;

+ (void)animationEaseIn:(UIView *)view;
+ (void)animationEaseOut:(UIView *)view;

+ (void)animationFlipFromLeft:(UIView *)view;
+ (void)animationFlipFromRigh:(UIView *)view;

+ (void)animationCurlUp:(UIView *)view;
+ (void)animationCurlDown:(UIView *)view;

+ (void)animationRotateAndScaleEffects:(UIView *)view;
+ (void)animationRotateAndScaleDownUp:(UIView *)view;

//push
+ (void)animationPushUp:(UIView *)view;
+ (void)animationPushDown:(UIView *)view;
+ (void)animationPushLeft:(UIView *)view;
+ (void)animationPushRight:(UIView *)view;

//move
+ (void)animationMoveUp:(UIView *)view;
+ (void)animationMoveDown:(UIView *)view;
+ (void)animationMoveLeft:(UIView *)view;
+ (void)animationMoveRight:(UIView *)view;


+ (void)animationFlipFromTop:(UIView *)view;
+ (void)animationFlipFromBottom:(UIView *)view;

+ (void)animationCubeFromLeft:(UIView *)view;
+ (void)animationCubeFromRight:(UIView *)view;
+ (void)animationCubeFromTop:(UIView *)view;
+ (void)animationCubeFromBottom:(UIView *)view;

+ (void)animationSuckEffect:(UIView *)view;
+ (void)animationRippleEffect:(UIView *)view;

+ (void)animationCameraOpen:(UIView *)view;
+ (void)animationCameraClose:(UIView *)view;


@end
