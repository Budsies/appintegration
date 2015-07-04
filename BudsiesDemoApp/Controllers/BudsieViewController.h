//
//  BudsieViewController.h
//  BudsiesDemoApp
//
//  Created by Paul D on 28.06.15.
//  Copyright (c) 2015 Paul D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BudsieOrderData;

@interface BudsieViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) BudsieOrderData *budsieOrderData;

@end
