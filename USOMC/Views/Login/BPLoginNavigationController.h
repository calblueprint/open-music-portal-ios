//
//  BPLoginNavigationController.h
//  
//
//  Created by William Tang on 11/14/13.
//
//

#import "BPNavigationController.h"
#import "BPEventsNavigationController.h"

@interface BPLoginNavigationController : BPNavigationController {
  NSMutableDictionary *params;
  BPEventsNavigationController *eventsNavigationController;
}

@property (nonatomic, retain) NSMutableDictionary *params;
@property (nonatomic, retain) BPEventsNavigationController *eventsNavigationController;
@end
