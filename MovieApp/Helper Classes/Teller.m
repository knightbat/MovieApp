//
//  Teller.m
//  MoboApp
//
//  Created by Veena on 19/12/14.
//  Copyright (c) 2014 Mobo tactics. All rights reserved.
//

#import "Teller.h"
@implementation Teller
@synthesize delegate,methodSelected;


- (void) getAllMovies{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@/movies.json", [SingletonCenter sharedSingleton].baseUrl ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    methodSelected = @"getMovies";
    
}
- (void) getMovie:(NSString *)movieId{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/movies/%@.json", [SingletonCenter sharedSingleton].baseUrl, movieId ];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    methodSelected = @"getMovie";
}

- (void) getAllAds : (NSDictionary *) dict{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *datestring = [formatter stringFromDate:[NSDate date]];
    NSString *urlString = [NSString stringWithFormat:@"http://pinnla_test.mod.bz/adcalculate_distance/%@/%f/%f",datestring,[[dict valueForKey:@"latitude"]doubleValue],[[dict valueForKey:@"longitude"]doubleValue]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection connectionWithRequest:request delegate:self];
    methodSelected = @"getAds";
    
}

-(void) signinUser:(NSDictionary *)dict
{
    NSString *urlString = [NSString stringWithFormat:@"http://pinnla_test.mod.bz/login/%@/%@",[dict valueForKey:@"username"],[dict valueForKey:@"password"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [NSURLConnection connectionWithRequest:request delegate:self];
    methodSelected = @"signin";
}


- (void) signupUser:(NSDictionary *)dict{
    
   
    NSString *urlString = @"http://pinnla_test.mod.bz/accountcreate";
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",[dict valueForKey:@"username"],[dict valueForKey:@"password"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [NSURLConnection connectionWithRequest:request delegate:self];
    methodSelected = @"signup";
    
}

- (void) addUserExtra:(NSDictionary *)dict{
    

    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDef valueForKey:@"id"];
    NSLog(@"%@",userId);

    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://pinnla_test.mod.bz/"]];
    NSDictionary *parameters = @{@"name": [dict valueForKey:@"name"], @"email" : [dict valueForKey:@"email"]};
    NSString *extraUrl= [NSString stringWithFormat:@"user_update/%@",userId];
    AFHTTPRequestOperation *op = [manager POST:extraUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if ([dict valueForKey:@"image"]) {
            [formData appendPartWithFileData:[dict valueForKey:@"image"] name:@"image" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
        [delegate finishAddingUserExtra:(NSDictionary *)responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        NSDictionary *jsonArray = [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"status", nil];
        [delegate finishAddingUserExtra:jsonArray];
    }];
    [op start];
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if (response) {
        
        NSHTTPURLResponse* newResp = (NSHTTPURLResponse*)response;
        NSLog(@"%@",newResp);
    }
   
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{

//     NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//     NSLog(@"%@",str);
    NSError *e;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    if (e) {
        
        if ( [methodSelected isEqualToString:@"postMessage"] || [methodSelected isEqualToString:@"getViews"]) {
            jsonArray = [NSDictionary dictionaryWithObject:@"error" forKey:@"error"];
        }else{
            e = nil;
            jsonArray = (NSDictionary*) [NSArray arrayWithObject:@"error"];
        }
    }
    if([methodSelected isEqualToString:@"signin"]){
        
        [delegate finishSigninUser:jsonArray];
    }else if ([methodSelected isEqualToString:@"getAds"]){
        [delegate finishGettingAllAds:jsonArray];
    }else if([methodSelected isEqualToString:@"signup"]){
        [delegate finishSignupUser:jsonArray];
    }else if([methodSelected isEqualToString:@"getMovies"]){
        [delegate finishGettingAllMovies:jsonArray];
    }else if ([methodSelected isEqualToString:@"getMovie"]){
        [delegate finishGettingMovie:jsonArray];
    }
}
@end
