//
//  PinAnnotation.m
//  Bookin'day
//
//  Created by Ahmed Khemiri on 8/27/16.
//  Copyright © 2016 Ahmed Khemiri. All rights reserved.
//

#import "PinAnnotation.h"

@implementation PinAnnotation


- (id)initWithIdHandy:(NSString *)idHandy{
    if (self = [super init]) {
        if([idHandy isKindOfClass:[NSString class]]){
            self.idHandy = idHandy;
        }
    }
    return self;
}

- (NSString *)idHandy{
    return _idHandy;
}

@end
