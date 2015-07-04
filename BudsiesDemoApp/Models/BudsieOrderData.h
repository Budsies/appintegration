//
// Created by Paul D on 29.06.15.
// Copyright (c) 2015 Paul D. All rights reserved.
//

#import "UIKit/UIKit.h"

@interface BudsieOrderData : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic, readonly) NSString *filename;

+ (instancetype)orderWithImage:(UIImage *)image email:(NSString *)email;
+ (instancetype)orderWithImage:(UIImage *)image;

- (NSString *)encodeImageToBase64;

@end