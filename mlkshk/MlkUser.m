//
//  MlkUser.m
//  mlkshk
//
//  Created by Erik Kastner on 3/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MlkUser.h"


@implementation MlkUser

@synthesize name;
@synthesize userId;

- (id)initFromData:(id)data {
    //    Data is formerly json that looks like this:
    //    {
    //        id = 13;
    //        name = mathowie;
    //    };
    //    and has been converted to a dictionary
    
    [super init];
    
    if ([data valueForKey:@"id"]) {
        [self setUserId:(NSNumber *)[data valueForKey:@"id"]];
    }
    
    if ([data valueForKey:@"name"]) {
        [self setName:[data valueForKey:@"name"]];
    }
    
    return self;
}

- (void)dealloc
{
    [name release];
    [userId release];
    [super dealloc];
}

@end
