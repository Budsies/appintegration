//
//  BudsieViewController.m
//  BudsiesDemoApp
//
//  Created by Paul D on 28.06.15.
//  Copyright (c) 2015 Paul D. All rights reserved.
//

#import "BudsieViewController.h"
#import "SelectImageViewController.h"
#import "BudsieOrderData.h"

@interface BudsieViewController () <SelectImageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSString *hostName;

@end

@implementation BudsieViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back To The App" style:UIBarButtonItemStyleBordered target:self action:@selector(backTap)];

    self.hostName = @"budsies.com";
    NSString *referalID = @"referalID";

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@/budsies/integration/index?acc=%@", self.hostName, referalID]]];

    [self.webView loadRequest:request];

    self.navigationController.hidesBarsOnSwipe = YES;
}

#pragma mark - Private

- (NSURLRequest *)modifyRequest:(NSURLRequest *)request {
    NSMutableURLRequest *newRequest = [request mutableCopy];

    // required header for mobile app
    [newRequest addValue:@"BudsiesMobileIntegrationApp" forHTTPHeaderField:@"App-ID"];

    return [newRequest copy];
}

- (void)backTap {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setActivityIndicatorHidden:(BOOL)hidden {
    if ([UIApplication sharedApplication].isNetworkActivityIndicatorVisible == hidden) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = !hidden;
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *method = request.URL.fragment;

    // handle events represented via URL
    if ([method isEqualToString:@"getAppName"]) {
        //set the app name
        NSString *javascript = [NSString stringWithFormat:@"app.views.mobileIntegrationAPI.setAppName('%@')", @"Budsie Demo App"];
        [webView stringByEvaluatingJavaScriptFromString:javascript];

        return NO;
    } else if ([method isEqualToString:@"getOrderData"]) {
        if (self.budsieOrderData) {
            // set image and user email, file name need for detect extension if the image
            // the method calls when we come from the app after "intro" page on budsies service (like as init image from the app)
            NSString *javascript = [NSString stringWithFormat:@"app.views.mobileIntegrationAPI.setOrderData('%@', '%@', '%@')", self.budsieOrderData.email, self.budsieOrderData.encodeImageToBase64, self.budsieOrderData.filename];

            [webView stringByEvaluatingJavaScriptFromString:javascript];

            self.budsieOrderData = nil;
        }

        return NO;
    } else if ([method isEqualToString:@"getArtwork"]) {
        // the method for set new image from the app
        SelectImageViewController *imageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectImageController"];
        imageViewController.delegate = self;

        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imageViewController];

        [self presentViewController:navigationController animated:YES completion:nil];

        return NO;
    } else if ([method isEqualToString:@"returnToTheApp"]) {
        [self.navigationController popViewControllerAnimated:YES];

        return NO;
    }

    if (![request.URL.host isEqualToString:self.hostName] || [request valueForHTTPHeaderField:@"App-ID"]) {
        return YES;
    }

    [webView loadRequest:[self modifyRequest:request]];

    return NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"%@", error.localizedDescription);
    [self setActivityIndicatorHidden:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self setActivityIndicatorHidden:NO];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self setActivityIndicatorHidden:YES];
}

#pragma mark - SelectImageViewControllerDelegate

- (void)viewConroller:(SelectImageViewController *)controller selectedImage:(UIImage *)image {
    // the method of SelectImageViewControllerDelegate that set image from the app
    BudsieOrderData *orderData = [BudsieOrderData orderWithImage:image];
    NSString *javascript = [NSString stringWithFormat:@"app.views.mobileIntegrationAPI.setArtwork('%@', '%@')", [orderData encodeImageToBase64], orderData.filename];

    [self.webView stringByEvaluatingJavaScriptFromString:javascript];

    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
