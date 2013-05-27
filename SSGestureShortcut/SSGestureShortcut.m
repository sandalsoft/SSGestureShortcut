//
//  SSGestureShortcut.m
//  SSGestureShortcut
//
//  Created by Eric Nelson on 5/3/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "SSGestureShortcut.h"
#import <QuartzCore/QuartzCore.h>
#import "DollarDefaultGestures.h"



@implementation SSGestureShortcut



- (id)initWithCallingView:(UIView *)callingView { 
    
    if ((self = [super init])) {
        
        // Receive notifcations from DollarPGestureRecognizer when touch ends (ie, finger is lifeted up)
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(gestureTouchesDone:)
                                                     name:GESTURE_TOUCH_END
                                                   object:nil];
        
        self.sendingView = callingView;
        
        self.showViewBorderOutline = NO;
        self.viewBorderOutlineColor = [UIColor redColor];
        self.viewBorderOutlineThickness = 3.0f;
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(activateGesture:)];
        
        if (self.useLongTouchGestureAactivation) {
            self.longTouchActivationDuration = (self.longTouchActivationDuration) ? self.longTouchActivationDuration : 1.0f;
            longPress.minimumPressDuration = self.longTouchActivationDuration;
            [callingView addGestureRecognizer:longPress];
        }
        self.dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(gestureIsRecognized:)];
        [self.dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
        [self.dollarPGestureRecognizer setDelaysTouchesEnded:NO];   
    }
    return self;
}



// Entry point with delegate or notification.  "Returning" method if the delegate down below
- (void)startGestureRecognition:(UIView *)callingView {
    //    NSLog(@"in router with my view: %@", callingView);
    
    self.gestureView  = [[[NSBundle mainBundle] loadNibNamed:GestureViewiPhoneXib owner:self options:nil] lastObject];
    
    [self.gestureView addGestureRecognizer:self.dollarPGestureRecognizer];
    self.gestureView.backgroundColor = [UIColor colorWithPatternImage:[self takeScreenShot:callingView]];
    [self addBorder:callingView withBorderColor:self.viewBorderOutlineColor withTickness:self.viewBorderOutlineThickness];
//    self.gestureView.bounds = CGRectMake(callingView.bounds.origin.x, callingView.bounds.origin.y, callingView.bounds.size.width, callingView.bounds.size.height);
//    NSLog(@"%f x %f", self.gestureView.bounds.size.width, self.gestureView.bounds.size.height);

    [callingView addSubview:self.gestureView];
}

- (void)start {
    
}

// Entry point for using blocks.  how to return the success block with the TargetAction used with DollarPGestureRecognizer?
- (void)startGestureRecognition:(UIView *)callingView
                        success:(void (^)(NSDictionary *gestureInfo))success
                        failure:(void (^)(NSError *error))failure {
    
    self.gestureView  = [[[NSBundle mainBundle] loadNibNamed:GestureViewiPhoneXib owner:self options:nil] lastObject];
    
    [self.gestureView addGestureRecognizer:self.dollarPGestureRecognizer];
    self.gestureView.backgroundColor = [UIColor colorWithPatternImage:[self takeScreenShot:callingView]];
    [self addBorder:callingView withBorderColor:self.viewBorderOutlineColor withTickness:self.viewBorderOutlineThickness];
     
#warning need to tweak the geometry of the gestureView for ipad and maybe rotations
    //    self.gestureView.bounds = CGRectMake(callingView.bounds.origin.x, callingView.bounds.origin.y, callingView.bounds.size.width, callingView.bounds.size.height);
    //    NSLog(@"%f x %f", self.gestureView.bounds.size.width, self.gestureView.bounds.size.height);
    
    [callingView addSubview:self.gestureView];
    
}


#pragma mark - Target for DollarPGestureRecognition
- (void)gestureIsRecognized:(DollarPGestureRecognizer *)sender {
    [self removeBorder:self.sendingView];
    DollarResult *result = [sender result];
    //    NSLog(@"Name: %@\nScore: %.2f", [result name], [result score]);
    NSDictionary *gestureDict = @{@"gestureName":[result name],@"gestureScore":[NSNumber numberWithDouble:[result score]]};
    [[self gestureRegocnitionDidFinishdelegate]  gestureRecognitionDidFinish:gestureDict];
}



#pragma mark - Touch gesture end Notification & Delegate

// Notifcation when gesture touches are complete (send from DollarPGestureRecosgnizer)
- (void) gestureTouchesDone:(NSNotification *)gestureNotification {
    
    [self.dollarPGestureRecognizer recognize];
    [self.gestureView removeFromSuperview];
}

// Delegate version of knowing when gesture touches are complete (send from DollarPGestureRecosgnizer)
- (void) touchesDidFinish {
    [self.dollarPGestureRecognizer recognize];
    [self.gestureView removeFromSuperview];
}



#pragma mark - LongTouch gesture delegate
// Built-in long press gesture deledate event
- (void)activateGesture:(UILongPressGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        [self startGestureRecognition:self.sendingView];
    }
}


#pragma mark - UIView visual stuff

- (UIImage *)takeScreenShot:(UIView *)view {
    CGRect rect = [view bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot;
}

- (void)addBorder:(UIView *) callingView withBorderColor:(UIColor *)borderColor withTickness:(float)thickness {
    callingView.layer.borderColor = borderColor.CGColor;
    callingView.layer.borderWidth = thickness;
}

- (void)removeBorder:(UIView *) callingView {
    callingView.layer.borderColor = nil;
    callingView.layer.borderWidth = 0;
}


@end
