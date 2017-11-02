//
//  PinLocation.m
//  Bookin'day
//
//  Created by Ahmed Khemiri on 8/22/16.
//  Copyright © 2016 Ahmed Khemiri. All rights reserved.
//

#import "PinLocation.h"


@implementation PinLocation

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate{
    if (self = [super init]) {
        if([name isKindOfClass:[NSString class]]){
            self.name = name;
        } else{
            self.name = @"Unknown Charge";
        }
        self.address = address;
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString*)title{
    return _name;
}

- (NSString*)subtitle{
    return _address;
}

- (CLLocationCoordinate2D)coordinate{
    return _coordinate;
}

- (MKMapItem*)mapItem{
    NSDictionary* addressDict = @{
                                  (NSString*) @"street": _address
                                  };
    MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:addressDict];
    
    MKMapItem* mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

+(MKCoordinateRegion) regionForAnnotations:(NSArray*) annotations
{
    NSAssert(annotations!=nil, @"annotations was nil");
    NSAssert([annotations count]!=0, @"annotations was empty");
    
    double minLat=360.0f, maxLat=-360.0f;
    double minLon=360.0f, maxLon=-360.0f;
    
    for (id<MKAnnotation> vu in annotations) {
        if ( vu.coordinate.latitude  < minLat ) minLat = vu.coordinate.latitude;
        if ( vu.coordinate.latitude  > maxLat ) maxLat = vu.coordinate.latitude;
        if ( vu.coordinate.longitude < minLon ) minLon = vu.coordinate.longitude;
        if ( vu.coordinate.longitude > maxLon ) maxLon = vu.coordinate.longitude;
    }
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((minLat+maxLat)/2.0, (minLon+maxLon)/2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(maxLat-minLat, maxLon-minLon);
    MKCoordinateRegion region = MKCoordinateRegionMake (center, span);
    
    return region;
}
@end
