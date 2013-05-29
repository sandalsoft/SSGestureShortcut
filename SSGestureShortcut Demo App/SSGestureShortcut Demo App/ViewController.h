//
//  ViewController.h
//  SSGestureShortcut Demo App
//
//  Created by Eric Nelson on 5/27/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSGestureShortcut.h"

@interface ViewController : UIViewController<UIWebViewDelegate, SSGestureShortcutDelegate>
@property (weak, nonatomic) IBOutlet UIToolbar *gestureButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) SSGestureShortcut *gestureShortcut;
@end
