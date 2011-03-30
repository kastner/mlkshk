//
//  MlkImage.m
//  mlkshk
//
//  Created by Erik Kastner on 3/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MlkImage.h"


@implementation MlkImage

@synthesize name;
@synthesize imageUrl;

- (void)dealloc
{
    [name release];
    [imageUrl release];
    [super dealloc];
}

@end
