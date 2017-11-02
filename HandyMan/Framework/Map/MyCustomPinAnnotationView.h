//
//  MyCustomPinAnnotationView.h
//  MyCustomPinProject
//
//  Created by Thomas Lextrait on 1/4/16.
//  Copyright © 2016 com.tlextrait. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyCustomPointAnnotation.h"
#import "HomeViewController.h"

@protocol ProtocolSelectHandy;
@interface MyCustomPinAnnotationView : MKAnnotationView{
id<ProtocolSelectHandy> delegate;
}

@property (nonatomic) MyCustomPointAnnotation *pointAnnotation;
@property (nonatomic) NSString *labelHandy;
@property (nonatomic,strong) NSString *idHandy;
@property (nonatomic, assign) id<ProtocolSelectHandy> delegate;
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation andidHandy:(NSString *)idHandy;



@end
