//
//  QBImagePickerController.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBImagePickerController.h"
#import <Photos/Photos.h>

// ViewControllers
#import "QBAlbumsViewController.h"

@implementation NSBundle (QBImagePicker)

+ (NSBundle *)assetBundle {
    NSBundle *mainBundle = [NSBundle bundleForClass:[QBImagePickerController class]];
    NSString *bundlePath = [mainBundle pathForResource:@"QBImagePicker" ofType:@"bundle"];
    if (bundlePath) {
        return [NSBundle bundleWithPath:bundlePath];
    }
    return mainBundle;
}

@end

@interface QBImagePickerController ()

@end

@implementation QBImagePickerController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        // Set default values
        self.assetCollectionSubtypes = @[
                                         @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                         @(PHAssetCollectionSubtypeAlbumMyPhotoStream),
                                         @(PHAssetCollectionSubtypeSmartAlbumPanoramas),
                                         @(PHAssetCollectionSubtypeSmartAlbumVideos),
                                         @(PHAssetCollectionSubtypeSmartAlbumBursts)
                                         ];
        self.minimumNumberOfSelection = 1;
        self.numberOfColumnsInPortrait = 4;
        self.numberOfColumnsInLandscape = 7;
        
        _selectedAssets = [NSMutableOrderedSet orderedSet];
        
        [self setUpAlbumsViewController];
    }
    
    return self;
}

- (void)setMediaType:(QBImagePickerMediaType)mediaType {
    
    _mediaType = mediaType;
    
    // Set instance
    QBAlbumsViewController *albumsViewController = (QBAlbumsViewController *)self.albumsNavigationController.topViewController;
    albumsViewController.imagePickerController = self;
}

- (void)setUpAlbumsViewController
{
    UIImage *image = [UIImage imageNamed:@"imagePicker_nav_back" inBundle:[NSBundle assetBundle] compatibleWithTraitCollection:[UITraitCollection traitCollectionWithDisplayScale:0.0]];

    // Add QBAlbumsViewController as a child
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"QBImagePicker" bundle:[NSBundle assetBundle]];
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"QBAlbumsNavigationController"];
    
    navigationController.navigationBar.translucent = NO;
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.502f green:0.502f blue:0.502f alpha:1.00f];
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.200f green:0.200f blue:0.200f alpha:1.00f];
    
    navigationController.navigationBar.backIndicatorImage = image;
    navigationController.navigationBar.backIndicatorTransitionMaskImage = image;

    navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    [self addChildViewController:navigationController];
    
    navigationController.view.frame = self.view.bounds;
    [self.view addSubview:navigationController.view];
    
    [navigationController didMoveToParentViewController:self];
    
    self.albumsNavigationController = navigationController;
}

@end
