//
//  MainPage.m
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "MainPage.h"
#import "PanelView.h"

@interface MainPage ()
{
    PanelView* mCanvasView;
}
@property (nonatomic, retain) PanelView* mCanvasView;

@end

@implementation MainPage
@synthesize mCanvasView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) dealloc
{
    self.mCanvasView = nil;
    
    [super dealloc];
}

- (void) loadView
{
    CGRect sFrame = [[UIScreen mainScreen] applicationFrame];
    sFrame.size = CGSizeMake(sFrame.size.width, sFrame.size.height-self.navigationController.navigationBar.bounds.size.height-self.tabBarController.tabBar.bounds.size.height);
    
    UIView* sView = [[UIView alloc] initWithFrame:sFrame];
    self.view = sView;
    [sView release];
    
    CGFloat sX;
    CGFloat sY;
    CGFloat sWidth;
    CGFloat sHeight;
    
    sX = 0;
    sY = 0;
    sWidth = 1000;
    sHeight = 800;
    
    UIScrollView* sScrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    sScrollView.bounces = NO;
    sScrollView.bouncesZoom = NO;
    
    PanelView* sCanvasImageView = [[[PanelView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight) backgroundImage:[UIImage imageNamed:@"canvas1000x800.png"]] autorelease];
    
//    CanvasView* sCanvasImageView = [[[CanvasView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight) backgroundImage:nil] autorelease];

    self.mCanvasView = sCanvasImageView;
    
    [sScrollView addSubview:self.mCanvasView];
    sScrollView.contentSize = CGSizeMake(sWidth, sHeight);
    float sWidthRatio = sScrollView.bounds.size.width/sCanvasImageView.bounds.size.width;
    float sHeightRatio = sScrollView.bounds.size.height/sCanvasImageView.bounds.size.height;
    float sMinZoomScale = (sWidthRatio<sHeightRatio)?sWidthRatio:sHeightRatio;
    [sScrollView setMinimumZoomScale:sMinZoomScale];
    [sScrollView setMaximumZoomScale:1.0];
    [sScrollView setZoomScale:sScrollView.maximumZoomScale];

    sScrollView.delegate = self;
    [self.view addSubview: sScrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.mCanvasView;
}

@end
