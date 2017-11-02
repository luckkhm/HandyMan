//
//  ViewController.h
//  HandyMan
//
//  Created by Ahmed Khemiri on 1/27/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"

@interface LogInViewController : UIViewController<UIPickerViewDataSource,CountryPickerDelegate>

@property (strong, nonatomic) CountryPicker *pickerView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldCountry;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumbre;
@property (weak, nonatomic) IBOutlet UIButton *btnLogIn;
- (IBAction)btnLogIn:(id)sender;
- (IBAction)btnChooseCountry:(id)sender;
@end

