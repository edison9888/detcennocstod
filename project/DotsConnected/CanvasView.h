//
//  CanvasView.h
//  DotsConnected
//
//  Created by Wen Shane on 12-12-3.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PanelView.h"

//CanvasView is the place where you add dots and lines between them.
@interface CanvasView : UIView

- (void) refreshCanvas;
- (id) initWithFrame:(CGRect)frame onPanelView:(PanelView*)aPanel;

@end
