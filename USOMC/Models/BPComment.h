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
@property (nonatomic) NSNumber *judgeId;
@property (nonatomic) NSNumber *contestantId;
@property (nonatomic) NSNumber *eventId;
@property (nonatomic) NSString *body;
+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)commentsResponseDescriptor;
@end
