//
//  MyCustomPinAnnotationView.h
//  MyCustomPinProject
//
//  Created by Thomas Lextrait on 1/4/16.
//  Copyright © 2016 com.tlextrait. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyCustomPointAnnotation.h"
#import "ResultSearch.h"
#import "MyCustomPointAnnotation.h"
@protocol ProtocolSelectHotel;
@interface MyCustomPinAnnotationView : MKAnnotationView{
id<ProtocolSelectHotel> delegate;
}

@property (nonatomic) MyCustomPointAnnotation *pointAnnotation;
@property (nonatomic) NSString *labelHotel;
@property (nonatomic,strong) NSString *idHotel;
@property (nonatomic, assign) id<ProtocolSelectHotel> delegate;
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation andidHotel:(NSString *)idHotel;



@end
