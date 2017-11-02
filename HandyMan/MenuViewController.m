//
//  DEMOLeftMenuViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "MenuViewController.h"
#import "SecondViewController.h"
#import "Parametres.h"
#import "CardPaymentList.h"
#import "CodePromos.h"
#import "ReservationList.h"
#import "MasterNavigation.h"
#import "MasterUser.h"
#import "AppDelegate.h"

#define DefaultLightFont [UIFont fontWithName:@"Lato-Light" size:16.0]
#define SLIDE_TIMING .25

@interface MenuViewController ()
{
    NSArray *titles;
}

@end

@implementation MenuViewController

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    
    titles  = @[NSLocalizedString(@"New reservation",nil),NSLocalizedString(@"Payment card",nil), NSLocalizedString(@"Reservations",nil), NSLocalizedString(@"My account",nil), NSLocalizedString(@"Help",nil), NSLocalizedString(@"About",nil),NSLocalizedString(@"Log out",nil)];
    
    
    [MasterUser getInfoCustomerWithIdCustomer:[[NSUserDefaults standardUserDefaults]valueForKey:@"customer_id"] didFinish:^(bool succes, NSDictionary *data, NSError *error) {
        if (succes) {
            NSLog(@"customer data %@",data);
            _fullName.text = [NSString stringWithFormat:@"Hello, %@",[data valueForKey:@"customer_firstname"]];

        }
    }];

    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([[appDel.dictForSearch valueForKey:@"country"] isEqualToString:@""] || [appDel.dictForSearch valueForKey:@"country"] == NULL) {
        _jobTitle.text = @"";
    }
    else
        _jobTitle.text = [NSString stringWithFormat:@"You are in %@",[appDel.dictForSearch valueForKey:@"country"]];
    UIImage *chosenImage = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/fileName",[self applicationDocumentsDirectory]]];
    if(!chosenImage){
        
        chosenImage = [UIImage imageNamed:@"ImageProfile"];
    }
     _imageProfile.image = chosenImage;
    _imageProfile.layer.cornerRadius = _imageProfile.bounds.size.width/2.0f;
    _imageProfile.layer.masksToBounds = YES;
    [[_imageProfile layer] setBorderWidth:1.0f];
    [[_imageProfile layer] setBorderColor:[UIColor grayColor].CGColor];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *menuStoryboard = [UIStoryboard storyboardWithName:@"MenuStory" bundle:nil];
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainUI" bundle:nil];
            [MasterNavigation setRootViewController:[storyboard instantiateViewControllerWithIdentifier:@"ReservationType"]];
            
        }
            
            break;
        case 1:
        {
             [MasterNavigation setRootViewController:[menuStoryboard instantiateViewControllerWithIdentifier:@"CardList"]];
            
        }
            
            break;
        case 2:
        {
            [MasterNavigation setRootViewController:[menuStoryboard instantiateViewControllerWithIdentifier:@"ReservationList"]];
            
        }
            break;
        case 3:
        {
            [MasterNavigation setRootViewController:[menuStoryboard instantiateViewControllerWithIdentifier:@"parametre"]];
            
        }
            break;
        case 4:
        {
            
            //[MasterNavigation setRootViewController:[menuStoryboard instantiateViewControllerWithIdentifier:@"parametre"]];
           
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            UIActionSheet *actionS = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) destructiveButtonTitle:NSLocalizedString(@"Log out",nil) otherButtonTitles: nil];
            
            [actionS showInView:self.view];
        }
            break;
        case 7:
        {
            
        }
            break;
        default:
            break;
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [self.tableView reloadData];
        if (buttonIndex == 0) {
            NSLog(@"Log Out");
            NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
            [preferences setValue:@"YES" forKey:@"showLogin"];
            [preferences setValue:@"" forKey:@"customer_id"];
            [preferences synchronize];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"SignInOrSignUp" bundle:nil];
            [MasterNavigation setRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"SignIn"]];
        }
    
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    

    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.font = DefaultLightFont;
    
    
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"       %@", titles[indexPath.row]];
    //cell.textLabel.textAlignment = NSTextAlignmentLeft;
    if (indexPath.row == titles.count -1) {
        cell.textLabel.textColor = [UIColor yellowColor];
        cell.textLabel.highlightedTextColor = [UIColor greenColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
    }
    return cell;
}

- (IBAction)btnMenu:(id)sender {
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.view.frame = CGRectMake(-self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self.delegate1 tagButton:1];
                         }
                     }];
}


@end
