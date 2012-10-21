//
//  SQView.m
//  SQLayoutExample
//
//  Created by Bradley Clayton on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SQView.h"
#import "SQLayout.h"

@implementation SQView
@synthesize labelOne, labelTwo, labelThree, 
            labelFour, labelFive, labelSix, 
            labelSeven, labelEight, labelNine;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        /* There's no point in setting frame rect's here. Instead, we'll 
         * use relative layout when layoutSubviews is called */
        [self setLabelOne:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelTwo:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelThree:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelFour:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelFive:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelSix:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelSeven:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelEight:[[UILabel alloc] initWithFrame:CGRectZero]];
        [self setLabelNine:[[UILabel alloc] initWithFrame:CGRectZero]];      
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [labelOne setText:@"Hello. I am the first label"];
        [labelOne setBackgroundColor:[UIColor greenColor]];
        
        [labelTwo setText:@"I am the second label"];
        [labelTwo setBackgroundColor:[UIColor blueColor]];
        [labelTwo setTextColor:[UIColor whiteColor]];
        
        [self addSubview:labelOne];
        [self addSubview:labelTwo];
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    SQPadding padding;
    padding.right = 10;
    padding.left = 30;
    
    [SQLayout layoutView:labelOne relativeToView:self
               placement:SQPlaceWithin 
               alignment:SQAlignVCenter | SQAlignHCenter
               withWidth:self.bounds.size.width
              withHeight:self.bounds.size.height 
             withPadding:SQPaddingZero];
    
    [SQLayout layoutView:labelTwo relativeToView:labelOne
               placement:SQPlaceBelow
               alignment:SQAlignHCenter
               withWidth:self.bounds.size.width
              withHeight:self.bounds.size.height 
             withPadding:padding];
}

@end
