//
//  ViewController.m
//  Example-ionicons
//  Copyright (c) 2013 TapTemplate. All rights reserved.
//

#import "ViewController.h"
#import "IonIcons.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UILabel Example:
    UILabel *label = [IonIcons labelWithIcon:ion_archive size:20.0f color:[UIColor blackColor]];
    label.center = CGPointMake(self.view.center.x, self.view.center.y-200.0f);
    [self.view addSubview:label];
    
    // UIImage Example:
    // NOTE: The image methods only work if your app's base sdk is iOS 6+.
    UIImage *icon = [IonIcons imageWithIcon:ion_archive iconColor:[UIColor redColor]
                                      iconSize:60.0f
                                     imageSize:CGSizeMake(90.0f, 90.0f)];
    UIImageView *img = [[UIImageView alloc] initWithImage:icon];
    img.center = self.view.center;
    img.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:img];
}

@end
