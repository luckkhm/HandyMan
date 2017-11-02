//
//  DEMOLeftMenuViewController.m
//  RESideMenuStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "MenuViewController.h"
#import "MasterNavigation.h"
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

    
    
    
    titles  = @[NSLocalizedString(@"Feed",nil),NSLocalizedString(@"Explorer",nil), NSLocalizedString(@"Messages",nil), NSLocalizedString(@"Groups",nil), NSLocalizedString(@"Help",nil), NSLocalizedString(@"About",nil),NSLocalizedString(@"Log out",nil)];
    
    
    _imageProfile.layer.cornerRadius = _imageProfile.bounds.size.width/2.0f;
    _imageProfile.layer.masksToBounds = YES;
    [[_imageProfile layer] setBorderWidth:1.0f];
    [[_imageProfile layer] setBorderColor:[UIColor grayColor].CGColor];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
           
            break;
        case 5:
            
            break;
        case 6:{
            UIActionSheet *actionS = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) destructiveButtonTitle:NSLocalizedString(@"Log out",nil) otherButtonTitles: nil];
            
            [actionS showInView:self.view];
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
            [MasterNavigation setRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"]];
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
    
    [self setImageCell:cell atIndexPath:indexPath];
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
-(void)setImageCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"imgFeed"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"imgExplorer"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"imgMessage"];
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"imgGroups"];
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"imgAide"];
            break;
        case 5:
            cell.imageView.image = [UIImage imageNamed:@"imgVille"];
            break;
        case 6:
            cell.imageView.image = [UIImage imageNamed:@"imgLogOut"];
            break;
            
        default:
            break;
    }
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
