//
//  SearchViewController.h
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/28/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
- (IBAction)btnClose:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnReparation;
@property (weak, nonatomic) IBOutlet UIButton *btnAideDem;

- (IBAction)btnReparation:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnPlomberie;
@property (weak, nonatomic) IBOutlet UIButton *btnSerrurier;
- (IBAction)btnAideDem:(id)sender;
- (IBAction)btnSerrurier:(id)sender;
- (IBAction)btnPlomberie:(id)sender;
@end
