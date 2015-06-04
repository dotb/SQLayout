/*
 Copyright (C) 2009-2014 Bradley Clayton. All rights reserved.
 
 SQLayout can be downloaded from: https://github.com/dotb/SQLayout
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of SQLayout nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "SQLayout.h"

@interface SQLayout ()
// Layout a child view within a parent
+ (CGRect) layoutRect:(CGRect) frame withinParentView:(UIView*) parentView
            alignment:(SQAlign) alignment
            withWidth:(CGFloat) width withHeight:(CGFloat) height
          withPadding:(SQPadding) padding;

// Layout a view relative to a peer
+ (CGRect) layoutRect:(CGRect) frame relativeToPeerView:(UIView*) relativeView
            placement:(SQPlace) placement alignment:(SQAlign) alignment
            withWidth:(CGFloat) width withHeight:(CGFloat) height
          withPadding:(SQPadding) padding;


+ (void)resizeUILabel:(UILabel *) label constrainedToTotalSize:(CGSize) size;
@end

@implementation SQLayout

const SQPadding SQPaddingZero = {
    .top = 0.,
    .bottom = 0.,
    .left = 0.,
    .right = 0.
};

+ (UIView*) layoutView:(UIView *) view relativeToView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
              withSize:(CGSize) size
           withPadding:(SQPadding) padding
{
    return [SQLayout layoutView:view relativeToView:relativeView
               placement:placement alignment:alignment
               withWidth:size.width withHeight:size.height
             withPadding:padding];
}

+ (UIView*) layoutView:(UIView *) view relativeToView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding

{
    CGRect viewFrame = [view frame];
    
    /* If the view is not placed within a superview, attempt to add
     * it to a superview based on it's placement strategy.
     */
    if (![view superview] && (placement & SQPlaceWithin))
    {
        [relativeView addSubview:view];
    }
    else if (![view superview] && [relativeView superview])
    {
        [[relativeView superview] addSubview:view];
    }
    
    // We handle labels differently, because they are best sized relative to their content and font
    if ([view isKindOfClass:[UILabel class]])
    {
        // Resize the label to fit within the given size
        //UILabel *label = (UILabel *) view;
        [self resizeUILabel:(UILabel*)view constrainedToTotalSize:CGSizeMake(width, height)];
        viewFrame.size.width = view.frame.size.width;
        viewFrame.size.height = view.frame.size.height;
    }
    else
    {
        viewFrame.size.width = width;
        viewFrame.size.height = height;
    }
    
    // Is the view a child of the relative View ?
    if ([view superview] == relativeView)
    {
        viewFrame = [self layoutRect:viewFrame withinParentView:relativeView
               alignment:alignment
               withWidth:viewFrame.size.width withHeight:viewFrame.size.height
             withPadding:padding];
    }
    else
    {
        // Assume the view is a peer of the relative view
        viewFrame = [self layoutRect:viewFrame relativeToPeerView:relativeView
               placement:placement alignment:alignment 
               withWidth:viewFrame.size.width withHeight:viewFrame.size.height
             withPadding:padding];
    }
    
    // Round off the coordinate and size to ensure pixel perfect rendering
    viewFrame.origin.x = roundf(viewFrame.origin.x);
    viewFrame.origin.y = roundf(viewFrame.origin.y);
    viewFrame.size.width = ceilf(viewFrame.size.width);
    viewFrame.size.height = ceilf(viewFrame.size.height);
    
    // Finally, update the view with new new frame.
    [view setFrame:viewFrame];
    
    return view;
}



// Layout a child view within a parent
+ (CGRect) layoutRect:(CGRect) frame withinParentView:(UIView*) parentView
             alignment:(SQAlign) alignment 
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding
{
    // Alignment
    if (alignment & SQAlignLeft)
        frame.origin.x = padding.left;
    
    if (alignment & SQAlignRight)
        frame.origin.x = parentView.bounds.size.width - width - padding.right;
    
    if (alignment & SQAlignExactLeft)
        frame.origin.x = 0;
    
    if (alignment & SQAlignExactRight)
        frame.origin.x = parentView.bounds.size.width - width;
    
    if (alignment & SQAlignHCenter)
        frame.origin.x = (parentView.bounds.size.width / 2 - width / 2) + padding.left - padding.right;
    
    if (alignment & SQAlignVCenter)
        frame.origin.y = (parentView.bounds.size.height / 2 - height / 2) + padding.top - padding.bottom;
    
    if (alignment & SQAlignExactHCenter)
        frame.origin.x = (parentView.bounds.size.width / 2 - width / 2);
    
    if (alignment & SQAlignCenter)
    {
        frame.origin.x = (parentView.bounds.size.width / 2 - width / 2) + padding.left - padding.right;
        frame.origin.y = (parentView.bounds.size.height / 2 - height / 2) + padding.top - padding.bottom;
    }
    
    if (alignment & SQAlignVCenter)
        frame.origin.y = (parentView.bounds.size.height / 2 - height / 2) + padding.top - padding.bottom;
    
    if (alignment & SQAlignTop)
        frame.origin.y = padding.top;
    
    if (alignment & SQAlignBottom)
        frame.origin.y = parentView.bounds.size.height - height - padding.bottom; 
    
    if (alignment & SQAlignExactTop)
        frame.origin.y = 0;
    
    if (alignment & SQAlignExactBottom)
        frame.origin.y = parentView.bounds.size.height - height;
    
    return frame;
}

// Layout a view relative to a peer
+ (CGRect) layoutRect:(CGRect) frame relativeToPeerView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding;
{
    // Placement
    if (placement & SQPlaceOnLeft)
        frame.origin.x = relativeView.frame.origin.x - width - padding.right;
    
    if (placement & SQPlaceOnRight)
        frame.origin.x = relativeView.frame.origin.x + relativeView.frame.size.width + padding.left;
    
    if (placement & SQPlaceAbove)
        frame.origin.y = relativeView.frame.origin.y - height - padding.bottom;
    
    if (placement & SQPlaceBelow)
        frame.origin.y = relativeView.frame.origin.y + relativeView.frame.size.height + padding.top;
    
    // Alignment
    if (alignment & SQAlignLeft)
        frame.origin.x = relativeView.frame.origin.x + padding.left;
            
    if (alignment & SQAlignRight)
        frame.origin.x = relativeView.frame.origin.x + relativeView.frame.size.width - width - padding.right;

    if (alignment & SQAlignExactLeft)
        frame.origin.x = relativeView.frame.origin.x;

    if (alignment & SQAlignExactRight)
        frame.origin.x = relativeView.frame.origin.x + relativeView.frame.size.width - width;

    if (alignment & SQAlignHCenter)
        frame.origin.x = (relativeView.frame.origin.x + relativeView.frame.size.width / 2 - width / 2) + padding.left - padding.right;

    if (alignment & SQAlignVCenter)
        frame.origin.y = (relativeView.frame.origin.y + relativeView.frame.size.height / 2 - height / 2) + padding.left - padding.bottom;
        
    if (alignment & SQAlignExactHCenter)
        frame.origin.x = (relativeView.frame.origin.x + relativeView.frame.size.width / 2 - width / 2);
    
    if (alignment & SQAlignExactVCenter)
        frame.origin.y = (relativeView.frame.origin.y + relativeView.frame.size.height / 2 - height / 2);
    
    if (alignment & SQAlignTop)
        frame.origin.y = relativeView.frame.origin.y + padding.top;
            
    if (alignment & SQAlignBottom)
        frame.origin.y = relativeView.frame.origin.y + relativeView.frame.size.height - height - padding.bottom; 

    if (alignment & SQAlignExactTop)
        frame.origin.y = relativeView.frame.origin.y;

    if (alignment & SQAlignExactBottom)
        frame.origin.y = relativeView.frame.origin.y + relativeView.frame.size.height - height;

    return frame;
}


+ (void)resizeUILabel:(UILabel *) label constrainedToTotalSize:(CGSize) size
{
    //get the current frame
    CGRect labelFrame = [label frame];
    
    //constrain it to the size specified, or smaller if possible
    CGSize labelTextSize = [label sizeThatFits:size];
    labelTextSize.width = labelTextSize.width > size.width ? size.width : labelTextSize.width;
    labelTextSize.height = labelTextSize.height > size.height ? size.height : labelTextSize.height;
    [label setFrame:CGRectMake(labelFrame.origin.x, labelFrame.origin.y, labelTextSize.width, labelTextSize.height)];
}

@end
