# Gimbal iOS Basic Sample
Minimal Gimbal Integration Example on iOS. After setting up your application, place(s) and communication(s) using the Gimbal Manager the code below will yield **Place Events** and **Local Notifications**.

## Before you create your iOS application
Using the **Gimbal Manager**:
[https://manager.gimbal.com/](https://manager.gimbal.com/)
- create your Gimbal account 
- create an **Application** using bundle ID **com.gimbal.hello-gimbal-ios** (generates you API KEY)
- create at least one **Place** (using a Beacon or Geofence)
- create at least one **Communicate** (used for the local notification)
- download the SDK (this sample uses **version 2.9**)

## In the sample iOS application
- fill your API KEY into the AppDelegate
- add the Gimbal.framework from the SDK zip you downloaded
- to enable Gimbal to operate in the background set your application to **'Uses Bluetooth LE accessories'** background mode 

**When you run this sample you will see the Place Events in the log**

Full Gimbal Docs [https://gimbal.com/docs](https://gimbal.com/docs)

```objective-c
#import <Gimbal/Gimbal.h>
#import "AppDelegate.h"

@interface AppDelegate () <GMBLPlaceManagerDelegate>
@property (nonatomic) GMBLPlaceManager *placeManager;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self localNotificationPermission];
    
    [Gimbal setAPIKey:@"YOUR_API_KEY_HERE" options:nil];
    
    self.placeManager = [GMBLPlaceManager new];
    self.placeManager.delegate = self;
    [GMBLPlaceManager startMonitoring];
    
    [GMBLCommunicationManager startReceivingCommunications];
    
    return YES;
}

# pragma mark - Gimbal Place Manager Delegate methods

- (void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit
{
    NSLog(@"Begin %@", [visit.place description]);
}

- (void)placeManager:(GMBLPlaceManager *)manager didEndVisit:(GMBLVisit *)visit
{
    NSLog(@"End %@", [visit.place description]);
}

# pragma mark - Local Notification Permission

- (void)localNotificationPermission {
    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

@end

```
