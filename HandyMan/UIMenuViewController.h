//
//  UIMenuViewController.h
//  Slide
//
//  Created by Ahmed Khemiri on 8/12/16.
//  Copyright © 2016 Ahmed Khemiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@protocol SlideMenuDelegate <NSObject>
-(void)tagButton:(int)tag;
@end

@interface UIMenuViewController : UIViewController<SlideMenuDelegate1,UIGestureRecognizerDelegate>

@property (weak) id <SlideMenuDelegate> delegate;
@property (nonatomic, strong) MenuViewController *menuViewController;
- (void)movePanelToOriginalPosition;
- (void)movePanelRight;
@end
