//
//  CellDetailHeur.h
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/29/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellDetailHeur : UITableViewCell

- (IBAction)btnMoin:(id)sender;
- (IBAction)btnPlus:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labelResultats;
@property (weak, nonatomic) IBOutlet UILabel *labelHeur;
@property NSString *priceHeur;
@end
