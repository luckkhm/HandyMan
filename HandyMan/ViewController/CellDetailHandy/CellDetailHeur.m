//
//  CellDetailHeur.m
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/29/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import "CellDetailHeur.h"

@implementation CellDetailHeur

- (void)awakeFromNib {
    [super awakeFromNib];
    _priceHeur = @"15";
    _labelResultats.text = [NSString stringWithFormat:@"%@ $",_priceHeur];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnMoin:(id)sender {
    if ([_labelHeur.text intValue] > 1) {
        int x = [_priceHeur intValue];
        int y = [_labelResultats.text intValue];
        _labelResultats.text = [NSString stringWithFormat:@"%d $",y - x];
        _labelHeur.text = [NSString stringWithFormat:@"%d",[_labelHeur.text intValue] - 1];
    }
    
}
- (IBAction)btnPlus:(id)sender{
    int x = [_priceHeur intValue];
    int y = [_labelResultats.text intValue];
    _labelResultats.text = [NSString stringWithFormat:@"%d $",x + y];
    _labelHeur.text = [NSString stringWithFormat:@"%d",[_labelHeur.text intValue] + 1];
}
@end
