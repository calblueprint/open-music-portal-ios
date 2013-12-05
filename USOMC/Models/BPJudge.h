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
@property (nonatomic) NSNumber *judgeId;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;

+ (RKObjectMapping *) mapping;
+ (RKResponseDescriptor *) judgesResponseDescriptor;

@end
