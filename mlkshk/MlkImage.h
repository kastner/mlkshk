//
//  MlkImage.h
//  mlkshk
//
//  Created by Erik Kastner on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MlkImage : NSObject {
    NSString *name;
    NSString *imageUrl;
}

@property(retain, readwrite) NSString *name;
@property(retain, readwrite) NSString *imageUrl;

@end
