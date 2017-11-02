//
//  DetailHandyViewController.m
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/28/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import "DetailHandyViewController.h"
#import "CellDetailEtoil.h"
#import "CellDetailButton.h"
#import "CellButton.h"
#import "CellDetailHeur.h"

@interface DetailHandyViewController ()
{
    NSMutableArray *arrayHandyMan;
    NSString *serivceSelected;
}
@end

@implementation DetailHandyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgProfile.layer.cornerRadius = _imgProfile.bounds.size.width/2.0f;
    _imgProfile.layer.masksToBounds = YES;
    arrayHandyMan = [NSMutableArray new];
    
    [arrayHandyMan addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"Ahmed Khumeiri",@"fullName",@"30 ans",@"age",@"20 $",@"cout",@"3",@"nombreEtoile",@"1",@"amenagementEtoiles",@"3",@"plomberieEtoiles",@"4",@"serrurierEtoiles",@"2",@"reparationEtoiles",@"plomberie",@"Service",nil]];
    serivceSelected = [[arrayHandyMan objectAtIndex:0] objectForKey:@"Service"];
    _labelFullName.text = [[arrayHandyMan objectAtIndex:0] objectForKey:@"fullName"];
    _labelAge.text = [[arrayHandyMan objectAtIndex:0] objectForKey:@"age"];
    _labelCout.text = [NSString stringWithFormat:@"%@ /heure",[[arrayHandyMan objectAtIndex:0] objectForKey:@"cout"]];
    switch ([[[arrayHandyMan objectAtIndex:0] objectForKey:@"nombreEtoile"] integerValue]) {
        case 0:{
            _imgEtoilRed1.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed2.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed3.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed4.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 1:{
            _imgEtoilRed1.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed2.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed3.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed4.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 2:{
            _imgEtoilRed1.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed2.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed3.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed4.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 3:{
            _imgEtoilRed1.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed2.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed3.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed4.image = [UIImage imageNamed:@"imgEtoileGris"];
            _imgEtoilRed5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 4:{
            _imgEtoilRed1.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed2.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed3.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed4.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 5:{
            _imgEtoilRed1.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed2.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed3.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed4.image = [UIImage imageNamed:@"imgEtoilRed"];
            _imgEtoilRed5.image = [UIImage imageNamed:@"imgEtoilRed"];
        }
            break;
            
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    _imgProfile.layer.cornerRadius = _imgProfile.bounds.size.width/2.0f;
    _imgProfile.layer.masksToBounds = YES;
}

-(void)tagButton:(int)tag{
    _btnMenu.tag = tag;
}
- (IBAction)btnMenu:(id)sender {
    switch (_btnMenu.tag) {
        case 0: {
            [self movePanelToOriginalPosition];
        }
            break;
            
            
        case 1: {
            //self.imageBackground.hidden = NO;
            [self movePanelRight];
        }
            break;
            
        default:
            break;
    }
}

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
        case 6:
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    switch (sectionIndex) {
        case 0:
            return 4;
            break;
        case 1:
            return 4;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 40;
            break;
        default:
            break;
    }
    return 20;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    [headerView setBackgroundColor:[UIColor clearColor]];
    if (section == 1) {
        UILabel *label= [[UILabel alloc] initWithFrame:CGRectMake(20, 25, tableView.bounds.size.width, 20)];
        label.text = @"Sélectionner votre service:";
        label.textColor = [UIColor whiteColor];
        [headerView addSubview:label];
    }
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            static NSString *cellIdentifier = @"CellDetailEtoil";
            
            CellDetailEtoil *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = [[CellDetailEtoil alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
            }
            switch (indexPath.row) {
                case 0:{
                    NSString *nmbrEtoil = [[arrayHandyMan objectAtIndex:0] objectForKey:@"reparationEtoiles"];
                    [self setImageEtoilInCell:cell withType:nmbrEtoil];
                    cell.label.text = @"Travaux de réparation";
                    cell.imgLabel.image = [UIImage imageNamed:@"imgReparation"];
                }
                    break;
                case 1:{
                    NSString *nmbrEtoil = [[arrayHandyMan objectAtIndex:0] objectForKey:@"amenagementEtoiles"];
                    [self setImageEtoilInCell:cell withType:nmbrEtoil];
                    cell.label.text = @"Aide aux déménagements";
                    cell.imgLabel.image = [UIImage imageNamed:@"imgAide"];
                    
                }
                    break;
                case 2:{
                    NSString *nmbrEtoil = [[arrayHandyMan objectAtIndex:0] objectForKey:@"serrurierEtoiles"];
                    [self setImageEtoilInCell:cell withType:nmbrEtoil];
                    cell.label.text = @"Serrurier";
                    cell.imgLabel.image = [UIImage imageNamed:@"imgSerruier"];
                }
                    break;
                case 3:{
                    NSString *nmbrEtoil = [[arrayHandyMan objectAtIndex:0] objectForKey:@"plomberieEtoiles"];
                    [self setImageEtoilInCell:cell withType:nmbrEtoil];
                    cell.label.text = @"Plomberie";
                    cell.imgLabel.image = [UIImage imageNamed:@"imgPlomb"];
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
            break;
        case 1:{
            static NSString *cellIdentifier = @"CellDetailButton";
            
            CellDetailButton *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = [[CellDetailButton alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
            }
            switch (indexPath.row) {
                case 0:{
                    cell.imgLabel.image = [UIImage imageNamed:@"imgReparation"];
                    cell.label.text = @"Travaux de réparation";
                    if ([serivceSelected containsString:@"reparation"]) {
                        cell.imgBoxRed.hidden = NO;
                    }
                    else{
                        cell.imgBoxRed.hidden = YES;
                        [cell.btnBoxRed addTarget:self action:@selector(btnBoxRed:) forControlEvents:UIControlEventTouchUpInside];
                    }
                    
                }
                    break;
                case 1:{
                    cell.imgLabel.image = [UIImage imageNamed:@"imgPlomb"];
                    cell.label.text = @"Aide aux déménagements";
                    if ([serivceSelected containsString:@"aide"]) {
                        cell.imgBoxRed.hidden = NO;
                    }
                    else{
                        cell.imgBoxRed.hidden = YES;
                        [cell.btnBoxRed addTarget:self action:@selector(btnBoxRed:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                    break;
                case 2:{
                    cell.imgLabel.image = [UIImage imageNamed:@"imgSerruier"];
                    cell.label.text = @"Serrurier";
                    if ([serivceSelected containsString:@"serrurier"]) {
                        cell.imgBoxRed.hidden = NO;
                    }
                    else{
                        cell.imgBoxRed.hidden = YES;
                        [cell.btnBoxRed addTarget:self action:@selector(btnBoxRed:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                    break;
                case 3:{
                    cell.imgLabel.image = [UIImage imageNamed:@"imgAide"];
                    cell.label.text = @"Plomberie";
                    if ([serivceSelected containsString:@"plomberie"]) {
                        cell.imgBoxRed.hidden = NO;
                    }
                    else{
                        cell.imgBoxRed.hidden = YES;
                        [cell.btnBoxRed addTarget:self action:@selector(btnBoxRed:) forControlEvents:UIControlEventTouchUpInside];
                    }
                }
                    break;
                    
                default:
                    break;
            }

            return cell;
        }
            break;
        case 2:{
            static NSString *cellIdentifier = @"CellDetailHeur";
            
            CellDetailHeur *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            
            if (cell == nil) {
                cell = [[CellDetailHeur alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                
            }
            return cell;
        }
            break;
        default:
            break;
    }
    static NSString *cellIdentifier = @"CellButton";
    
    CellButton *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[CellButton alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    return cell;
}
-(void)btnBoxRed:(UIButton*)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableViewDetail];
    NSIndexPath *indexPath = [self.tableViewDetail indexPathForRowAtPoint:buttonPosition];
    switch (indexPath.row) {
        case 0:
            serivceSelected = @"reparation";
            break;
        case 1:
            serivceSelected = @"aide";
            break;
        case 2:
            serivceSelected = @"serrurier";
            break;
        case 3:
            serivceSelected = @"plomberie";
            break;
            
        default:
            break;
    }
    [self.tableViewDetail reloadData];
}
-(void)setImageEtoilInCell:(CellDetailEtoil *)cell withType:(NSString *)nmbrEtoil{
    switch (nmbrEtoil.integerValue) {
        case 0:{
            
            cell.imgEtoil1.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil2.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil3.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil4.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 1:{
            cell.imgEtoil1.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil2.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil3.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil4.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 2:{
            cell.imgEtoil1.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil2.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil3.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil4.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 3:{
            cell.imgEtoil1.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil2.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil3.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil4.image = [UIImage imageNamed:@"imgEtoileGris"];
            cell.imgEtoil5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 4:{
            cell.imgEtoil1.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil2.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil3.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil4.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil5.image = [UIImage imageNamed:@"imgEtoileGris"];
        }
            break;
        case 5:{
            cell.imgEtoil1.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil2.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil3.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil4.image = [UIImage imageNamed:@"imgEtoilRed"];
            cell.imgEtoil5.image = [UIImage imageNamed:@"imgEtoilRed"];
        }
            break;
            
        default:
            break;
    }

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
- (IBAction)btnCommander:(id)sender{
    
}
@end
