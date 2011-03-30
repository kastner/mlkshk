//
//  MlkUser.h
//  mlkshk
//
//  Created by Erik Kastner on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MlkUser : NSObject {
    NSNumber *userId;
    NSString *name;
}

@property(retain, readwrite) NSString *name;
@property(retain, readwrite) NSNumber *userId;

- (id) initFromData:(id)data;

@end
