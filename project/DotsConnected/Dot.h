//
//  Dot.h
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

//Dot is the abstraction of what you added onto the canvas. You can change its size, background color, and background image. And you can add subviews into it with some little modifications as well.
@interface Dot : UIControl

+ (Dot*) getDot;

//set shared properties.
+ (void) setSharedSize:(CGSize)aSize;
+ (CGSize) getSharedSize;

+(void) setSharedBGColor: (UIColor*)aColor;
+ (UIColor*) getSharedBGColor;

+ (void) setSharedBGImage:(UIImage*)aImage;

//set properties for a single dot.
- (void) setSize:(CGSize)aSize;
- (CGSize) getSize;

- (void) setBGColor:(UIColor*)aColor;
-  (UIColor*) getBGColor;

- (void) setBGImage:(UIImage*)aImage;

@end
