# NHCalendarActivity

**NHCalendarActivity** is an easy to use iOS 6 custom UIActivity that adds events to the iOS calendar.

![NHCalendarActivity](http://f.cl.ly/items/423f3J1C070F0f1P3R3p/iOS%20Simulator%20Screen%20shot%20Dec%201,%202012%204.10.03%20PM.png)

## How to use it

First, create a NHCalendarEvent instance of an event:

    -(NHCalendarEvent *)createCalendarEvent
    {
        NHCalendarEvent *calendarEvent = [[NHCalendarEvent alloc] init];
        
        calendarEvent.title = @"Long-expected Party";
        calendarEvent.location = @"The Shire";
        calendarEvent.notes = @"Bilbo's eleventy-first birthday.";
        calendarEvent.startDate = [NSDate dateWithTimeIntervalSinceNow:3600];
        calendarEvent.endDate = [NSDate dateWithTimeInterval:3600
                                                   sinceDate:calendarEvent.startDate];
        calendarEvent.allDay = NO;
        
        return calendarEvent;
    }

Then, initalize the UIActivityViewController using both NHCalendarEvent and NHCalendarActivity:

    - (IBAction)openBtnTouched:(id)sender
    {
        NSString *msg = NSLocalizedString(@"NHCalendarActivity", nil);
        NSURL* url = [NSURL URLWithString:@"http://git.io/LV7YIQ"];
        
        NHCalendarActivity *calendarActivity = [[NHCalendarActivity alloc] init];
        NSArray *activities = @[
            calendarActivity
        ];
        
        NHCalendarEvent *calendarEvent = [self createCalendarEvent];
        NSArray *items = @[
            msg,
            url,
            calendarEvent
        ];
        
        UIActivityViewController* activity = [[UIActivityViewController alloc] initWithActivityItems:items
                                                                               applicationActivities:activities];
        
        [self presentViewController:activity
                           animated:YES
                         completion:NULL];    
    }

There's also a NHCalendarActivityDelegate, which can be used to perform additional actions.

    #pragma mark - NHCalendarActivityDelegate
    
    -(void)calendarActivityDidFinish:(NHCalendarEvent *)event
    {
        NSLog(@"Event created from %@ to %@", event.startDate, event.endDate);
    }
    
    -(void)calendarActivityDidFail:(NSError *)error
    {
        NSLog(@"Ops!");
    }

And that's all.

## License

    //  Copyright (c) 2012 Otavio Cordeiro. All rights reserved.
    //
    //  Permission is hereby granted, free of charge, to any person obtaining
    //  a copy of this software and associated documentation files (the
    //  "Software"), to deal in the Software without restriction, including
    //  without limitation the rights to use, copy, modify, merge, publish,
    //  distribute, sublicense, and/or sell copies of the Software, and to
    //  permit persons to whom the Software is furnished to do so, subject to
    //  the following conditions:
    //
    //  The above copyright notice and this permission notice shall be
    //  included in all copies or substantial portions of the Software.
    //
    //  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
    //  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    //  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
    //  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
    //  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
    //  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
    //  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    //
    
# Thanks

* [Leonardo Tartari](https://github.com/ltartari) for pointing me this [wonderfull icon set](http://www.iconsweets2.com).