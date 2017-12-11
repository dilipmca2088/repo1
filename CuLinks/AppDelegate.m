//
//  AppDelegate.m
//  CuLinks
//
//  Created by DILIP KUMAR on 08/08/17.
//  Copyright © 2017 CuLinks. All rights reserved.

#import "AppDelegate.h"
#import "ViewController.h"
#import "IIViewDeckController.h"
#import "MainViewController.h"
#import "HomeViewCell.h"
#import "HomePageViewController.h"
#import "LoginViewController.h"
#import "Reachability.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     [self start];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    LoginViewController *loginvc =[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:loginvc];
    
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


+ (AppDelegate *)appDelegate
{		// Static accessor
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(void) start
{
    [self getcurrentlatitudeLongitude];
    [_locationManager setDelegate:self];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f)
    {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
}



-(void)getcurrentlatitudeLongitude
{
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    
    if(IS_OS_8_OR_LATER)
    {
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"])
            {
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                //   NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
    
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    //  NSLog(@"didFailWithError: %@", error);
    NSLocale *countryLocale = [NSLocale currentLocale];
    NSString *countryCode = [countryLocale objectForKey:NSLocaleCountryCode];
    [AppDelegate appDelegate].country = [countryLocale displayNameForKey:NSLocaleCountryCode value:countryCode];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //  NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        
       /* [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] forKey:@"LONGITUDE"];
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude] forKey:@"LATITUDE"];*/
        
        
        
        
        [AppDelegate appDelegate].lati=[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
         [AppDelegate appDelegate].logi=[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        
        
        [self.locationManager stopUpdatingHeading];

    }
    
    //  NSLog(@"Location found outer");
    
    self.currentLocation = newLocation;
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:_currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             //             NSLog(@"\nCurrent Location Detected\n");
             //             NSLog(@"placemark %@",placemark);
             
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *City = [[NSString alloc]initWithString:placemark.locality];
             
            // [AppDelegate appDelegate].country=Country;
             //[AppDelegate appDelegate].city=City;
             
             [self.locationManager stopUpdatingHeading];
         }
         else
         {
         }
         
     }];
}
-(void)showSideMenu
{
    
    UINavigationController* lRightUINavigationController = [[UINavigationController alloc] initWithRootViewController:[[HomePageViewController alloc]initWithNibName:@"HomePageViewController" bundle:nil]];
    
    
    UINavigationController* lLeftUINavigationController = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil]];
    
    IIViewDeckController* lIIViewDeckController = [[IIViewDeckController alloc]initWithCenterViewController:lLeftUINavigationController leftViewController:lRightUINavigationController ];
    
    [lIIViewDeckController setLeftLedge:44];
    
    self.viewDeckController = lIIViewDeckController;
    
    self.window.rootViewController = self.viewDeckController;
    [self.window makeKeyAndVisible];
    
    
}
+ (BOOL)validateEmailWithString:(NSString*)email
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}
- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
- (void)registerForPushNotifications
{
    UIApplication *application = [UIApplication sharedApplication];
    //-- Set Notification
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        // iOS 8 Notifications
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [application registerForRemoteNotifications];
    }
    else
    {
        // iOS < 8 Notifications
        [application registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
    }
}

//If registration is successful, APNs returns a device token to the device and iPhone OS passes the token to the application
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //NSLog(@"devToken=%@”",[NSString stringWithFormat:@"devToken=%@",deviceToken]);
    
    NSString* deviceTkn = [[NSString stringWithFormat:@"%@",deviceToken] stringByReplacingOccurrencesOfString:@"<" withString:@""];
    deviceTkn = [deviceTkn stringByReplacingOccurrencesOfString:@">" withString:@""];
    deviceTkn = [deviceTkn stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [AppDelegate appDelegate].devicetoken=deviceTkn;
    NSLog(@"My token final: %@", deviceTkn);
    
}

- (BOOL)connected
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    
    if ([reach isReachable]) {
        NSLog(@"Device is connected to the internet");
        return TRUE;
    }
    else {
        NSLog(@"Device is not connected to the internet");
        return FALSE;
    }
}
@end
