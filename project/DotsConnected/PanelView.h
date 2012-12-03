//
//  CanvasView.h
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

//PanelView is composed of background image and canvas.
@interface PanelView : UIView


//aBGImage refers to the background image of the panel.
- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage*)aBGImage;


//tune the properties of dots to be added onto the panel.
- (void) setDotSize:(CGSize)aSize;

- (void) setDotColor: (UIColor*)aColor;

- (void) setDotImage:(UIImage*)aImage;




@end
