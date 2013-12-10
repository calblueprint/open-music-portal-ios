//
//  BPRanking.h
//  USOMC
//
//  Created by Allison Leong on 12/7/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restkit/Restkit.h"

@interface BPRanking : NSObject
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSNumber *rank;

+ (RKObjectMapping *) mapping;
+ (RKResponseDescriptor *) rankingsResponseDescriptor;
@end
