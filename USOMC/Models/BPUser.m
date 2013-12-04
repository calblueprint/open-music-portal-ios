//
//  BPUser.m
//  USOMC
//
//  Created by Allison Leong on 11/28/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPUser.h"

@implementation BPUser
@synthesize firstName;
@synthesize lastName;
@synthesize userId;


+ (RKObjectMapping *)mapping {
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[self class]];
    [userMapping addAttributeMappingsFromDictionary:@{
                                                       //@"name in json : name I assign"
                                                       @"first_name" : @"firstName",
                                                       @"last_name" : @"lastName",
                                                       @"encid" : @"userId",
                                                       }];
    return userMapping;
}

+ (RKResponseDescriptor *)usersResponseDescriptor {
    NSLog(@"entering usersResponseDescriptor");
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:@"users"
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    if (descriptor) {
        NSLog(@"descriptor in usersResponseDescriptor is not nil");
        // Custom initialization
    }
    
    return descriptor;
}

@end
