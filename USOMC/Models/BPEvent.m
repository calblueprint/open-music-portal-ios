//
//  BPEvent.m
//  USOMC
//
//  Created by Allison Leong on 11/10/13.
//  Copyright (c) 2013 Mark Miyashita. All rights reserved.
//

#import "BPEvent.h"

@implementation BPEvent

+ (RKObjectMapping *)mapping {
    RKObjectMapping *eventMapping = [RKObjectMapping mappingForClass:[self class]];
    [eventMapping addAttributeMappingsFromDictionary:@{
                                                       //@"name in json : name I assign"
                                                      @"name" : @"name",
                                                      @"room_id" : @"roomNumber",
                                                      //@"users" : @"contestantList",
                                                      //@"judge_list" : @"judgeList",
                                                      //@"start_time" : @"startTime",
                                                      //@"end_time" : @"endTime",
                                                      }];
    /*
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    eventMapping.dateFormatters = [NSArray arrayWithObject: dateFormat];
     */
    [eventMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"users" toKeyPath:@"contestants" withMapping:BPUser.mapping]];
    NSLog(@"About to return eventMapping");
    return eventMapping;
}



+ (RKResponseDescriptor *)eventResponseDescriptor {
    NSLog(@"entering eventResponseDescriptor");
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping method:RKRequestMethodGET pathPattern:nil keyPath:@"events" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    return descriptor;
}

+ (RKResponseDescriptor *)eventsResponseDescriptor {
    NSLog(@"entering eventsResponseDescriptor");
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:self.mapping
        method:RKRequestMethodGET
        pathPattern:nil
        keyPath:@"events"
        statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    if (descriptor) {
        NSLog(@"descriptor in eventsResponseDescriptor is not nil");
        // Custom initialization
    }

    return descriptor;
}

@end
