//
//  SelectImageViewController.m
//  BudsiesDemoApp
//
//  Created by Paul D on 28.06.15.
//  Copyright (c) 2015 Paul D. All rights reserved.
//

#import "SelectImageViewController.h"
#import "ImageCell.h"
#import "BudsieViewController.h"
#import "BudsieOrderData.h"

@interface SelectImageViewController ()

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) UIBarButtonItem *rightBarButtonItem;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation SelectImageViewController

static NSString *const ReuseIdentifier = @"ImageCell";

#pragma mark - Lyfecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *titleBarItem = @"Get Budsie";

    if (self.delegate) {
        titleBarItem = @"Done";

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarItemTap)];
    }

    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:titleBarItem style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemTap)];
    self.navigationItem.rightBarButtonItem = self.rightBarButtonItem;

    self.clearsSelectionOnViewWillAppear = NO;

    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];

    NSMutableArray *tempArray = [@[] mutableCopy];
    for (int i = 1; i <= 5; i++) {
        [tempArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"image%d.jpg", i]]];
    }

    self.images = [tempArray copy];
    self.rightBarButtonItem.enabled = NO;

    [self customizeCollectionView:self.collectionView];
}

#pragma mark - Private

- (void)customizeCollectionView:(UICollectionView *)collectionView {
    UICollectionViewFlowLayout *collectionViewFlowLayout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    collectionViewFlowLayout.itemSize = CGSizeMake(CGRectGetMidX(collectionView.bounds) - 3, CGRectGetMidX(collectionView.bounds) - 3);
}

- (void)rightBarItemTap {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(viewConroller: selectedImage:)]) {
            [self.delegate viewConroller:self selectedImage:self.images[self.selectedIndexPath.item]];
        }
    } else {
        [self performSegueWithIdentifier:@"GetBudsie" sender:self];
    }
}

- (void)leftBarItemTap {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GetBudsie"]) {
        BudsieViewController *budsieViewController = segue.destinationViewController;
        budsieViewController.budsieOrderData = [BudsieOrderData orderWithImage:self.images[self.selectedIndexPath.item] email:@"user-email@email.com"];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ReuseIdentifier forIndexPath:indexPath];
    
    cell.image = self.images[indexPath.item];
    cell.selected = self.selectedIndexPath == indexPath;

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedIndexPath == indexPath) {
        self.selectedIndexPath = nil;

        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    } else {
        self.selectedIndexPath = indexPath;
    }

    self.rightBarButtonItem.enabled = (BOOL)self.selectedIndexPath;
}

@end
