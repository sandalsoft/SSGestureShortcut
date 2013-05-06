#import "DollarPGestureRecognizer.h"
#import "DollarPoint.h"
#import <UIKit/UIKit.h>

@implementation DollarPGestureRecognizer

@synthesize pointClouds, result;

- (id)initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    if (self) {
        dollarP = [[DollarP alloc] init];
        currentTouches = [[NSMutableDictionary alloc] init];
        currentPoints = [NSMutableArray array];
        points = [NSMutableArray array];
    }
    return self;
}



#pragma mark - Recognize Gesture - the main event

- (void)recognize {
    if ([currentPoints count] == 0) {
        [self setState:UIGestureRecognizerStateFailed];
        return;
    }
    
    points = [currentPoints copy];
    
    if ([self state] == UIGestureRecognizerStatePossible) {
        result = [dollarP recognize:points];
        [self setState:UIGestureRecognizerStateRecognized];
    }
}





#pragma mark - Gesture touch delegates
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    for (UITouch *touch in touches) {
        strokeId++;
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        [currentTouches setObject:[NSNumber numberWithInt:strokeId] forKey:key];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if ([self state] == UIGestureRecognizerStateFailed) {
        return;
    }
    
    for (UITouch *touch in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:touch];
        int index = [[currentTouches objectForKey:key] intValue];
        CGPoint location = [touch locationInView:[self view]];
        
        DollarPoint *point = [[DollarPoint alloc] initWithId:@(index)
                                                           x:location.x
                                                           y:location.y];
        [currentPoints addObject:point];
    }
}


// Touch done.  Only recognizes single touch until timer + multi touch is built-in
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //    NSLog(@"touch end starting timer");
    //    NSDictionary *touchInfo = @{@"touches":touches,@"event":event};
    //    timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(gestureComplete) userInfo:touchInfo repeats:NO];
    
    
    // Send notification and/or call delegate to alert other objects touches are done
    // This may or may not be necessary.  We can call [self recognize] ourselves from here
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:GESTURE_TOUCH_END object:self];
//    [self touchesDidFinishDelegate];
    
    
    // Kick off [gesture recognize] from here?  Do even I need to send a delegate/notification?
    [self recognize];
    
    
    // Does this need to be before or after recognize and notification/delegate?
    [super touchesEnded:touches withEvent:event];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    [self setState:UIGestureRecognizerStateFailed];
}


#pragma mark - Gesture and points helpers

- (void)reset {
    [super reset];
    [currentTouches removeAllObjects];
    [currentPoints removeAllObjects];
    strokeId = 0;
}

- (NSMutableArray *)pointClouds {
    return [dollarP pointClouds];
}

- (void)setPointClouds:(NSMutableArray *)somePointClouds {
    [dollarP setPointClouds:somePointClouds];
}

- (void)addGestureWithName:(NSString *)name {
    if ([points count] > 0) {
        [dollarP addGesture:name points:points];
    }
}

- (NSArray *)points {
    return points;
}


@end