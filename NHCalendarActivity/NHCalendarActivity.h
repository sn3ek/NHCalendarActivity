//
//  NHCalendarActivity.h
//  Noite Hoje for iPad
//
//  Created by Otavio Cordeiro on 11/25/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "NHCalendarEvent.h"

@protocol NHCalendarActivityDelegate <NSObject>
@optional
- (void)calendarActivityDidFinish:(NHCalendarEvent *)event;
- (void)calendarActivityDidFail:(NSError *)error;
@end

@interface NHCalendarActivity : UIActivity
@property (assign) id<NHCalendarActivityDelegate> delegate;
@end
