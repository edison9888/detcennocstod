//
//  MainPage.m
//  DotsConnected
//
//  Created by Wen Shane on 12-11-26.
//  Copyright (c) 2012年 Wen Shane. All rights reserved.
//

#import "MainPage.h"
#import "PanelView.h"
#import "Dot.h"

@interface MainPage ()
{
    PanelView* mPanel;  //the panle where we add and connect dots.
    NSInteger mTimesOfDotAndLinePressed;
}
@property (nonatomic, retain) PanelView* mPanel;
@property (nonatomic, assign) NSInteger mTimesOfDotAndLinePressed;

@end

@implementation MainPage
@synthesize mPanel;
@synthesize mTimesOfDotAndLinePressed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mTimesOfDotAndLinePressed = 0;
    }
    return self;
}

- (void) dealloc
{
    self.mPanel = nil;
    
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
    sWidth = 1000;      //width for background image.
    sHeight = 800;      //height for background image.
    
    //create a scroll view, and add a panel into it.
    UIScrollView* sScrollView = [[[UIScrollView alloc] initWithFrame:self.view.bounds] autorelease];
    sScrollView.bounces = NO;
    sScrollView.bouncesZoom = NO;
    self.mPanel = [[[PanelView alloc] initWithFrame:CGRectMake(sX, sY, sWidth, sHeight) backgroundImage:[UIImage imageNamed:@"backgroundA1000x800.png"] Delegate:self] autorelease];
//    [self.mPanel setDotSize:CGSizeMake(20, 20)];
//    [self.mPanel setDotColor:[UIColor blueColor]];
    [self.mPanel setDotImage:[UIImage imageNamed:@"smile24.png"]];
    
    [sScrollView addSubview:self.mPanel];
    sScrollView.contentSize = CGSizeMake(sWidth, sHeight);
    float sWidthRatio = sScrollView.bounds.size.width/self.mPanel.bounds.size.width;
    float sHeightRatio = sScrollView.bounds.size.height/self.mPanel.bounds.size.height;
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
    return self.mPanel;
}


#pragma mark - TouchEventResponderDelegate
//implementations below are for demonstration purpose only.
- (void) dotPressed:(Dot*)aDot
{
    self.mTimesOfDotAndLinePressed++;
    if (aDot)
    {
        NSInteger sRemainder = self.mTimesOfDotAndLinePressed%4;
        switch (sRemainder) {
            case 0:
            {
                [aDot setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"angry24.png"]]];

            }
                break;
            case 1:
            {
                [aDot setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cry24.png"]]];
            }
                break;
            case 2:
            {
              [aDot setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"love24.png"]]];          
            }
                break;
            case 3:
            {
                [aDot setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"smile24.png"]]];                
            }
                break;
                
            default:
                break;
        }
    }
}

- (void) linePressed:(Line*)aLine
{
    self.mTimesOfDotAndLinePressed++;
    if (aLine)
    {
        NSInteger sRemainder = self.mTimesOfDotAndLinePressed%4;
        switch (sRemainder) {
            case 0:
            {
                aLine.mColor = [UIColor grayColor];
            }
                break;
            case 1:
            {
                aLine.mColor = [UIColor blackColor];
            }
                break;
            case 2:
            {
                aLine.mColor = [UIColor redColor];
            }
                break;
            case 3:
            {
                aLine.mColor = [UIColor yellowColor];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
