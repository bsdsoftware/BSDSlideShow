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
	
	[self.slideshowController beginSlideshowWithImages:@[[UIImage imageNamed:@"img1"],
														 [UIImage imageNamed:@"img2"],
														 [UIImage imageNamed:@"img3"],
														 [UIImage imageNamed:@"img4"]]];
}

@end
