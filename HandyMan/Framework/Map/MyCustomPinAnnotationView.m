//
//  MyCustomPinAnnotationView.m
//  MyCustomPinProject
//
//  Created by Thomas Lextrait on 1/4/16.
//  Copyright © 2016 com.tlextrait. All rights reserved.
//

#import "MyCustomPinAnnotationView.h"

@implementation MyCustomPinAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation andidHandy:(NSString *)idHandy
{
    // The re-use identifier is always nil because these custom pins may be visually different from one another
    self = [super initWithAnnotation:annotation
                     reuseIdentifier:nil];
    
    // Fetch all necessary data from the point object
    _pointAnnotation = (MyCustomPointAnnotation*) annotation;
    
        self.idHandy = idHandy;
        NSLog(@"self.idHandy %@",self.idHandy);
        _pointAnnotation.idHandy = idHandy;
    
    
    // Callout settings - if you want a callout bubble
    self.canShowCallout = NO;
  
    self.image = [UIImage imageNamed:@"myPinImage"];

    UIView*customview = [[UIView alloc] initWithFrame:CGRectMake(-100, -80, 200, 50)];
    customview.backgroundColor = [UIColor blackColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    [btn addTarget:self action:@selector(clicktoshow) forControlEvents:UIControlEventTouchUpInside];
    // Hotel Nom
    UILabel *labelHandy = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 180, 21)];
    labelHandy.text = [annotation title];
    labelHandy.textAlignment = NSTextAlignmentCenter;
    labelHandy.adjustsFontSizeToFitWidth = YES;
    labelHandy.textColor = [UIColor whiteColor];
    [customview addSubview:labelHandy];
    
    // Hotel adress
    UILabel *labelHandyAdress = [[UILabel alloc]initWithFrame:CGRectMake(8, 25, 194, 21)];
    labelHandyAdress.text = [annotation subtitle];
    labelHandyAdress.adjustsFontSizeToFitWidth = YES;
    labelHandyAdress.textColor = [UIColor grayColor];
    [customview addSubview:labelHandyAdress];
    
    // Hotel Image
//    UIImageView *imageHotel = [[UIImageView alloc]initWithFrame:CGRectMake(160, 4, 21, 21)];
//    imageHotel.image =[UIImage imageNamed:@"StarYellow"];
//    [customview addSubview:imageHotel];
    
    UIImageView *imageFleche = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -30, 20, 10)];
    imageFleche.image = [UIImage imageNamed:@"flesh"];
    [self addSubview:imageFleche];
    
    [customview addSubview:btn];
    customview.layer.cornerRadius = 5;
    customview.layer.masksToBounds = YES;

    [self addSubview:customview];
    return self;
}

- (NSString *)idHandy{
    return _idHandy;
}

-(void)clicktoshow{
    [self.delegate ShowHandyDetails:self.pointAnnotation.idHandy];
}



- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    UIView* hitView = [super hitTest:point withEvent:event];
    if (hitView != nil)
    {
        [self.superview bringSubviewToFront:self];
    }
    return hitView;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect rect = self.bounds;
    BOOL isInside = CGRectContainsPoint(rect, point);
    if(!isInside)
    {
        for (UIView *view in self.subviews)
        {
            isInside = CGRectContainsPoint(view.frame, point);
            if(isInside)
                break;
        }
    }
    return isInside;
}
@end
