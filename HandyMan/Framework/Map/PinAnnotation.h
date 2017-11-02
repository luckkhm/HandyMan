//
//  PinAnnotation.h
//  Bookin'day
//
//  Created by Ahmed Khemiri on 8/27/16.
//  Copyright © 2016 Ahmed Khemiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface PinAnnotation : MKPointAnnotation

@property (nonatomic) NSString *idHandy;

- (id)initWithIdHandy:(NSString *)idHandy;
@end
