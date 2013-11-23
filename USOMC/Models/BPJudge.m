//
//  BPJudge.m
//  USOMC
//
//  Created by William Tang on 11/23/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPJudge.h"

@implementation BPJudge

+ (RKObjectMapping *)mapping {
  RKObjectMapping *judgeMapping = [RKObjectMapping mappingForClass:[self class]];
  [judgeMapping addAttributeMappingsFromDictionary:@{
                                                    @"name" : @"name",
                                                    @"username" : @"username",
                                                    }];
  return judgeMapping;
}

+ (RKResponseDescriptor *)judgeResponseDescriptor{
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"judge" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

+ (RKResponseDescriptor *)judgesResponseDescriptor{
  RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"judges" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
  return descriptor;
}

@end
