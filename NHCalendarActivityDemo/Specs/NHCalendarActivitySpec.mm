#import <Swizzlean/Swizzlean.h>
#import "NHCalendarActivity.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface NHCalendarActivity (Specs)
@property (strong) NSMutableArray *events;
@end

SPEC_BEGIN(NHCalendarActivitySpec)

describe(@"NHCalendarActivity", ^{
    __block NHCalendarActivity *activity;

    beforeEach(^{
        activity = [[NHCalendarActivity alloc] init];
    });
    
    it(@"should not blow up", ^{
        activity should_not be_nil;
    });
    
    it(@"has an event arrary", ^{
        activity.events should_not be_nil;
    });
    
    describe(@"#activityType", ^{
        it(@"returns proper activity type", ^{
            NSString *type = [activity activityType];
            type should equal(@"NHCalendarActivity");
        });
    });
    
    describe(@"#activityTitle", ^{
        it(@"returns proper activity title", ^{
            NSString *title = [activity activityTitle];
            title should equal(NSLocalizedString(@"Save to Calendar", nil));
        });
    });
    
    describe(@"#activityImage", ^{
        it(@"returns proper activity image", ^{
            UIImage *expectedImage = [UIImage imageNamed:@"NHCalendarActivity.bundle/NHCalendarActivityIcon"];
            UIImage *image = [activity activityImage];
            image should equal(expectedImage);
        });
    });
    
    describe(@"#canPerformWithActivityItems", ^{
        __block NSArray *items;
        __block NHCalendarEvent *fakeEvent;
        __block Swizzlean *eventStoreSwizz;
        __block BOOL retValue;
        
        beforeEach(^{
            fakeEvent = nice_fake_for([NHCalendarEvent class]);
            items = @[fakeEvent];
        });
        
        context(@"EKAuthorizationStatusDenied", ^{
            beforeEach(^{
                eventStoreSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[EKEventStore class]];
                [eventStoreSwizz swizzleClassMethod:@selector(authorizationStatusForEntityType:) withReplacementImplementation:^(id _self, EKEntityType type) {
                    return EKAuthorizationStatusDenied;
                }];
                
                retValue = [activity canPerformWithActivityItems:items];
            });
            
            afterEach(^{
                [eventStoreSwizz resetSwizzledClassMethod];
            });
            
            it(@"should NOT display the 'Save to Calendar' icon", ^{
                retValue should_not be_truthy;
            });
        });
        
        context(@"EKAuthorizationStatusNotDetermined", ^{
            beforeEach(^{
                eventStoreSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[EKEventStore class]];
                [eventStoreSwizz swizzleClassMethod:@selector(authorizationStatusForEntityType:) withReplacementImplementation:^(id _self, EKEntityType type) {
                    return EKAuthorizationStatusNotDetermined;
                }];
                
                retValue = [activity canPerformWithActivityItems:items];
            });
            
            afterEach(^{
                [eventStoreSwizz resetSwizzledClassMethod];
            });
            
            it(@"should display the 'Save to Calendar' icon", ^{
                retValue should be_truthy;
            });
        });
        
        context(@"EKAuthorizationStatusAuthorized", ^{
            beforeEach(^{
                eventStoreSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[EKEventStore class]];
                [eventStoreSwizz swizzleClassMethod:@selector(authorizationStatusForEntityType:) withReplacementImplementation:^(id _self, EKEntityType type) {
                    return EKAuthorizationStatusAuthorized;
                }];
                
                retValue = [activity canPerformWithActivityItems:items];
            });
            
            afterEach(^{
                [eventStoreSwizz resetSwizzledClassMethod];
            });
            
            it(@"should display the 'Save to Calendar' icon", ^{
                retValue should be_truthy;
            });
        });
    });

    describe(@"#prepareWithActivityItems", ^{
        __block NHCalendarEvent *fakeEvent;
        __block NSObject *fakeObject;
        __block NSArray *items;
        
        beforeEach(^{
            fakeEvent = nice_fake_for([NHCalendarEvent class]);
            fakeObject = nice_fake_for([NSObject class]);
            
            items = @[fakeEvent, fakeObject];
            
            [activity prepareWithActivityItems:items];
        });
        
        it(@"has added a single item to the array of events", ^{
            activity.events.count should equal(1);
        });
        
        it(@"has a NHCalendarEvent in the array of events", ^{
            activity.events[0] should be_instance_of([NHCalendarEvent class]);
        });
    });
    
    describe(@"#performActivity", ^{
        __block id<NHCalendarActivityDelegate> fakeDelegate;
        __block Swizzlean *requestAccessSwizz;
        __block EKEntityType typePassed;
        __block EKEventStoreRequestAccessCompletionHandler completionPassed;
        
        beforeEach(^{
            fakeDelegate = nice_fake_for(@protocol(NHCalendarActivityDelegate));
            activity.delegate = fakeDelegate;
            
            requestAccessSwizz = [[Swizzlean alloc] initWithClassToSwizzle:[EKEventStore class]];
            [requestAccessSwizz swizzleInstanceMethod:@selector(requestAccessToEntityType:completion:) withReplacementImplementation:^(id _self, EKEntityType type, EKEventStoreRequestAccessCompletionHandler completion) {
                typePassed = type;
                completionPassed = [completion copy];
            }];
            
            [activity performActivity];
        });
        
        afterEach(^{
            [requestAccessSwizz resetSwizzledInstanceMethod];
        });
        
        context(@"request access NOT granted", ^{
            __block NSError *fakeError;
            
            beforeEach(^{
                fakeError = nice_fake_for([NSError class]);
                completionPassed(NO, fakeError);
            });
            
            it(@"has called delegate selector", ^{
                activity.delegate should have_received(@selector(calendarActivityDidFailWithError:)).with(fakeError);
            });
        });
    });
});

SPEC_END
