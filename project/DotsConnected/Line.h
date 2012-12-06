//
//  LineInfo.h
//  DotsConnected
//
//  Created by Wen Shane on 12-12-5.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasView.h"

@interface Line : NSObject
{
    CGPoint mStartPoint;
    CGPoint mEndPoint;
    
    UIColor* mColor;
    CGFloat mWidth;
    
    BOOL mDashed;
    
    CanvasView* mCanvas;
    
}
@property (nonatomic, assign) CGPoint mStartPoint;
@property (nonatomic, assign) CGPoint mEndPoint;
@property (nonatomic, retain) UIColor* mColor;
@property (nonatomic, assign) CGFloat mWidth;
@property (nonatomic, assign) BOOL mDashed;



- (id) initWithStartPoint:(CGPoint)aStartPoint EndPoint:(CGPoint)aEndPoint onCanvas:(CanvasView*)aCanvas;



//set shared properties

+ (void) setSharedLineWidth:(CGFloat)aLineWidth;
+ (CGFloat) getSharedLineWidth;

+(void) setSharedColor: (UIColor*)aColor;
+ (UIColor*) getSharedColor;

@end
