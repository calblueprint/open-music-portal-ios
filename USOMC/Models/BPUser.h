//
//  BPUser.h
//  USOMC
//
//  Created by Allison Leong on 11/28/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Restkit/Restkit.h>

@interface BPUser : NSObject
@property (nonatomic) NSString *firstName;
@property (nonatomic) NSString *lastName;
@property (nonatomic) NSInteger *userId;
+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)usersResponseDescriptor;
@end
