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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, SQAlign) {
    SQAlignHCenter = 1, 
    SQAlignLeft = 1 << 2,
    SQAlignRight = 1 << 3,
    SQAlignExactHCenter = 1 << 4,
    SQAlignExactLeft = 1 << 5,
    SQAlignExactRight = 1 << 6,
    
    SQAlignVCenter = 1 << 7,
    SQAlignTop = 1 << 8,
    SQAlignBottom = 1 << 9,
    SQAlignExactVCenter = 1 << 10,
    SQAlignExactTop = 1 << 11,
    SQAlignExactBottom = 1 << 12,
    SQAlignNone = 1 << 13,
    SQAlignCenter = 1 << 14,
};

typedef NS_OPTIONS(NSUInteger, SQPlace) {
    SQPlaceOnLeft = 1,
    SQPlaceOnRight = 1 << 1,
    SQPlaceAbove = 1 << 2,
    SQPlaceBelow = 1 << 3,
    SQPlaceNone = 1 << 4,
    SQPlaceWithin = 1 << 4,
};

typedef NS_OPTIONS(NSUInteger, SQSize) {
    SQSizeUseAllWidth = 1,
    SQSizeUseAllHeight = 1 << 1,
    SQSizeUseAvailableWidth = 1 << 2,
    SQSizeUseAvailableHeight = 1 << 3,
};

struct SQPadding {
    CGFloat left;
    CGFloat right;
    CGFloat top;
    CGFloat bottom;
};
typedef struct SQPadding SQPadding;

CG_INLINE SQPadding
SQPaddingMake(CGFloat top, CGFloat bottom, CGFloat left, CGFloat right)
{
    SQPadding padding;
    padding.top = top; padding.bottom = bottom;
    padding.left = left; padding.right = right;
    return padding;
}

CG_EXTERN const SQPadding SQPaddingZero;

@interface SQLayout : NSObject

/*
 * A dynamic method which works out a users intentions based on the
 * configuration and types of the given Views. This method allows
 * the size to be controlled by the user.
 */
+ (UIView*) layoutView:(UIView *) view relativeToView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
              withSize:(CGSize) size
           withPadding:(SQPadding) padding;

+ (UIView*) layoutView:(UIView *) view relativeToView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding;

@end
