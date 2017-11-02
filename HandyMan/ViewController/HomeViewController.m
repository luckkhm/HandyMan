//
//  HomeViewController.m
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/27/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "PinAnnotation.h"
#import "PinLocation.h"
#import "MyCustomPinAnnotationView.h"
#import "SUtilities.h"

@interface HomeViewController ()
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    int succ;
    NSString *lat;
    NSString *lng;
    NSMutableArray *resultats;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    succ = 0;
    _btnRequest.layer.cornerRadius =_btnRequest.frame.size.height/2.0;
    _btnRequest.layer.masksToBounds = YES;
    self.map.delegate = self;
    for (id<MKAnnotation> annotation in _map.annotations) {
        [_map removeAnnotation:annotation];
        
    }
    resultats = [NSMutableArray new];
    [resultats addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"idHandyMan",@"Ahmed khemiri",@"handy_name",@"Rue du Lac Léman, Tunis, Tunisia",@"handy_address",@"36.7948829",@"handy_lat",@"10.1432776",@"handy_lng",nil]];
    [resultats addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"idHandyMan",@"Ahmed khemiri",@"handy_name",@"Rue du Lac Léman, Tunis, Tunisia",@"handy_address",@"36.8027223",@"handy_lat",@"10.1448653",@"handy_lng",nil]];
    [self getHandyMan];
    [self currentLocationIdentifier];
}
-(void)tagButton:(int)tag{
    _btnMenu.tag = tag;
}
-(void)getHandyMan{
    NSMutableArray *arrAnnotations  = [[NSMutableArray alloc]init];
    if ([resultats count] == 1) {
        NSDictionary *hotel = [resultats objectAtIndex:0];
        PinAnnotation *myAnnotation = [[PinAnnotation alloc] initWithIdHandy:hotel[@"idHandyMan"]];
        lat = hotel[@"handy_lat"];
        lng = hotel[@"handy_lng"];
        myAnnotation.coordinate = CLLocationCoordinate2DMake(lat.floatValue,lng.floatValue);
        myAnnotation.title = hotel[@"handy_name"];
        myAnnotation.subtitle = hotel[@"handy_address"];
        [arrAnnotations addObject:myAnnotation];
        MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(myAnnotation.coordinate, 1500.0, 1500.0);
        [_map setRegion:userLocation animated:YES];
        [_map addAnnotation:myAnnotation];
    }
    else{
        for (NSDictionary *hotel in resultats) {
            PinAnnotation *myAnnotation = [[PinAnnotation alloc] initWithIdHandy:hotel[@"idHandyMan"]];
            lat = hotel[@"handy_lat"];
            lng = hotel[@"handy_lng"];
            myAnnotation.coordinate = CLLocationCoordinate2DMake(lat.floatValue,lng.floatValue);
            myAnnotation.title = hotel[@"handy_name"];
            myAnnotation.subtitle = hotel[@"handy_address"];
            [arrAnnotations addObject:myAnnotation];
        }
        
        [_map addAnnotations:arrAnnotations];
        _map.region = [PinLocation regionForAnnotations:arrAnnotations];
    }

}
-(void)currentLocationIdentifier {
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc]init];
        locationManager.delegate = self;
        
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
    }
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    CLLocationCoordinate2D coord;
    coord.longitude = currentLocation.coordinate.longitude;
    coord.latitude = currentLocation.coordinate.latitude;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            succ ++;
            if (succ == 1) {
                
                CLPlacemark *placemark = [placemarks lastObject];
                NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                NSString *Address = [[NSString alloc]initWithString:locatedAt];
                NSLog(@"Address %@",Address);
                self.map.showsUserLocation = YES;
//                PinLocation *annotation = [[PinLocation alloc] initWithName:@"me" address:@"tunis" coordinate:currentLocation.coordinate] ;
//                [_map addAnnotation:annotation];
//                NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
//                [standardUserDefaults setObject:Address forKey:@"LocalAdress"];
//                NSNumber *latitude = [NSNumber numberWithDouble:currentLocation.coordinate.latitude];
//                NSNumber *longitude = [NSNumber numberWithDouble:currentLocation.coordinate.longitude];
//                
//                [standardUserDefaults setObject:latitude forKey:@"LocalLat"];
//                [standardUserDefaults setObject:longitude forKey:@"LocalLongitude"];
//                [standardUserDefaults synchronize];
            }
        }
    }];
    
}
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(PinAnnotation *)annotation {
    
    if([annotation isKindOfClass:[MyCustomPointAnnotation class]]){
        MyCustomPinAnnotationView* pin = [[MyCustomPinAnnotationView alloc] initWithAnnotation:annotation andidHandy:annotation.idHandy];
        
        
        
        [pin setDelegate:self];
        return pin;
    }
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MyCustomPinAnnotationView *pinView = (MyCustomPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            pinView = [[MyCustomPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = NO;
            pinView.image = [UIImage imageNamed:@"imgPins"];
            pinView.idHandy = annotation.idHandy;
        } else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MyCustomPinAnnotationView *)view
{
    for (MyCustomPointAnnotation *pin in _map.annotations) {
        
        
        if ([pin isKindOfClass:[MyCustomPointAnnotation class  ]]) {
            [_map removeAnnotation:pin];
        }
        
    }
    if ([view isKindOfClass:[MyCustomPinAnnotationView class]]) {
        
        MyCustomPointAnnotation* pin = [MyCustomPointAnnotation alloc];
        pin.coordinate = [view.annotation coordinate];
        
        pin.title = [view.annotation title];
        pin.subtitle = [view.annotation subtitle];
        pin.idHandy = view.idHandy;
        [mapView addAnnotation:pin];
        
        
    }
    
    
}
-(void)ShowHandyDetails:(NSString*)HandyDetails{
    
    [SUtilities showLoading:self.view];
    
}

-(void)removeAnnotation{
    id userLocation = [_map userLocation];
    
    
    if ( userLocation != nil ) {
        self.map.showsUserLocation = YES;
        [_map addAnnotation:userLocation]; // will cause user location pin to blink
    }
}

- (IBAction)btnRemove:(id)sender {
    [self removeAnnotation];
}
- (IBAction)btnSearch:(id)sender {
    SearchViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [searchVC setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [searchVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [searchVC.navigationController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:searchVC animated:YES completion:nil];
}

- (IBAction)btnMenu:(id)sender {
    switch (_btnMenu.tag) {
        case 0: {
            [self movePanelToOriginalPosition];
        }
            break;
            
            
        case 1: {
            //self.imageBackground.hidden = NO;
            [self movePanelRight];
        }
            break;
            
        default:
            break;
    }
}
- (IBAction)btnRequest:(id)sender {
}
@end
