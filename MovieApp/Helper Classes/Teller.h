//
//  Teller.h
//  MoboApp
//
//  Created by Veena on 19/12/14.
//  Copyright (c) 2014 Mobo tactics. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "SingletonCenter.h"
@protocol TellerDelegate <NSObject>

- (void) finishGettingAllAds:(NSDictionary *)dict;
- (void) finishSigninUser: (NSDictionary *) dict;
- (void) finishSignupUser: (NSDictionary *) dict;
- (void) finishAddingUserExtra : (NSDictionary *) dict;
- (void) finishGettingAllMovies : (NSDictionary *) dict;
- (void) finishGettingMovie : (NSDictionary *) dict;

@end
@interface Teller : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    id <TellerDelegate> delegate;
}
@property (nonatomic, assign) NSString *methodSelected;
@property(nonatomic,strong)id <TellerDelegate> delegate;
- (void) getAllAds : (NSDictionary *) dict;
- (void) signupUser :(NSDictionary *) dict;
- (void) addUserExtra : (NSDictionary *)dict;
- (void) getAllMovies;
- (void) getMovie: (NSString *) movieId;

@end
