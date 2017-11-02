//
//  PinAnnotation.m
//  Bookin'day
//
//  Created by Ahmed Khemiri on 8/27/16.
//  Copyright © 2016 Ahmed Khemiri. All rights reserved.
//

#import "PinAnnotation.h"

@implementation PinAnnotation


- (id)initWithIdHotel:(NSString *)idHotel{
    if (self = [super init]) {
        if([idHotel isKindOfClass:[NSString class]]){
            self.idHotel = idHotel;
        }
    }
    return self;
}

- (NSString *)idHotel{
    return _idHotel;
}

@end
