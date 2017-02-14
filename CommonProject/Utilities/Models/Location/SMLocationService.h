//
//  SMLocationService.h
//  App
//
//  Created by 尚美 on 14-5-27.
//  Copyright (c) 2014年 Sunmay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^CompleteBlock_m)(BOOL finished);
@interface SMLocationService : NSObject<CLLocationManagerDelegate,UIAlertViewDelegate>
{
    CLLocationManager * locationManager;
    CLLocationCoordinate2D curLocation;
    CompleteBlock_m completeBlock_;
}
@property(nonatomic,assign)CLLocationCoordinate2D curLocation;
- (void)getCurPosition:(CompleteBlock_m)completeBlock;
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
