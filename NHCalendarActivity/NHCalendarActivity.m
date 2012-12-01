//
//  NHCalendarActivity.m
//  Noite Hoje for iPad
//
//  Created by Otavio Cordeiro on 11/25/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "NHCalendarActivity.h"

@interface NHCalendarActivity ()
@property (strong) NHCalendarEvent *event;
@end

@implementation NHCalendarActivity

- (NSString *)activityType
{
    return @"com.otaviocc.Noite-Hoje.NHCalendarActivity";
}

- (NSString *)activityTitle
{
    return NSLocalizedString(@"Save to Calendar", @"Save to Calendar localized string.");
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"NHCalendarActivityIcon"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    for (id item in activityItems) {
        if ([item isKindOfClass:[NHCalendarEvent class]] &&
            (status == EKAuthorizationStatusNotDetermined || status == EKAuthorizationStatusAuthorized)) {
            return YES;
        }
    }
    
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id item in activityItems)
        if ([item isKindOfClass:[NHCalendarEvent class]])
            self.event = item;
}

- (void)performActivity
{
    EKEventStore *ekEventStore = [[EKEventStore alloc] init];

    [ekEventStore requestAccessToEntityType:EKEntityTypeEvent
                                 completion:^(BOOL granted, NSError *kError) {
        if (granted) {
            EKEvent *ekEvent = [EKEvent eventWithEventStore:ekEventStore];
            
            ekEvent.title = self.event.title;
            ekEvent.location = self.event.location;
            ekEvent.notes = self.event.notes;
            ekEvent.startDate = self.event.startDate;
            ekEvent.endDate = self.event.endDate;
            ekEvent.allDay = self.event.allDay;
            
            [ekEvent setCalendar:[ekEventStore defaultCalendarForNewEvents]];
            
            NSError *error = nil;
            [ekEventStore saveEvent:ekEvent
                               span:EKSpanThisEvent
                              error:&error];
            
            if (error == nil) {
                if ([self.delegate respondsToSelector:@selector(calendarActivityDidFinish:)])
                    [self.delegate calendarActivityDidFinish:self.event];
            } else {
                if ([self.delegate respondsToSelector:@selector(calendarActivityDidFail:)])
                    [self.delegate calendarActivityDidFail:error];
            }
        } else {
            if ([self.delegate respondsToSelector:@selector(calendarActivityDidFail:)])
                [self.delegate calendarActivityDidFail:kError];
        }
    }];
    
    [self activityDidFinish:YES];
}

@end
