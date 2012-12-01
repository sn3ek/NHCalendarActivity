//
//  NoiteHojeViewController.m
//  NHCalendarActivityDemo
//
//  Created by Otavio Cordeiro on 12/1/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import "DemoViewController.h"

@implementation DemoViewController

- (IBAction)openBtnTouched:(id)sender
{
    NSString *msg = NSLocalizedString(@"NHCalendarActivity", nil);
    NSURL* url = [NSURL URLWithString:@"http://github.com/otaviocc/NHCalendarActivity"];
    NHCalendarEvent *calendarEvent = [self createCalendarEvent];
    
    NHCalendarActivity *calendarActivity = [[NHCalendarActivity alloc] init];
    calendarActivity.delegate = self;
    
    NSArray *activities = @[
        calendarActivity
    ];
    
    UIActivityViewController* activity = [[UIActivityViewController alloc] initWithActivityItems:@[msg, url, calendarEvent]
                                                                           applicationActivities:activities];
    
    activity.excludedActivityTypes = @[
        UIActivityTypePostToWeibo,
        UIActivityTypePrint,
        UIActivityTypeSaveToCameraRoll,
        UIActivityTypeAssignToContact
    ];
    
    [self presentViewController:activity
                       animated:YES
                     completion:NULL];    
}

-(NHCalendarEvent *)createCalendarEvent
{
    NHCalendarEvent *calendarEvent = [[NHCalendarEvent alloc] init];
    
    calendarEvent.title = @"Long-expected Party";
    calendarEvent.location = @"The Shire";
    calendarEvent.notes = @"Bilbo's eleventy-first birthday.";
    calendarEvent.startDate = [NSDate dateWithTimeIntervalSinceNow:3600];
    calendarEvent.endDate = [NSDate dateWithTimeInterval:3600 sinceDate:calendarEvent.startDate];
    calendarEvent.allDay = NO;
    
    return calendarEvent;
}

#pragma mark - NHCalendarActivityDelegate

-(void)calendarActivityDidFinish:(NHCalendarEvent *)event
{
    NSLog(@"Event created from %@ to %@", event.startDate, event.endDate);
}

-(void)calendarActivityDidFail:(NSError *)error
{
    NSLog(@"Ops!");
}

@end
