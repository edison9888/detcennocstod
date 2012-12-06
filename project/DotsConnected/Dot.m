//
//  Dot.m
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "Dot.h"

#define DEFAULT_DOT_SIZE CGSizeMake(15, 15)
#define DEFAULT_DOT_BACKGROUND_COLOR  ([UIColor redColor])
#define DEFAULT_DOT_EDGE_INSETS UIEdgeInsetsZero

static CGSize SharedDotSize;
static UIColor* SharedBackgroundColor = nil;
static UIImage* SharedBackgroundImage = nil;
//static UIEdgeInsets DotEdgeInsets; //EdgeInsets is not used for now.

@implementation Dot

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //you can add subviews here.
    }
    return self;
}

+ (void) setSharedSize:(CGSize)aSize
{
    SharedDotSize = aSize;
    
    return;
}

+ (CGSize) getSharedSize
{
    return SharedDotSize;
}


+(void) setSharedBGColor: (UIColor*)aColor
{
    if (aColor)
    {
        [SharedBackgroundColor release];
        SharedBackgroundColor = aColor;
        [SharedBackgroundColor retain];
    }
}

+ (UIColor*) getSharedBGColor
{
    return SharedBackgroundColor;
}

+ (void) setSharedBGImage:(UIImage*)aImage
{
    if (aImage)
    {
        [SharedBackgroundImage release];
        SharedBackgroundImage = aImage;
        [SharedBackgroundImage retain];
        
        //set background color and dot size according to the background image.
        [self setSharedBGColor:[UIColor colorWithPatternImage:SharedBackgroundImage]];
//        [self setSize:CGSizeMake(SharedBackgroundImage.scale*SharedBackgroundImage.size.width, SharedBackgroundImage.scale*SharedBackgroundImage.size.height)];
        
        [self setSharedSize:CGSizeMake(SharedBackgroundImage.size.width, SharedBackgroundImage.size.height)];

    }
    
}

//+ (UIEdgeInsets) getDotEdgeInsets
//{
//    return DotEdgeInsets;
//}
//
//+ (BOOL) setDotEdgeInsets:(UIEdgeInsets)aDotEdgeInsets
//{
//    DotEdgeInsets = aDotEdgeInsets;
//    
//    return YES;
//}


+ (Dot*) getDot
{
    if (CGSizeEqualToSize(SharedDotSize, CGSizeZero))
    {
        SharedDotSize = DEFAULT_DOT_SIZE;
    }
    if (!SharedBackgroundColor)
    {
        SharedBackgroundColor = DEFAULT_DOT_BACKGROUND_COLOR;
    }
    
    Dot* sDot = [[[Dot alloc] initWithFrame:CGRectMake(0, 0, SharedDotSize.width, SharedDotSize.height)] autorelease];
    sDot.backgroundColor = SharedBackgroundColor;
    
    return sDot;
}

- (void) setSize:(CGSize)aSize
{
    [self setBounds:CGRectMake(0, 0, aSize.width, aSize.height)];
}

- (CGSize) getSize
{
    return self.bounds.size;
}

- (void) setBGColor:(UIColor*)aColor
{
    self.backgroundColor = aColor;
}

-  (UIColor*) getBGColor
{
    return self.backgroundColor;
}

- (void) setBGImage:(UIImage*)aImage
{
    [self setBGColor:[UIColor colorWithPatternImage:aImage]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
