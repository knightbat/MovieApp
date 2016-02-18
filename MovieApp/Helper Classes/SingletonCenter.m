//
//  SingletonCenter.m
//  MoboApp
//
//  Created by jayakrishnan on 9/17/14.
//  Copyright (c) 2014 mobo. All rights reserved.
//

#import "SingletonCenter.h"

@implementation SingletonCenter

static SingletonCenter *shared = NULL;

+ (SingletonCenter *)sharedSingleton
{
    @synchronized(shared)
    {
        if ( !shared || shared == NULL )
        {
            // allocate the shared instance, because it hasn't been done yet
            shared = [[SingletonCenter alloc] init];
        }
        
        return shared;
    }
}

- (id)init
{
    if ( self = [super init] )
    {
        // init values
        // here you assign initial values to your variable.
        
        
        self.baseUrl = [[NSString alloc]initWithFormat:@"http://localhost:3000"];

        
        
    }
    return self;
    
}


@end
