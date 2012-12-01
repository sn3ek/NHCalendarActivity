//
//  NoiteHojeViewController.h
//  NHCalendarActivityDemo
//
//  Created by Otavio Cordeiro on 12/1/12.
//  Copyright (c) 2012 Noite Hoje. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHCalendarActivity.h"

@interface DemoViewController : UIViewController <NHCalendarActivityDelegate>

- (IBAction)openBtnTouched:(id)sender;

@end
