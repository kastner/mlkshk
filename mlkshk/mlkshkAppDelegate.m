//
//  mlkshkAppDelegate.m
//  mlkshk
//
//  Created by Erik Kastner on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mlkshkAppDelegate.h"
#import "JSONKit.h"

@implementation mlkshkAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
}

- (IBAction)linkItUp:(id)sender {
    NSLog(@"Pressed");
    
    NSURLResponse *resp = nil;
    NSError *err = nil;

//+ (NSData *)sendSynchronousRequest:(NSURLRequest *)request returningResponse:(NSURLResponse **)response error:(NSError **)error  
//    NSLog(@"username: %@, pass: %@", [username stringValue], [password stringValue]);
    
    NSURL *url = [NSURL URLWithString:@"https://mlkshk.com/api/token"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *body = [NSString stringWithFormat:@"grant_type=password&client_id=F7-E&client_secret=a8e3c32ea3d5d0738c33d73836a9fc87b3c00baf16e02da7de2fdaed&username=%@&password=%@", [username stringValue], [password stringValue]];

    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *foo = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];

    id authStuff = [foo objectFromJSONData];
    

    NSString *access_token = [authStuff valueForKey:@"access_token"];
    
    NSLog(@"resp: %@, foo: %@, JSON'd: %@, token: %@", resp, [NSString stringWithUTF8String:[foo bytes]], authStuff, access_token);
    

    
    MlkImage *mi = [[MlkImage alloc] init];
    [mi setImageUrl:@"http://mlkshk.com/static/images/logo-compact.gif"];
    [mi setName:@"bob"];

    MlkImage *mi2 = [[MlkImage alloc] init];
    [mi2 setImageUrl:@"http://mlkshk.com/static/images/logo-compact.gif"];
    [mi2 setName:@"bob 2"];

    NSMutableArray *imgTmp = [NSMutableArray arrayWithObjects: mi, mi2, nil];
    [mi release];
    [mi2 release];
    
    [self setImages:imgTmp];
    /*
    /api/friends
    
    NSURL *url = [NSURL URLWithString:@"https://mlkshk.com/api/token"];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    NSString *body = [NSString stringWithFormat:@"grant_type=password&client_id=F7-E&client_secret=a8e3c32ea3d5d0738c33d73836a9fc87b3c00baf16e02da7de2fdaed&username=%@&password=%@", [username stringValue], [password stringValue]];
    
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *foo = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    NSLog(@"resp: %@, foo: %@, JSON'd: %@", resp, [NSString stringWithUTF8String:[foo bytes]], [foo objectFromJSONData]);

    */
    
    NSLog(@"made it here");
    
}

-(void)insertObject:(MlkImage *)p inImagesAtIndex:(NSUInteger)index {
    [images insertObject:p atIndex:index];
}

-(void)removeObjectFromImagesAtIndex:(NSUInteger)index {
    [images removeObjectAtIndex:index];
}

-(void)setImages:(NSMutableArray *)a {
    images = a;
}

-(NSArray*)images {
    return images;
}

@end
