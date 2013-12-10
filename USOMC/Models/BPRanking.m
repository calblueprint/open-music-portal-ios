//
//  BPRanking.m
//  USOMC
//
//  Created by Allison Leong on 12/7/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPRanking.h"

@implementation BPRanking
+ (RKObjectMapping *)mapping {
    RKObjectMapping *rankMapping = [RKObjectMapping mappingForClass:[self class]];
    [rankMapping addAttributeMappingsFromDictionary:@{
                                                       @"first_name" : @"firstName",
                                                       @"last_name" : @"lastName",
                                                       @"rank" : @"rank",
                                                       }];
    return rankMapping;
}

+ (RKResponseDescriptor *)rankingsResponseDescriptor {
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping
                                                                                    method:RKRequestMethodGET
                                                                               pathPattern:nil
                                                                                   keyPath:@"contestants"
                                                                               statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return descriptor;
}



@end
