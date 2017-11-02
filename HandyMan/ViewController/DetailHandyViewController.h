//
//  DetailHandyViewController.h
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/28/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIMenuViewController.h"

@interface DetailHandyViewController : UIMenuViewController

@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
- (IBAction)btnMenu:(id)sender;
- (IBAction)btnCommander:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableViewDetail;
@property (weak, nonatomic) IBOutlet UILabel *labelAge;
@property (weak, nonatomic) IBOutlet UILabel *labelFullName;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *labelCout;
@property (weak, nonatomic) IBOutlet UIImageView *imgEtoilRed5;
@property (weak, nonatomic) IBOutlet UIImageView *imgEtoilRed4;
@property (weak, nonatomic) IBOutlet UIImageView *imgEtoilRed3;
@property (weak, nonatomic) IBOutlet UIImageView *imgEtoilRed2;
@property (weak, nonatomic) IBOutlet UIImageView *imgEtoilRed1;
@end
