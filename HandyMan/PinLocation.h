//
//  PinLocation.h
//  Bookin'day
//
//  Created by Ahmed Khemiri on 8/22/16.
//  Copyright © 2016 Ahmed Khemiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PinLocation : NSObject <MKAnnotation>{
    NSString *_name;
    NSString *_address;
    CLLocationCoordinate2D _coordinate;
}

@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* address;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

- (id) initWithName: (NSString *) name address: (NSString *)adress coordinate: (CLLocationCoordinate2D) coordinate;
+(MKCoordinateRegion) regionForAnnotations:(NSArray*) annotations ;
@end
