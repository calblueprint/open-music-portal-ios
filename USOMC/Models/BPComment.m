//
//  BPComment.m
//  USOMC
//
//  Created by Allison Leong on 12/3/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPComment.h"

@implementation BPComment
+ (RKObjectMapping *)mapping {
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[self class]];
    [commentMapping addAttributeMappingsFromDictionary:@{
                                                      //@"name in json : name I assign"
                                                      @"first_name" : @"firstName",
                                                      @"last_name" : @"lastName",
                                                      @"encid" : @"userId",
                                                      }];
    return commentMapping;
}

+ (RKResponseDescriptor *)commentsResponseDescriptor {
    NSLog(@"entering commentsResponseDescriptor");
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:@"users"
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    if (descriptor) {
        NSLog(@"descriptor in commentsResponseDescriptor is not nil");
        // Custom initialization
    }
    
    return descriptor;
}

@end
