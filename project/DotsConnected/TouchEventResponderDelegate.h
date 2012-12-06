//
//  TouchEventDelegate.h
//  DotsConnected
//
//  Created by Wen Shane on 12-12-6.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dot.h"
#import "Line.h"

//use this delegate to define your own event handlar for touch events on dots or lines.
@protocol TouchEventResponderDelegate <NSObject>
@optional

- (void) dotPressed:(Dot*)aDot;
- (void) linePressed:(Line*)aLine;

@end
