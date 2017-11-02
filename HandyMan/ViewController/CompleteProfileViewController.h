//
//  CompleteProfileViewController.h
//  HandyMan
//
//  Created by Ahmed Khemiri on 1/28/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompleteProfileViewController : UIViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UITextField *textFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;
- (IBAction)btnChoosePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogIn;
- (IBAction)btnLogIn:(id)sender;

@end
