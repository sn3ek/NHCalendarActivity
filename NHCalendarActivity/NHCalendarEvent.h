//
//  NHCalendarEvent.h
//  Noite Hoje for iPad
//
//  Created by Otavio Cordeiro on 12/1/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHCalendarEvent : NSObject

@property (strong) NSString *title;
@property (strong) NSString *location;
@property (strong) NSString *notes;
@property (strong) NSDate *startDate;
@property (strong) NSDate *endDate;
@property (assign) BOOL allDay;

@end
