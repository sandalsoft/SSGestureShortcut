//
//  ShortcutActions.h
//  GestureTester
//
//  Created by Eric Nelson on 5/6/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface ShortcutActions : NSObject


+ (void) twitterShortcut:(NSString *)text fromSender:(UIViewController *)sender;
+ (void) emailShortcut:(NSString *)text fromSender:(UIViewController *)sender;
+ (void) messageShortcut:(NSString *)text fromSender:(UIViewController *)sender;
+ (void) facebookShortcut:(NSString *)text fromSender:(UIViewController *)sender;


@end
