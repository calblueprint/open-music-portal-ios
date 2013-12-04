//
//  BPContestant.m
//  USOMC
//
//  Created by Allison Leong on 12/4/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPContestant.h"

@implementation BPContestant
@synthesize firstName;
@synthesize lastName;
@synthesize contestantId;

+ (RKObjectMapping *)mapping {
    RKObjectMapping *contestantMapping = [RKObjectMapping mappingForClass:[self class]];
    [contestantMapping addAttributeMappingsFromDictionary:@{
                                                      //@"name in json : name I assign"
                                                      @"first_name" : @"firstName",
                                                      @"last_name" : @"lastName",
                                                      @"encid" : @"contestantId",
                                                      }];
    return contestantMapping;
}

+ (RKResponseDescriptor *)contestantsResponseDescriptor {
    NSLog(@"entering contestantResponseDescriptor");
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:@"contestants"
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    if (descriptor) {
        NSLog(@"descriptor in contestantResponseDescriptor is not nil");
        // Custom initialization
    }
    
    return descriptor;
}



@end
