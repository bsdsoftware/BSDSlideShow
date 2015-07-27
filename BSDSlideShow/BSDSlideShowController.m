//
//  BSDSlideShowController.m
//  BSDSlideShow
//
//  Created by Simone Fantini on 19/06/15.
//  Copyright (c) 2015 BSDSoftware. All rights reserved.
//

#import "BSDSlideShowController.h"

@interface BSDSlideShowController ()

@property (nonatomic, strong) UIImageView *visibleImageView;
@property (nonatomic, strong) UIImageView *nextImageView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSUInteger currentImageIndex;

@end

@implementation BSDSlideShowController

- (instancetype)init {
	if (self = [super init]) {
		self.currentImageIndex = 0;
		self.contentMode = UIViewContentModeCenter;
	}
	return self;
}

- (void)dealloc {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)clearImageViews {
	for (UIView *subView in self.slideshowView.subviews) {
		if ([subView isKindOfClass:[UIImageView class]]) {
			[subView removeFromSuperview];
		}
	}
}

- (void)beginSlideshowWithImages:(NSArray *)images {
	assert(self.slideshowView != nil);
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self clearImageViews];
	
	if (self.changeImageInterval <= 0)
		self.changeImageInterval = 5;
	
	self.images = [images copy];
	
	if (self.pageControl) {
		self.pageControl.numberOfPages = self.images.count;
		self.pageControl.currentPage = self.currentImageIndex;
	}
	
	CGRect slideshowViewBounds = self.slideshowView.bounds;
	UIImageView *imgView1 = [[UIImageView alloc] initWithImage:[self currentImage]];
	imgView1.contentMode = self.contentMode;
	imgView1.frame = slideshowViewBounds;
	imgView1.clipsToBounds = YES;
	self.visibleImageView = imgView1;
	
	UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:slideshowViewBounds];
	imgView2.frame = CGRectOffset(imgView2.frame, CGRectGetWidth(slideshowViewBounds), 0);
	imgView2.contentMode = self.contentMode;
	imgView2.clipsToBounds = YES;
	self.nextImageView = imgView2;
	
	[self.slideshowView addSubview:self.visibleImageView];
	[self.slideshowView addSubview:self.nextImageView];
	[self preloadNextImage];
	
	[self performSelector:@selector(showNextImageAnimatingNSNumber:) withObject:@(YES) afterDelay:self.changeImageInterval];
}

- (UIImage *)currentImage {
	return self.images[self.currentImageIndex];
}

- (UIImage *)nextImage {
	NSUInteger nextImageIndex = [self calculateNextImageIndex];
	return self.images[nextImageIndex];
}

- (NSUInteger)calculateNextImageIndex {
	if (self.currentImageIndex < self.images.count - 1) {
		return self.currentImageIndex + 1;
	} else {
		return 0;
	}
}

- (void)preloadNextImage {
	//per ora sono già tutti oggetti UIImage, quindi carico tutto sul main thread
	self.nextImageView.image = [self nextImage];
}

- (void)showNextImage:(BOOL)animating {
	[self showNextImageAnimatingNSNumber:@(animating)];
}

- (void)showNextImageAnimatingNSNumber:(NSNumber *)animatingNumber {
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	
	BOOL animating = [animatingNumber boolValue];
	CGRect slideshowViewBounds = self.slideshowView.bounds;
	CGFloat deltaX = CGRectGetWidth(slideshowViewBounds);
	
	void(^animationBlock)() = ^{
		self.visibleImageView.frame = CGRectOffset(self.visibleImageView.frame, -deltaX, 0);
		self.nextImageView.frame = CGRectOffset(self.nextImageView.frame, -deltaX, 0);
	};
	
	void(^completitionBlock)(BOOL) = ^(BOOL finished) {
		if (!finished)
			return;
		
		self.currentImageIndex = [self calculateNextImageIndex];
		if (self.pageControl) {
			self.pageControl.currentPage = self.currentImageIndex;
		}
		
		UIImageView *newNextImage = self.visibleImageView;
		self.visibleImageView = self.nextImageView;
		self.nextImageView = newNextImage;
		self.nextImageView.frame = CGRectOffset(self.nextImageView.frame, 2 * deltaX, 0);
		[self preloadNextImage];
		
		[self performSelector:@selector(showNextImageAnimatingNSNumber:) withObject:@(YES) afterDelay:self.changeImageInterval];
	};
	
	if (animating) {
		[UIView animateWithDuration:self.animationDuration
						 animations:animationBlock
						 completion:completitionBlock];
	} else {
		animationBlock();
		completitionBlock(YES);
	}
}

@end
