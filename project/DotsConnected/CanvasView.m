//
//  CanvasView.m
//  DotsConnected
//
//  Created by Wen Shane on 12-12-3.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "CanvasView.h"
#import "Dot.h"
#import "Line.h"
#import "TouchEventResponderDelegate.h"

#define DISTNACE_THRESHOLD  10

@interface CanvasView ()
{
    NSMutableArray* mDots;
    NSMutableArray* mLines;
    PanelView*  mPanel;
    
}
@property (nonatomic, retain) NSMutableArray* mDots;
@property (nonatomic, retain) NSMutableArray* mLines;
@property (nonatomic, assign) PanelView* mPanel;

@end

@implementation CanvasView
@synthesize mDots;
@synthesize mLines;
@synthesize mPanel;

- (id) initWithFrame:(CGRect)frame onPanelView:(PanelView*)aPanel
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.mPanel = aPanel;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if (self.mLines.count > 0)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        Line* sFirstLine = [self.mLines objectAtIndex:0];
        CGPoint sStartPoint = sFirstLine.mStartPoint;
        CGContextMoveToPoint (context, sStartPoint.x, sStartPoint.y);
        
        for (int i=0; i<self.mLines.count; i++)
        {
            Line* sLine = (Line*)[self.mLines objectAtIndex:i];
            CGPoint sStartPoint = sLine.mStartPoint;
            CGPoint sEndPoint = sLine.mEndPoint;
            
            CGContextBeginPath(context);
            CGContextMoveToPoint (context, sStartPoint.x, sStartPoint.y);
            CGContextSetStrokeColorWithColor(context, sLine.mColor.CGColor);
            CGContextSetLineWidth(context, sLine.mWidth);
            CGContextAddLineToPoint (context, sEndPoint.x, sEndPoint.y);
            CGContextStrokePath(context);

        }
        
    }
    
}

- (void) dealloc
{
    self.mDots = nil;
    self.mLines = nil;
    
    [super dealloc];
}

//caculate the distance from a point to a line segment.
//（x1,y1),(x2,y2）are two endpoints of line，(x3,y3) is a point
- (double)CalDis:(double)x1:(double)y1:(double)x2:(double)y2:(double)x3:(double)y3
{
    double px = x2 - x1;
    double py = y2 - y1;
    double som = px * px + py * py;
    double u = ((x3 - x1) * px + (y3 - y1) * py) / som;
    if (u > 1) {
        u = 1;
    }
    if (u < 0) {
        u = 0;
    }
    //the closest point
    double x = x1 + u * px;
    double y = y1 + u * py;
    double dx = x - x3;
    double dy = y - y3;
    double dist = sqrt(dx*dx + dy*dy);
    
    return dist;
}


- (CGFloat) computeDistancePoint:(CGPoint)aPoint toLine:(Line*)aLine
{
    return [self CalDis:aLine.mStartPoint.x :aLine.mStartPoint.y :aLine.mEndPoint.x:aLine.mEndPoint.y :aPoint.x :aPoint.y];
}

- (NSInteger) getIndexOfValidClosestLineToPoint:(CGPoint)aPoint
{
    CGFloat sMinDistance = CGFLOAT_MAX;
    CGFloat sIndexOfLineSelected = -1;
    for (int i=0; i<self.mLines.count; i++)
    {
        Line* sLine = [self.mLines objectAtIndex:i];
        CGFloat sDistance = [self computeDistancePoint:aPoint toLine:sLine];
        sDistance = sDistance-sLine.mWidth/2;
        if (sDistance < sMinDistance)
        {
            sMinDistance = sDistance;
            sIndexOfLineSelected = i;
        }
    }
    
    if (sIndexOfLineSelected != -1)
    {
        if (sMinDistance < DISTNACE_THRESHOLD)
        {
            return sIndexOfLineSelected;
        }
    }
    
    return -1;
}

//return -1 if its dot addition action, or the index of the line touched.
- (NSInteger) dotAdditionOrIndexOfLineTouched:(CGPoint)aPoint
{
    NSInteger sIndexOfClosestLine = [self getIndexOfValidClosestLineToPoint:aPoint];
   if (sIndexOfClosestLine != -1)
   {
       return sIndexOfClosestLine;
   }
   else
   {
       return -1;
   }
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
    [sDot addTarget:self action:@selector(dotTouched:) forControlEvents:UIControlEventTouchDown];
    
    [self addDot:sDot];
    if ([self.mDots count] >= 2)
    {
        Dot* sLastButOneDot = [self.mDots objectAtIndex:self.mDots.count-2];
        Dot* sLastDot = [self.mDots objectAtIndex:self.mDots.count-1];
        [self addLineDot1:sLastButOneDot Dot2:sLastDot];
    }
    
    
    [UIView animateWithDuration:0.7 animations:^{
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
    
    BOOL sCanvasNeedsUpdate = NO;
    NSInteger sDotAdditionOrIndexOfLineTouched = [self dotAdditionOrIndexOfLineTouched:sTouchPoint];
    if (-1 == sDotAdditionOrIndexOfLineTouched)
    {
           sCanvasNeedsUpdate = [self addDotAt:sTouchPoint];
    }
    else
    {
        id<TouchEventResponderDelegate> x = self.mPanel.mDelegate;
        [x linePressed:[self.mLines objectAtIndex:sDotAdditionOrIndexOfLineTouched]];
    }
    
    if (sCanvasNeedsUpdate)
    {
        [self refreshCanvas];
    }
}

//adjust the dot position if necessary; return adjusted position whether the position is adjusted or not.
- (CGPoint) adjustDotPosIfNecessary:(CGPoint)aOldPos;
{
    CGPoint sNewPos = aOldPos;
    
    
    //1. compare with the boundary of canvas
    CGPoint sRightBottomPoint = CGPointMake(aOldPos.x+[Dot getSharedSize].width, aOldPos.y+[Dot getSharedSize].height);
    if (sRightBottomPoint.x > self.bounds.size.width)
    {
        sNewPos.x = self.bounds.size.width- [Dot getSharedSize].width;
    }
    if (sRightBottomPoint.y > self.bounds.size.height)
    {
        sNewPos.y = self.bounds.size.height- [Dot getSharedSize].height;
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

- (void) refreshCanvas
{
    [self setNeedsDisplay];
}


- (void) addDot:(Dot*)aDot;
{
    [self addSubview:aDot];
    
    if (!self.mDots)
    {
        NSMutableArray* sDots = [[NSMutableArray alloc] initWithCapacity:100];
        self.mDots = sDots;
        [sDots release];
    }
    
    [self.mDots addObject:aDot];

}

- (void) addLineDot1:(Dot*)aDot1 Dot2:(Dot*)aDot2
{
    if (!self.mLines)
    {
        NSMutableArray* sLines = [[NSMutableArray alloc] initWithCapacity:100];
        self.mLines = sLines;
        [sLines release];
    }
    if (aDot1
        && aDot2)
    {
        Line* sLine = [[Line alloc] initWithStartPoint:aDot1.center EndPoint:aDot2.center onCanvas:self];
                
        [self.mLines addObject:sLine];
        
        [sLine release];
    }
}

- (void) dotTouched:(id)aDot
{
    id<TouchEventResponderDelegate> sTouchEventResponderDelegate = self.mPanel.mDelegate;
    [sTouchEventResponderDelegate dotPressed:aDot];
}

@end
