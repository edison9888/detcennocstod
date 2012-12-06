//
//  LineInfo.m
//  DotsConnected
//
//  Created by Wen Shane on 12-12-5.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "Line.h"

#define DEFAULT_LINE_COLOR [UIColor whiteColor]
#define DEFAULT_LINE_WIDTH 1

static CGFloat SharedLineWidth=0;
static UIColor* SharedLineColor = nil;

@interface Line ()
{
}

@property (nonatomic, assign) CanvasView* mCanvas;

@end

@implementation Line

@synthesize mStartPoint;
@synthesize mEndPoint;
@synthesize mWidth;
@synthesize mColor;
@synthesize mDashed;
@synthesize mCanvas;


- (id) initWithStartPoint:(CGPoint)aStartPoint EndPoint:(CGPoint)aEndPoint onCanvas:(CanvasView*)aCanvas
{
    self = [super init];
    if (self)
    {
        if (SharedLineWidth == 0)
        {
            SharedLineWidth = DEFAULT_LINE_WIDTH;
        }
        if (!SharedLineColor)
        {
            SharedLineColor = DEFAULT_LINE_COLOR;
        }
        
        
        self.mStartPoint = aStartPoint;
        self.mEndPoint = aEndPoint;
        self.mCanvas = aCanvas;
        
        self.mWidth = DEFAULT_LINE_WIDTH;
        self.mColor = DEFAULT_LINE_COLOR;
        self.mDashed = NO;
    }
    return self;
}

- (void) dealloc
{
    self.mColor = nil;
    
    [super dealloc];
}

- (void)setMStartPoint:(CGPoint)aStartPoint
{
    if (!CGPointEqualToPoint(mStartPoint, aStartPoint))
    {
        mStartPoint = aStartPoint;
        [self statusChanged];
    }
}

- (void) setMEndPoint:(CGPoint)aEndPoint
{
    if (!CGPointEqualToPoint(mEndPoint, aEndPoint))
    {
        mEndPoint = aEndPoint;
        [self statusChanged];
    }
}

- (void) setMWidth:(CGFloat)aWidth
{
    if (mWidth != aWidth)
    {
        mWidth = aWidth;
        [self statusChanged];
    }
}

- (void) setMColor:(UIColor *)aColor
{
    [mColor release];
    mColor = [aColor retain];
    [self statusChanged];
}

- (void) setMDashed:(BOOL)aDashed
{
    if (mDashed != aDashed)
    {
        mDashed = aDashed;
        [self statusChanged];
    }
}


- (void) statusChanged
{
    [self.mCanvas refreshCanvas];
}

+ (void) setSharedLineWidth:(CGFloat)aLineWidth
{
    SharedLineWidth = aLineWidth;
}
+ (CGFloat) getSharedLineWidth
{
    return SharedLineWidth;
}

+(void) setSharedColor: (UIColor*)aColor
{
    if (aColor)
    {
        [SharedLineColor release];
        SharedLineColor = aColor;
        [SharedLineColor retain];
    }

}

+ (UIColor*) getSharedColor
{
    return SharedLineColor;
}


@end
