//
//  UIMenuViewController.m
//  Slide
//
//  Created by Ahmed Khemiri on 8/12/16.
//  Copyright © 2016 Ahmed Khemiri. All rights reserved.
//

#import "UIMenuViewController.h"

#define SLIDE_TIMING .25
#define PANEL_WIDTH 80

@interface UIMenuViewController ()
{
    UIViewController *dst;
}
@property (nonatomic, assign) BOOL showingLeftPanel;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;
@end

@implementation UIMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *pan = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    
    pan.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view  addGestureRecognizer:pan];
    UISwipeGestureRecognizer * pan1=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    pan1.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:pan1];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{   CGPoint point = [touch locationInView:gestureRecognizer.view];
    if (point.x < 25.0 ) {
        return YES;
    } else {
        if (_showingLeftPanel && point.x > self.view.frame.size.width - PANEL_WIDTH ) {
            return YES;
        }
        return NO;
    }
    return YES;
}


-(void)handleSwipeGesture:(UISwipeGestureRecognizer *) sender
{
    CGPoint touchLocation = [sender locationInView:self.view];
    if(sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        if (touchLocation.x < 25.0) {
            [self movePanelRight];
        }
    }
    else if(sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        if (_showingLeftPanel && touchLocation.x > self.view.frame.size.width - PANEL_WIDTH  ) {
            [self movePanelToOriginalPosition];
        }
    }
}
-(void)tagButton:(int)tag{
    
    [self.delegate tagButton:tag];
}

-(void)gestureRecognizedOpen:(UIPanGestureRecognizer*)sender {
    

    
    
//    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
//    CGSize thisSize = sender.view.frame.size;
//    NSLog(@"velocity.x %f %f %c",velocity.x, velocity.y ,_showPanel);
//    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
//        if(velocity.y > 0 && velocity.y < 20.0 ) {
//            [self movePanelRight];
//        }
//    }
//    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
//        if(velocity.y > 0 && velocity.y < 20.0 ) {
//           
//            [self movePanelRight];
//        }
//        if(velocity.x < 0  ) {
//            NSLog(@"mobega");
//            [self movePanelToOriginalPosition];
//        }
//    }
//    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
//        if(velocity.y > 0 && velocity.y < 20.0 ) {
//            
//            [self movePanelRight];
//        }
//    }
    
}
-(void)gestureRecognized:(UIPanGestureRecognizer*)sender {
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
            if (!_showingLeftPanel) {
                childView = [self getLeftView];
            }
        }
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        
        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            if (_showingLeftPanel) {
                [self movePanelRight];
            }
        }
    }
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        
        _showPanel = fabs([sender view].center.x - self.view.frame.size.width/2) > self.view.frame.size.width/2;
        
        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];
        
        if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
            //             NSLog(@"same direction");
        } else {
            //             NSLog(@"opposite direction");
        }
        
        _preVelocity = velocity;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)movePanelRight{
    
    [self getLeftView];
    
    [UIView animateWithDuration:0.3 animations:^{
        [dst.view setFrame:CGRectMake(- PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.showingLeftPanel = YES;
        [self.delegate tagButton:0];
    }];
    
}
- (void)movePanelToOriginalPosition{
    _showingLeftPanel = NO;
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         dst.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self.delegate tagButton:1];
                         }
                     }];
    
//    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//                     }
//                     completion:^(BOOL finished) {
//                         if (finished) {
//                             [self.delegate tagButton:1];
//                         }
//                     }];
}
- (UIView *)getLeftView{

    if (_menuViewController == nil)
    {
        _menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];
        _menuViewController.delegate1 = self;
        dst = (UIViewController *) self.menuViewController;
        [dst.view setFrame:CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        [self addChildViewController:dst];
        [self.view addSubview:dst.view];
        [dst didMoveToParentViewController:self];
    }
    
    
    [self showCenterViewWithShadow:YES withOffset:2];
    return dst.view;
    
}
- (void)showCenterViewWithShadow:(BOOL)value withOffset:(CGFloat) offset {
    if (value)
    {
        [self.view.layer setCornerRadius:4];
        [self.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.view.layer setShadowOpacity:0.8];
        [self.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    }
    else
    {
        [self.view.layer setCornerRadius:0.0f];
        [self.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

@end
