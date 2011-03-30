//
//  mlkshkAppDelegate.m
//  mlkshk
//
//  Created by Erik Kastner on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "mlkshkAppDelegate.h"
#import "JSONKit.h"
#import <CommonCrypto/CommonHMAC.h>
#import "Base64Transcoder.h"

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
    NSString *secret = [authStuff valueForKey:@"secret"];
    
    NSLog(@"resp: %@, foo: %@, JSON'd: %@, token: %@", resp, [NSString stringWithUTF8String:[foo bytes]], authStuff, access_token);
    

    
    MlkImage *mi = [[MlkImage alloc] init];
    [mi setOriginalImageUrl:@"http://mlkshk.com/r/19T4"];
    [mi setTitle:@"bob"];

    MlkImage *mi2 = [[MlkImage alloc] init];
    [mi2 setOriginalImageUrl:@"http://mlkshk.com/static/images/logo-compact.gif"];
    [mi2 setTitle:@"bob 2"];

    NSMutableArray *imgTmp = [NSMutableArray arrayWithObjects: mi, mi2, nil];
    [mi release];
    [mi2 release];
    
    [self setImages:imgTmp];
    
//    return;
    
    int timestamp = (int)[[NSDate date] timeIntervalSince1970];
    NSString *nonce = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        
    NSString *normString = [NSString stringWithFormat:@"%@\n%d\n%@\nGET\nmlkshk.com\n80\n%@\n",
                            access_token, timestamp, nonce, @"/api/friends"];
    
    
    //NSLog(@"Norm string: %@", normString);

    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    CCHmacContext hmacContext;
    CCHmacInit(&hmacContext, kCCHmacAlgSHA1, [[secret dataUsingEncoding:NSUTF8StringEncoding] bytes], [[secret dataUsingEncoding:NSUTF8StringEncoding] length]);
    CCHmacUpdate(&hmacContext, [[normString dataUsingEncoding:NSUTF8StringEncoding] bytes], [[normString dataUsingEncoding:NSUTF8StringEncoding] length]);
    CCHmacFinal(&hmacContext, digest);
    
    char base64Result[32];
    size_t theResultLength = 32;
    Base64EncodeData(digest, CC_SHA1_DIGEST_LENGTH, base64Result, &theResultLength);
    NSData *theData = [NSData dataWithBytes:base64Result length:theResultLength];
    
    NSString *signature = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    
    NSString *authorizationString = [NSString stringWithFormat:@"MAC token=\"%@\", timestamp=\"%d\", nonce=\"%@\", signature=\"%@\"", access_token, timestamp, nonce, signature];
    
    
    //req = urllib2.Request(RESOURCE_URL,headers={ 'Authorization' : authorization_string })

    url = [NSURL URLWithString:@"https://mlkshk.com/api/friends"];
    req = [NSMutableURLRequest requestWithURL:url];
    [req setValue:authorizationString forHTTPHeaderField:@"Authorization"];
    
    
    foo = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    //NSLog(@"resp: %@, foo: %@, JSON'd: %@", resp, [NSString stringWithUTF8String:[foo bytes]], [foo objectFromJSONData]);
    
    imgTmp = [[NSMutableArray alloc] init];

    id friendTime = [[foo objectFromJSONData] valueForKey:@"friend_shake"];

    
    NSEnumerator *friendEnum = [friendTime objectEnumerator];
    
    id friendImage;
    while ((friendImage = [friendEnum nextObject])) {
        //NSLog(@"Here?: %@", [friendImage valueForKey:@"original_image_url"]);
        MlkImage *mi = [[MlkImage alloc] initFromData:friendImage];

//        NSURL *imageURL = [NSURL URLWithString:[friendImage valueForKey:@"original_image_url"]];
//        NSData *imageData = [imageURL resourceDataUsingCache:NO];
//        NSImage *imageFromBundle = [[NSImage alloc] initWithData:imageData];
//
//        
//        
//        [mi setImage:[friendImage valueForKey:@"original_image_url"]];
//        [mi setName:[NSString stringWithFormat:@"%@ by %@", [friendImage valueForKey:@"title"], [[friendImage valueForKey:@"user"] valueForKey:@"name"]]];
        
        [imgTmp addObject:mi];
                
        [mi release];
    }

    [self setImages:imgTmp];
    [imgTmp release];
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
