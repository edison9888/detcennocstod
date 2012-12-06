//
//  CanvasView.m
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "PanelView.h"

#import "Dot.h"
#import "CanvasView.h"
#import "TouchEventResponderDelegate.h"



@interface PanelView ()
{
    UIImageView* mBackgroundImage;
//    CanvasView* mCanvas;
 
}
@property (nonatomic, retain) UIImageView* mBackgroundImage;

//@property (nonatomic, retain) CanvasView* mCanvas;
@end


@implementation PanelView
@synthesize mBackgroundImage;
//@synthesize mCanvas;
@synthesize mDelegate;

- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage*)aBGImage Delegate:(id)aDelegate;
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
        CanvasView* sCanvas = [[CanvasView alloc] initWithFrame:frame onPanelView:self ];
        sCanvas.backgroundColor = [UIColor clearColor];
        [self addSubview:sCanvas];
//        self.mCanvas = sCanvas;
        
        [sCanvas release];
        
        self.mDelegate = aDelegate;
    }
    return self;
}


- (void) dealloc
{
    self.mBackgroundImage = nil;
//    self.mCanvas = nil;
    
    [super dealloc];
}

- (void) setDotSize:(CGSize)aSize
{
    [Dot setSharedSize:aSize];
}

- (void) setDotColor: (UIColor*)aColor
{
    [Dot setSharedBGColor:aColor];
}

- (void) setDotImage:(UIImage*)aImage
{
    [Dot setSharedBGImage:aImage];
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
