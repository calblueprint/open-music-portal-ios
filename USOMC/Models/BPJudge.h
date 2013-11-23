//
//  BPJudge.h
//  USOMC
//
//  Created by William Tang on 11/23/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface BPJudge : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;

+ (RKObjectMapping *) mapping;
+ (RKResponseDescriptor *) judgeResponseDescriptor;
+ (RKResponseDescriptor *) judgesResponseDescriptor;

@end
