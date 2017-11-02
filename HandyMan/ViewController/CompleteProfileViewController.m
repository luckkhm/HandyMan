//
//  CompleteProfileViewController.m
//  HandyMan
//
//  Created by Ahmed Khemiri on 1/28/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import "CompleteProfileViewController.h"
#import "SUtilities.h"

@interface CompleteProfileViewController ()

@end

@implementation CompleteProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnLogIn.layer.cornerRadius =_btnLogIn.frame.size.height/2.0;
    _btnLogIn.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    [self.view addGestureRecognizer:tap];
    _imgProfile.layer.cornerRadius = _imgProfile.bounds.size.width/2.0f;
    _imgProfile.layer.masksToBounds = YES;
}
-(void)dissmissKeyboard{
    [_textFieldEmail resignFirstResponder];
    [_textFieldLastName resignFirstResponder];
    [_textFieldFirstName resignFirstResponder];
    [_textFieldPhoneNumber resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ((textField == _textFieldFirstName && [_textFieldFirstName.text isEqualToString:@"Firstname"])) {
        _textFieldFirstName.text = @"";
    }else
    {
        if ((textField == _textFieldLastName && [_textFieldLastName.text isEqualToString:@"Lastname"])) {
            _textFieldLastName.text = @"";
        }
        else
            if ((textField == _textFieldEmail && [_textFieldEmail.text isEqualToString:@"email@email.email"])) {
                _textFieldEmail.text = @"";
            
            }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _textFieldFirstName && [_textFieldFirstName.text isEqualToString:@""]) {
        _textFieldFirstName.text = @"Firstname";
        
    }else
    {
        if (textField == _textFieldLastName && [_textFieldLastName.text isEqualToString:@""]) {
            _textFieldLastName.text = @"Lastname";
            
        }
        else
            if (textField == _textFieldEmail && [_textFieldEmail.text isEqualToString:@""]) {
                _textFieldEmail.text = @"email@email.email";
                
            }
    }
}

#pragma mark EditPhoto

- (IBAction)btnChoosePhoto:(id)sender {
    [self.view endEditing:YES];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Take Photo With Camera", @"Select Photo From Library", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    actionSheet.destructiveButtonIndex = 2;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self SelectPhotoFromLibraryOrCamera:true];
    }
    else if (buttonIndex == 1)
    {
        [self SelectPhotoFromLibraryOrCamera:false];
    }
    
    else if (buttonIndex == 2)
    {
        NSLog(@"cancel");
    }
}
-(void)SelectPhotoFromLibraryOrCamera:(BOOL)isCamera{
    
    if (isCamera) {
        
        [SUtilities obtainPermissionForMediaSourceType:UIImagePickerControllerSourceTypeCamera withSuccessHandler:^{
            UIImagePickerController *pickerNavController = [[UIImagePickerController alloc] init];
            pickerNavController.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerNavController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            pickerNavController.delegate = self;
            [self presentViewController:pickerNavController animated:YES completion:nil];
        } andFailure:^{
            UIAlertController *alertController= [UIAlertController
                                                 alertControllerWithTitle:nil
                                                 message:NSLocalizedString(@"You have disabled Camera access", nil)
                                                 preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction
                                        actionWithTitle:NSLocalizedString(@"Open Settings", @"Camera access denied: open the settings app to change privacy settings")
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action) {
                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                        }]
             ];
            [alertController addAction:[UIAlertAction
                                        actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                        style:UIAlertActionStyleDefault
                                        handler:NULL]
             ];
            [self presentViewController:alertController animated:YES completion:^{}];
        }];
    }
    else{
        
        [SUtilities obtainPermissionForMediaSourceType:UIImagePickerControllerSourceTypePhotoLibrary withSuccessHandler:^{
            UIImagePickerController *pickerNavController = [[UIImagePickerController alloc] init];
            pickerNavController.delegate = self;
            pickerNavController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:pickerNavController animated:YES completion:nil];
        } andFailure:^{
            UIAlertController *alertController= [UIAlertController
                                                 alertControllerWithTitle:nil
                                                 message:NSLocalizedString(@"You have disabled Photos access", nil)
                                                 preferredStyle:UIAlertControllerStyleActionSheet];
            [alertController addAction:[UIAlertAction
                                        actionWithTitle:NSLocalizedString(@"Open Settings", @"Photos access denied: open the settings app to change privacy settings")
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action) {
                                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                                        }]
             ];
            [alertController addAction:[UIAlertAction
                                        actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                        style:UIAlertActionStyleDefault
                                        handler:NULL]
             ];
            [self presentViewController:alertController animated:YES completion:^{}];
        }];
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        self.imgProfile.image = info[UIImagePickerControllerOriginalImage];
    }];
    
}
- (IBAction)btnLogIn:(id)sender {
}
@end
