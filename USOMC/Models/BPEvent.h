//
//  BPEvent.h
//  USOMC
//
//  Created by Allison Leong on 11/10/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <Foundation/Foundation.h>

@interface BPEvent : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *roomNumber;
//@property (nonatomic) NSInteger *contestantList;
//@property (nonatomic) NSArray *judgeList;
//@property (nonatomic) NSDate *startTime;
//@property (nonatomic) NSDate *endTime;
 



+ (RKObjectMapping *)mapping;
+ (RKResponseDescriptor *)eventResponseDescriptor;
+ (RKResponseDescriptor *)eventsResponseDescriptor;

@end
