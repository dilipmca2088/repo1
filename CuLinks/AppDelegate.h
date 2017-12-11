//
//  AppDelegate.h
//  CuLinks
//
//  Created by DILIP KUMAR on 08/08/17.
//  Copyright © 2017 CuLinks. All rights reserved.


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "IIViewDeckController.h"
#define URLBase "http://culinkservices.com/api/example/"
#define XKEY "5254125635214562bvxcvncvbmnvdvbzg5645454"
#define URLAvatar "http://culinkservices.com/api/example/"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property(nonatomic,retain)NSString* country;
@property(nonatomic,retain)NSString* city;
@property(nonatomic,retain)NSString* devicetoken;
@property(nonatomic,retain)NSString* venderId;
@property(nonatomic,retain)NSString* formId;
@property(nonatomic,retain)NSString* createdDate;

@property(nonatomic,retain)NSString* primaryImg;
@property(nonatomic,retain)NSString* status;
@property(nonatomic,retain)NSString* lati;
@property(nonatomic,retain)NSString* logi;
@property(nonatomic,retain)NSString* checkForm;
@property(nonatomic,retain)NSString* rating;
@property(nonatomic,retain)NSString* welcomeStr;

@property(nonatomic,strong) NSMutableArray* addImageArr;


@property (strong, nonatomic) IIViewDeckController *viewDeckController;
- (NSString *)applicationDocumentsDirectory;
+ (AppDelegate *)appDelegate;
+ (BOOL)validateEmailWithString:(NSString*)email;
-(void)showSideMenu;
- (BOOL)connected;


@end

