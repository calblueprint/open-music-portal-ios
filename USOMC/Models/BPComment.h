//
//  BPComment.h
//  USOMC
//
//  Created by Allison Leong on 12/3/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restkit/Restkit.h"

@interface BPComment : NSObject
+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)commentsResponseDescriptor;
@end
