//
//  ViewController.h
//  BSDSlideShow
//
//  Created by Simone Fantini on 19/06/15.
//  Copyright (c) 2015 BSDSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSDSlideShowController.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet BSDSlideShowController *slideshowController;

- (IBAction)nextImage:(id)sender;

@end

