//
//  MlkImage.h
//  mlkshk
//
//  Created by Erik Kastner on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MlkUser.h"


@interface MlkImage : NSObject {
    NSImage *image;
    NSString *title;
    NSString *description;
    NSString *originalImageUrl;
    NSString *permalinkPage;
    NSDate *postedAt;
    MlkUser *user;
    int width;
    int height;
    int views;
    
    NSMutableData *imageData;
    NSURLConnection *imageConn;
}

@property(retain, readwrite) NSImage *image;
@property(retain, readwrite) NSString *title;
@property(retain, readwrite) NSString *description;
@property(retain, readwrite) NSString *originalImageUrl;
@property(retain, readwrite) NSString *permalinkPage;
@property(retain, readwrite) NSDate *postedAt;
@property(retain, readwrite) MlkUser *user;
@property(readwrite) int width;
@property(readwrite) int height;
@property(readwrite) int views;

- (id) initFromData:(id)data;

@end
