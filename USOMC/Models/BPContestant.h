//
//  BPContestant.h
//  USOMC
//
//  Created by Allison Leong on 12/4/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restkit/Restkit.h"

@interface BPContestant : NSObject
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSString *contestantId;

+ (RKObjectMapping *) mapping;
+ (RKResponseDescriptor *) contestantsResponseDescriptor;

@end
