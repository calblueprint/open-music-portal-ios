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
                                                      //@"judge" : @"judgeId",
                                                      //@"contestant" : @"contestantId",
                                                      //@"event" : @"eventId",
                                                      @"body" :@"body",
                                                      }];
    return commentMapping;
}

+ (RKResponseDescriptor *)commentsResponseDescriptor {
    NSLog(@"entering commentsResponseDescriptor");
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:@"comments"
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    if (descriptor) {
        NSLog(@"descriptor in commentsResponseDescriptor is not nil");
        // Custom initialization
    }
    
    return descriptor;
}

@end
