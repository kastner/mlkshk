//
//  MlkImage.m
//  mlkshk
//
//  Created by Erik Kastner on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MlkImage.h"


@implementation MlkImage

@synthesize image;
@synthesize title;
@synthesize description;
@synthesize originalImageUrl;
@synthesize permalinkPage;
@synthesize postedAt;
@synthesize user;
@synthesize width;
@synthesize height;
@synthesize views;

- (id)initFromData:(id)data {
//    Data is formerly json that looks like this:
//    {
//        description = "source: http://streetcar.org/store/travel.html#celestial-nights";
//        height = 534;
//        name = "celestial-nights-poster-col-4.png";
//        "original_image_url" = "http://mlkshk.com/r/19T4";
//        "permalink_page" = "http://mlkshk.com/p/19T4";
//        "posted_at" = "2011-03-30T02:57:11Z";
//        title = "Nice SF poster";
//        user =             {
//            id = 13;
//            name = mathowie;
//        };
//        views = 115;
//        width = 420;
//    }
//    and has been converted to a dictionary

    [super init];
    
    if ([data valueForKey:@"description"]) {
        [self setDescription:[data valueForKey:@"description"]];
    }
    
    if ([data valueForKey:@"original_image_url"]) {
        [self setOriginalImageUrl:[data valueForKey:@"original_image_url"]];
        
        NSURL *imageURL = [NSURL URLWithString:[self originalImageUrl]];
        //image = [[NSImage alloc] initByReferencingURL:imageURL];
        
        //NSData *imageData = [imageURL resourceDataUsingCache:<#(BOOL)#>];
        //NSImage *imageFromData = [[NSImage alloc] initWithData:imageData];
        
        //[self setImage:imageFromData];
        //[imageFromData release];
        
        NSURLRequest *req = [NSURLRequest requestWithURL:imageURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
        
        imageConn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    }
    
    if ([data valueForKey:@"permalink_page"]) {
        [self setPermalinkPage:[data valueForKey:@"permalink_page"]];
    }
    
    /*
    if ([data valueForKey:@"posted_at"]) {
        NSDate *date = [NSDate dateWithString:[data valueForKey:@"posted_at"]];
        [self setPostedAt:date];
    }
    */

    if ([data valueForKey:@"title"]) {
        [self setTitle:[data valueForKey:@"title"]];
    }
    
    if ([data valueForKey:@"user"]) {
        
        MlkUser *dataUser = [[MlkUser alloc] initFromData:[data valueForKey:@"user"]];
        [self setUser:dataUser];
        [user release];
    }
    
    

    return self;
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
    if (imageData == nil) { 
        imageData = [[NSMutableData alloc] initWithCapacity:2048];
    }
    
    [imageData appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	[imageConn release];
	imageConn = nil;
    
    if ([self image] != nil) { 
        [[self image] release];
        image = nil;
    }
    
    [self setImage: [[NSImage alloc] initWithData:imageData]];

	
	[imageData release];
	imageData = nil;
}


- (void)dealloc
{
    [image release];
    [title release];
    [description release];
    [originalImageUrl release];
    [permalinkPage release];
    [postedAt release];
    [user release];
    [super dealloc];
}

@end
