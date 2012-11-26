//
//  Dot.m
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "Dot.h"

#define DEFAULT_DOT_SIZE CGSizeMake(15, 15)
#define DEFAULT_DOT_EDGE_INSETS UIEdgeInsetsZero

static CGSize DotSize;
static UIEdgeInsets DotEdgeInsets;

@implementation Dot

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        
        UILabel* sLabel = [[UILabel alloc] initWithFrame:self.bounds];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.textColor = [UIColor whiteColor];
        sLabel.textAlignment = UITextAlignmentCenter;
        sLabel.text = @"X";
        sLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:sLabel];
        
        [sLabel release];

    }
    return self;
}

+ (BOOL) setDotSize:(CGSize)aSize
{
    DotSize = aSize;
    
    return YES;
}

+ (CGSize) getDotSize
{
    return DotSize;
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
    if (CGSizeEqualToSize(DotSize, CGSizeZero))
    {
        DotSize = DEFAULT_DOT_SIZE;
    }
    
    Dot* sDot = [[[Dot alloc] initWithFrame:CGRectMake(0, 0, DotSize.width, DotSize.height)] autorelease];
    return sDot;
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
