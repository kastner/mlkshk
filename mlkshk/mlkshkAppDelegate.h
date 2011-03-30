//
//  mlkshkAppDelegate.h
//  mlkshk
//
//  Created by Erik Kastner on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MlkImage.h"

@interface mlkshkAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    IBOutlet NSTextField *username;
    IBOutlet NSSecureTextField *password;
    IBOutlet NSCollectionView *friendGrid;
    
    NSMutableArray *images;
}

@property (assign) IBOutlet NSWindow *window;
@property (readwrite, retain) NSMutableArray *images;

- (IBAction)linkItUp:(id)sender;

@end
