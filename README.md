#SQLayout
SQLayout is an iOS library that provides simple layout tools for UIViews that need to be placed relative to one another. SQLayout works with Swift and Objective-C.

##SQLayout directives
Layout is performed through alignment and placement directives.

###Alignment

**Centred alignment**

- SQAlignHCenter: align with the horizontal centre of the relative view
- SQAlignVCenter: align with the vertical centre of the relative view

**These alignment directives will include the padding**

- SQAlignTop: align with with the top of the relative view, adding in top padding
- SQAlignBottom: align with with the bottom of the relative view, adding in bottom padding
- SQAlignLeft: align with with the left-hand side of the relative view, adding in left padding
- SQAlignRight: align with with the right-hand side of the relative view, adding in right padding

**Exact layout directives ignore the padding argument**

- SQAlignExactTop: align with with the exact top of the relative view, without padding
- SQAlignExactBottom: align with with the exact bottom of the relative view, without padding
- SQAlignExactLeft: align with with the exact left-hand side of the relative view, without padding
- SQAlignExactRight: align with with the exact right-hand side of the relative view, without padding

**Sometimes you may prefer not to perform any alignment at all**

- SQAlignNone: do not perform any alignment of the view

###Placement

- SQPlaceOnLeft: place on the left of the relative view
- SQPlaceOnRight: place on the right of the relative view
- SQPlaceAbove: place above the relative view
- SQPlaceBelow: place below the relative view
- SQPlaceWithin or SQPlaceNone: do not perform placement. This is useful for laying out a child view within its parent view.

##Examples

**Laying out a view relative to another view**

Consider two UIImageViews: imageView1 and imageView2. If you wanted to place imageView2 to the right of imageView1, and align the top of imageView2 exactly in line with the top of imageView1, with a padding space of 20 pixels between the views:
    
    [SQLayout layoutView:imageView2 relativeToView:imageView1
        placement:SQPlaceOnRight alignment:SQAlignExactTop
        withWidth:imageView2.frame.size.width withHeight:imageView2.frame.size.height
        withPadding:SQPaddingMake(20, 20, 20, 20)];

**Laying out a child within a parent**

Consider a parent UIView and child UIView. If you wanted to place the child at the top centre of the parent, with a size of 100x100 pixels, and 20 pixels of padding between the top of the parent and the top of the child, you could use the following:

    [SQLayout layoutView:child relativeToView:parent
        placement:SQPlaceWithin alignment:SQAlignTop | SQAlignHCenter
        withWidth:100 withHeight:100
        withPadding:SQPaddingMake(20, 20, 20, 20)];

**Laying out UILabels**

UILabels are treated slightly differently to standard UIView objects, because the optimal width and height of a label depends on the available width and size. Imagine you wanted to lay out a paragraph of text within a confined space of 100x800 pixels. SQLayout will resize a UILabel and wrap its text such that it fits into this space as long as the following is set before making the layout call to SQLayout:

- The text for the label,
- the line wrapping mode,
- the final font to be used.

The following example will lay out a UILabel with 20px of padding on its top and left, with the best size to fit within a space of 100x800px:

    [SQLayout layoutView:LABEL relativeToView:parent
        placement:SQPlaceNone alignment:SQAlignTop | SQAlignLeft
        withWidth:100 withHeight:100
        withPadding:SQPaddingMake(20, 20, 20, 20)];

#LICENSE (New-BSD)
Copyright (c) 2014, Bradley Clayton (http://squarepolka.com). All rights reserved.

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
