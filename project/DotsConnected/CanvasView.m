//
//  CanvasView.m
//  DotsConnected
//
//  Created by Wen Shane on 12-12-3.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "CanvasView.h"
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

//adjust the dot position if necessary; return adjusted position whether the position is adjusted or not.
- (CGPoint) adjustDotPosIfNecessary:(CGPoint)aOldPos;
{
    CGPoint sNewPos = aOldPos;
    
    
    //1. compare with the boundary of canvas
    CGPoint sRightBottomPoint = CGPointMake(aOldPos.x+[Dot getSize].width, aOldPos.y+[Dot getSize].height);
    if (sRightBottomPoint.x > self.bounds.size.width)
    {
        sNewPos.x = self.bounds.size.width- [Dot getSize].width;
    }
    if (sRightBottomPoint.y > self.bounds.size.height)
    {
        sNewPos.y = self.bounds.size.height- [Dot getSize].height;
    }
    
    //2. compare with other existing dots. For now, we do not have to take the overlapping siutuations into consideration.
//    CGRect sRectForDot = CGRectMake(sNewPos.x, sNewPos.y, [Dot getDotSize].width, [Dot getDotSize].height);
//    
//    for (Dot* sDot in self.mDots)
//    {
//        if (CGRectIntersectsRect(sDot.frame, sRectForDot))
//        {
//            //adjust sNewPos
//        }
//    }
    
    
    return sNewPos;
}

@end
