//
//  ViewController.m
//  HandyMan
//
//  Created by Ahmed Khemiri on 1/27/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import "LogInViewController.h"
#import "SUtilities.h"

@interface LogInViewController ()
{
    RMPhoneFormat *_phoneFormat;
    NSString *code;
    NSString *country;
    NSString *zero;
    NSString *zeroNational;
    NSString *phone;
    NSString *prefix;
}
@property (nonatomic, retain) UIToolbar *keyboardToolbar;
@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    zero = @"";
    CTTelephonyNetworkInfo *network_Info = [CTTelephonyNetworkInfo new];
    CTCarrier *carrier = network_Info.subscriberCellularProvider;
    
    if (carrier.countryCallingCode == NULL) {
        code = @"us";
        country = @"United States";
        prefix = @"+1";
    }
    else {
        country = carrier.countryCalling[0];
        code = [carrier.isoCountryCode lowercaseString];
        prefix = carrier.countryCallingCode;
    }
    self.textFieldCountry.text = country;
    [self setupFormatter];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChangePhone:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.textFieldPhoneNumbre];
    _btnLogIn.layer.cornerRadius =_btnLogIn.frame.size.height/2.0;
    _btnLogIn.layer.masksToBounds = YES;
    
    
    self.pickerView = [[CountryPicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width,200) ];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.countryName = country;
    self.pickerView.delegate =self;
    self.pickerView.dataSource = self;
    _keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-244, 320, 44)] ;
    [_keyboardToolbar setBarStyle:UIBarStyleDefault];
    [_keyboardToolbar sizeToFit];
    [_keyboardToolbar setBackgroundColor:self.pickerView.backgroundColor];
    [_keyboardToolbar setTintColor:[UIColor blackColor]];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneButton1 =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(donePicker)];
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton,doneButton1, nil];
    
    [_keyboardToolbar setItems:itemsArray];
    
    [self.view addSubview:_keyboardToolbar];
    [UIView commitAnimations];
    [_keyboardToolbar removeFromSuperview];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)donePicker{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnLogIn:(id)sender {
}

- (IBAction)btnChooseCountry:(id)sender {
    [self.view endEditing:YES];
    [self.pickerView removeFromSuperview];
    [_keyboardToolbar removeFromSuperview];
    [self.view addSubview:_keyboardToolbar];
    [self.view addSubview:self.pickerView];
}

#pragma mark pickerCountry

- (void)setupFormatter {
    _phoneFormat = [[RMPhoneFormat alloc] initWithDefaultCountry:code];
}
- (void)textFieldDidChangePhone:(id)sender {
    [self localeChanged];
}
- (void)localeChanged {
    [self setupFormatter];
    
    // Reformat the current phone number
    if (_textFieldPhoneNumbre) {
        NSString *text = _textFieldPhoneNumbre.text;
        NSString *phoneN = [_phoneFormat format:text];
        if ([code isEqualToString:@"fr"]) {
            zeroNational = @"0";
            if ([text length] == 1) {
                if ([text isEqualToString:@"0"]) {
                    zero = @"(0)";
                    phoneN = @"";
                }
                else {
                    zero = @"(0)";
                }
            }
            if ([text length] == 3) {
                phoneN = @"";
            }
            if ([text length] > 3) {
                
                text = [text substringFromIndex:3];
                phoneN = [_phoneFormat format:[NSString stringWithFormat:@"0%@",text]];
                phoneN = [phoneN substringFromIndex:1];
                zero = @"(0)";
            }
        }
        else{
            zeroNational = @"";
        }
        
        _textFieldPhoneNumbre.text = [NSString stringWithFormat:@"%@%@",zero,phoneN];
        phone = phoneN;
        zero = @"";
        //_phoneNumber.text = phone;
        if ([_phoneFormat isPhoneNumberValid:_textFieldPhoneNumbre.text]) {
            self.navigationItem.rightBarButtonItem = nil;
        }
        else
            self.navigationItem.rightBarButtonItem = nil;
    }
    else
        _textFieldPhoneNumbre.text = @"";
    
    if ([_textFieldPhoneNumbre.text isEqualToString:@""]) {
        _textFieldPhoneNumbre.text = @"Phone Number";
    }
    
}
-(void)dissmissKeyboard{
    [_textFieldPhoneNumbre resignFirstResponder];
    [self.pickerView removeFromSuperview];
    [_keyboardToolbar removeFromSuperview];
}
- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code1 phone:(NSString *)phones {
    prefix = phones;
    country = name;
    _textFieldCountry.text = country;
    code = [code1 lowercaseString];
    if ([code isEqualToString:@"fr"] && ![_textFieldPhoneNumbre.text isEqualToString:@"Phone Number"]) {
        _textFieldPhoneNumbre.text = [NSString stringWithFormat:@"(0)%@",_textFieldPhoneNumbre.text];
    }
    [self localeChanged];
}
@end
