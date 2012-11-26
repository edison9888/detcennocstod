//
//  Dot.h
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Dot : UIView


+ (Dot*) getDot;

+ (BOOL) setDotSize:(CGSize)aSize;
+ (CGSize) getDotSize;

@end
