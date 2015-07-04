//
// Created by Paul D on 29.06.15.
// Copyright (c) 2015 Paul D. All rights reserved.
//

#import "BudsieOrderData.h"


@implementation BudsieOrderData

#pragma mark - Lyfecycle

+ (instancetype)orderWithImage:(UIImage *)image email:(NSString *)email {
    BudsieOrderData *orderData = [self new];
    orderData.email = email;
    orderData.image = image;
    orderData->_filename = @"filename.png";

    return orderData;
}

#pragma mark - Custom Accessors

- (void)setImage:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);

    _image = [UIImage imageWithData:imageData];
}

#pragma mark - Public

+ (instancetype)orderWithImage:(UIImage *)image {
    return [self orderWithImage:image email:nil];
}

- (NSString *)encodeImageToBase64 {
    // One of ways to convert image to Base64
    if (!self.image) {
        return nil;
    }
    return [@"data:image/png;base64," stringByAppendingString:[UIImagePNGRepresentation(self.image) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]];;
}

@end