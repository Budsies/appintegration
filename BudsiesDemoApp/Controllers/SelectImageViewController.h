//
//  SelectImageViewController.h
//  BudsiesDemoApp
//
//  Created by Paul D on 28.06.15.
//  Copyright (c) 2015 Paul D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SelectImageViewController;

@protocol SelectImageViewControllerDelegate <NSObject>

@optional
- (void)viewController:(SelectImageViewController *)controller selectedImage:(UIImage *)image;
- (void)viewControllerCancelSelectImage:(SelectImageViewController *)controller;

@end

@interface SelectImageViewController : UICollectionViewController

@property (weak, nonatomic) id <SelectImageViewControllerDelegate> delegate;

@end
