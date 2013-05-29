//
//  ViewController.m
//  SSGestureShortcut Demo App
//
//  Created by Eric Nelson on 5/27/13.
//  Copyright (c) 2013 Sandalsoft. All rights reserved.
//

#import "ViewController.h"
#import "ShortcutActions.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set UIWebView delegate
    self.webView.delegate = self;
    
    NSLog(@"%f x %f", self.view.bounds.size.width, self.view.bounds.size.height);
    self.gestureShortcut = [[SSGestureShortcut alloc] initWithCallingView:self.view];
    self.gestureShortcut.gestureRegocnitionDidFinishdelegate = self;
    self.gestureShortcut.showStroke = YES;
    self.gestureShortcut.showViewBorderOutline = YES;
    
    
}

- (IBAction)gestureButtonPressed:(id)sender {
    [self.gestureShortcut startGestureRecognitionWithBlocks:self.view
                            success:^(NSDictionary *gestureInfo) {

                               NSString *urlText = [[self.webView.request URL] absoluteString];
                               if (!urlText) {
                                   urlText = @"";
                               }
                               NSString *gestureName = [gestureInfo objectForKey:@"gestureName"];
                               
                               
                               // T - Twitter
                               if ([gestureName isEqualToString:@"T"]) {
                                   [ShortcutActions twitterShortcut:urlText fromSender:self];
                               }
                               
                               // E - Email
                               else if ([gestureName isEqualToString:@"E"]) {
                                   [ShortcutActions emailShortcut:urlText fromSender:self];
                               }
                               
                               // M - Message or txt
                               else if ([gestureName isEqualToString:@"M"]) {
                                   [ShortcutActions messageShortcut:urlText fromSender:self];
                               }
                               
                               // f - Facebook
                               else if ([gestureName isEqualToString:@"f"]) {
                                   [ShortcutActions facebookShortcut:urlText fromSender:self];
                               }
                               
                               else {
                                   NSLog(@"No shortcut configured for %@", gestureName);
                               }
                           }
                           failure:^ (NSError *error) {
                               NSLog(@"ERROR: %@", [error description]);
                           }];

}

#pragma  mark - SSGestureShortcut Delegate
- (void)gestureRecognitionDidFinish:(NSDictionary *) gestureDict {
    NSLog(@"gestureDict: %@", [gestureDict description]);
}

- (IBAction)goButtonPressed:(id)sender {
    NSString *url = self.urlTextField.text;
    
    [self.urlTextField resignFirstResponder];
    if ([self.urlTextField.text rangeOfString:@"http://"].location == NSNotFound) {
        url = [NSString stringWithFormat:@"http://%@", self.urlTextField.text];
        self.urlTextField.text = url;
    }
    NSLog(@"url: %@", self.urlTextField.text);
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlTextField.text]];
    [self.webView loadRequest:req];

}

#pragma mark - UIWebView Delegates
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}



#pragma mark - ViewController detritus
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
