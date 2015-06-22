//
//  BSDSlideShowController.h
//  BSDSlideShow
//
//  Created by Simone Fantini on 19/06/15.
//  Copyright (c) 2015 BSDSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSDSlideShowController : NSObject

@property (nonatomic, weak) IBOutlet UIView *slideshowView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, assign) NSTimeInterval changeImageInterval;
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 Per ora è necessario passare un'array di UIImage
 */
- (void)beginSlideshowWithImages:(NSArray *)images;
- (void)showNextImage:(BOOL)animating;
- (UIImage *)currentImage;
- (UIImage *)nextImage;

@end
