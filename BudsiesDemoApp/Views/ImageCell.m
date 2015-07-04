//
//  ImageCell.m
//  BudsiesDemoApp
//
//  Created by Paul D on 28.06.15.
//  Copyright (c) 2015 Paul D. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkImageView;


@end

@implementation ImageCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)prepareForReuse {
    [super prepareForReuse];

    self.imageView.image = nil;
    self.backgroundColor = [UIColor clearColor];
    self.checkImageView.alpha = 0;
}

- (void)setSelected:(BOOL)selected {
    [UIView animateWithDuration:0.3 animations:^{
        self.checkImageView.alpha = selected;
    }];
}


@end
