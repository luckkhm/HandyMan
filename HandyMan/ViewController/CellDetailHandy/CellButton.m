//
//  CellButton.m
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/28/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import "CellButton.h"

@implementation CellButton

- (void)awakeFromNib {
    [super awakeFromNib];
    _btnCommander.layer.cornerRadius =_btnCommander.frame.size.height/2.0;
    _btnCommander.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
