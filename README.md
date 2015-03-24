# Gimbal iOS Basic Sample
Simplest Gimbal Integration Example on iOS. After setting up your application, place(s) and communication(s) on Gimbal Manager the code below will yield **Place Events** and **Local Notifications**.

Before you create your iOS application

- create your Gimbal account 
- create an **Application** (generates you API KEY)
- create at least one **Place** (using a Beacon or Geofence)
- create at least one **Communicate** (used for the local notification)

here:
[https://manager.gimbal.com/](https://manager.gimbal.com/)

Then fill in your API KEY and run the application.

**Note:** This sample uses Gimbal SDK version 2.9.1

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
