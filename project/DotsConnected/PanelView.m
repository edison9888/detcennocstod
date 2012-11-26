//
//  CanvasView.m
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "PanelView.h"

#import "Dot.h"

@interface CanvasView ()
{
    NSMutableArray* mDots;

}
@property (nonatomic, retain) NSMutableArray* mDots;


@end
@implementation CanvasView
@synthesize mDots;

- (void)drawRect:(CGRect)rect
{
    if (self.mDots.count >= 2)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBStrokeColor(context, 255, 255, 255, 1.0);
        CGContextSetLineWidth(context, 2.0);
        
        Dot* sDot0 = (Dot*)[self.mDots objectAtIndex:0];
        CGContextMoveToPoint (context, sDot0.center.x, sDot0.center.y);

        for (int i=1; i<self.mDots.count; i++)
        {
            Dot* sDot = (Dot*)[self.mDots objectAtIndex:i];
            CGContextAddLineToPoint (context, sDot.center.x, sDot.center.y);
        }
        
        CGContextStrokePath(context);
    }
    
}

- (void) dealloc
{
    self.mDots = nil;

    [super dealloc];
}

//aPos serves as the left-top point of the dot
- (BOOL) addDotAt:(CGPoint)aPos;
{

    CGPoint sNewPos = [self adjustDotPosIfNecessary:aPos];
    
    if (!CGRectContainsPoint(self.bounds, sNewPos))
    {
        return NO;
    }
    Dot* sDot = [Dot getDot];
    sDot.alpha = 0;

    [sDot setFrame:CGRectMake(sNewPos.x, sNewPos.y, sDot.frame.size.width, sDot.frame.size.height)];
    [self addSubview:sDot];
    
    if (!self.mDots)
    {
        NSMutableArray* sDots = [[NSMutableArray alloc] initWithCapacity:100];
        self.mDots = sDots;
        [sDots release];
    }
    
    [self.mDots addObject:sDot];
    
    [UIView animateWithDuration:1 animations:^{
        sDot.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];

    
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * sTouch = [touches anyObject];
    CGPoint sTouchPoint = [sTouch locationInView:self];
    
    BOOL sIsDotAdded = [self addDotAt:sTouchPoint];
    if (sIsDotAdded)
    {
        [self setNeedsDisplay];
    }
}

- (CGPoint) adjustDotPosIfNecessary:(CGPoint)aOldPos;
{
    CGPoint sNewPos = aOldPos;
    
    
    BOOL sIsXAdjusted = NO;
    BOOL sIsYAdjusted = NO;
    
    //1. compare with 4 boundary of canvas
    CGPoint sRightBottomPoint = CGPointMake(aOldPos.x+[Dot getDotSize].width, aOldPos.y+[Dot getDotSize].height);
    if (sRightBottomPoint.x > self.bounds.size.width)
    {
        sIsXAdjusted = YES;
        sNewPos.x = self.bounds.size.width- [Dot getDotSize].width;
    }
    if (sRightBottomPoint.y > self.bounds.size.height)
    {
        sIsYAdjusted = YES;
        sNewPos.y = self.bounds.size.height- [Dot getDotSize].height;
    }
    
    //2. compare with other existing dots
    CGRect sRectForDot = CGRectMake(aOldPos.x, aOldPos.y, [Dot getDotSize].width, [Dot getDotSize].height);

    for (Dot* sDot in self.mDots)
    {
        if (CGRectIntersectsRect(sDot.frame, sRectForDot))
        {
            //adjust sNewPos
        }
    }
    
    
    return sNewPos;
}

@end



@interface PanelView ()
{
    UIImageView* mBackgroundImage;
    CanvasView* mCanvas;
    
}
@property (nonatomic, retain) UIImageView* mBackgroundImage;
@property (nonatomic, retain) CanvasView* mCanvas;
@end


@implementation PanelView
@synthesize mBackgroundImage;
@synthesize mCanvas;


- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage*)aBGImage
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //background image
        if (aBGImage)
        {
            UIImageView* sCanvasImageView = [[UIImageView alloc] initWithFrame:frame];
            [sCanvasImageView setImage:aBGImage];
            
            [self addSubview:sCanvasImageView];
            self.mBackgroundImage = sCanvasImageView;
            [sCanvasImageView release];
        }
                
        //canvas
        CanvasView* sCanvas = [[CanvasView alloc] initWithFrame:frame];
        sCanvas.backgroundColor = [UIColor clearColor];
        [self addSubview:sCanvas];
        self.mCanvas = sCanvas;
        [sCanvas release];
        
    }
    return self;
}


- (void) dealloc
{
    self.mBackgroundImage = nil;
    self.mCanvas = nil;
    
    [super dealloc];
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
