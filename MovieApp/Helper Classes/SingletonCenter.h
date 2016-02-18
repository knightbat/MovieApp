//
//  SingletonCenter.h
//  MoboApp
//
//  Created by jayakrishnan on 9/17/14.
//  Copyright (c) 2014 mobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonCenter : NSObject


@property (nonatomic, assign) BOOL loginStatus;

+ (SingletonCenter *)sharedSingleton;

@property (strong,nonatomic) NSString *baseUrl;

@end
