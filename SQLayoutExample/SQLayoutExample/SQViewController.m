//
//  SQViewController.m
//  SQLayoutExample
//
//  Created by Bradley Clayton on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SQViewController.h"
#import "SQView.h"

@interface SQViewController ()

@end

@implementation SQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setView:[[SQView alloc] initWithFrame:[[self view] frame]]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
