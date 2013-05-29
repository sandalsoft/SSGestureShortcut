//
//  ShortcutActions.m
//  GestureTester
//
//  Created by Eric Nelson on 5/6/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "ShortcutActions.h"

@implementation ShortcutActions


+ (void) twitterShortcut:(NSString *)text fromSender:(UIViewController *)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:text];
        [sender presentViewController:tweetSheet animated:YES completion:nil];
    }

}

+ (void) emailShortcut:(NSString *)text fromSender:(UIViewController *)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = sender;
        [mailer setSubject:text];
        //        NSArray *toRecipients = [NSArray arrayWithObjects:@"julie.jawor@gmail.com", nil];
        //        [mailer setToRecipients:toRecipients];
        
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        [sender presentModalViewController:mailer animated:YES];
        
    }

}

+ (void) messageShortcut:(NSString *)text fromSender:(UIViewController *)sender {
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = text;
        
        controller.messageComposeDelegate = sender;
        [sender presentModalViewController:controller animated:YES];
    }
}

+ (void) facebookShortcut:(NSString *)text fromSender:(UIViewController *)sender {
    NSLog(@"text: %@", text);
    SLComposeViewController *mySLComposerSheet = [[SLComposeViewController alloc] init];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
    {
        //initiate the Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:text,mySLComposerSheet.serviceType]]; //the message you want to post
        
        [sender presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successfull";
                break;
            default:
                break;
        } //check if everythink worked properly. Give out a message on the state.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];

}

@end
