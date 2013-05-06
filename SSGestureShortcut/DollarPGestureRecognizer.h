#import <Foundation/Foundation.h>
#import "Common.h"
#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "DollarP.h"


@protocol DollarPTouchesEndedDelegate <NSObject>
@required
- (void)touchesDidFinish;
@end


@interface DollarPGestureRecognizer : UIGestureRecognizer {
    DollarP *dollarP;
    NSMutableDictionary *currentTouches;
    NSMutableArray *currentPoints;
    NSMutableArray *points;
    int strokeId;
}

@property (nonatomic, strong) NSMutableArray *pointClouds;
@property (nonatomic, strong, readonly) DollarResult *result;

@property (nonatomic, assign) id touchesDidFinishDelegate;

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void)recognize;
- (void)addGestureWithName:(NSString *)name;
- (NSArray *)points;

@end