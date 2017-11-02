//
//  DEMOLeftMenuViewController.h
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlideMenuDelegate1 <NSObject>
-(void)tagButton:(int)tag;
@end

@interface MenuViewController : UIViewController <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>



@property (weak) id <SlideMenuDelegate1> delegate1;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageProfile;
@property (weak, nonatomic) IBOutlet UILabel *fullName;
@property (weak, nonatomic) IBOutlet UILabel *jobTitle;
- (IBAction)btnMenu:(id)sender;

@end
