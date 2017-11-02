//
//  HomeViewController.h
//  HandyMan
//
//  Created by Ahmed Khemiri on 3/27/17.
//  Copyright © 2017 Ahmed Khemiri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "UIMenuViewController.h"

@protocol ProtocolSelectHandy <NSObject>
-(void)ShowHandyDetails:(NSString*)HandyDetails;
@end
@interface HomeViewController : UIMenuViewController<MKMapViewDelegate,CLLocationManagerDelegate,ProtocolSelectHandy>
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnRequest;
@property (weak, nonatomic) IBOutlet MKMapView *map;
- (IBAction)btnSearch:(id)sender;
- (IBAction)btnMenu:(id)sender;
- (IBAction)btnRequest:(id)sender;

@end
