//
//  ViewController.m
//  BSDSlideShow
//
//  Created by Simone Fantini on 19/06/15.
//  Copyright (c) 2015 BSDSoftware. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.slideshowController.contentMode = UIViewContentModeScaleAspectFill;
	
	[self.slideshowController beginSlideshowWithImages:@[[UIImage imageNamed:@"Jellyfish.jpg"]]];
	
	/*[self.slideshowController beginSlideshowWithImages:@[[UIImage imageNamed:@"img1"],
														 [UIImage imageNamed:@"img2"],
														 [UIImage imageNamed:@"img3"],
														 [UIImage imageNamed:@"img4"]]];*/
	
	/*dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self.slideshowController beginSlideshowWithImages:@[[UIImage imageNamed:@"Chrysanthemum.jpg"],
															 [UIImage imageNamed:@"Desert.jpg"],
															 [UIImage imageNamed:@"Hydrangeas.jpg"],
															 [UIImage imageNamed:@"Jellyfish.jpg"]]];
	});*/
}

- (IBAction)nextImage:(id)sender {
	[self.slideshowController showNextImage:NO];
}

@end