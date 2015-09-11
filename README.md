# Gimbal iOS Basic Sample
Minimal Gimbal Integration Example on iOS. After setting up your application, place(s) and communication(s) using the Gimbal Manager the code below will yield **Place Events** and **Local Notifications**.

## Before you create your iOS application
Using the **Gimbal Manager**:
[https://manager.gimbal.com/](https://manager.gimbal.com/)
- create your Gimbal account 
- create an **Application** using bundle ID **com.gimbal.hello-gimbal-ios** (generates you API KEY)
- create at least one **Place** (using a Beacon or Geofence) you can buy Beacons here [http://store.gimbal.com/](http://store.gimbal.com/)
- create at least one **Communicate** (used for the local notification)
- download the latest V2 SDK

## In the sample iOS application
- fill your API KEY into ViewController.m
- add the Gimbal.framework from the SDK zip you downloaded
- to enable Gimbal to operate in the background set your application to **'Uses Bluetooth LE accessories'** background mode 

Full Gimbal Docs [http://docs.gimbal.com/](http://docs.gimbal.com/)

```objective-c
#import "ViewController.h"
#import <Gimbal/Gimbal.h>

@interface ViewController () <GMBLPlaceManagerDelegate>
@property (nonatomic) GMBLPlaceManager *placeManager;
@property (nonatomic) NSMutableArray *placeEvents;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.placeEvents = [NSMutableArray new];
    [Gimbal setAPIKey:@"YOUR_API_KEY_HERE" options:nil];
    
    self.placeManager = [GMBLPlaceManager new];
    self.placeManager.delegate = self;
    [GMBLPlaceManager startMonitoring];
    
    [GMBLCommunicationManager startReceivingCommunications];
}

# pragma mark - Gimbal Place Manager Delegate methods
- (void)placeManager:(GMBLPlaceManager *)manager didBeginVisit:(GMBLVisit *)visit
{
    NSLog(@"Begin %@", [visit.place description]);
    [self.placeEvents insertObject:visit atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)placeManager:(GMBLPlaceManager *)manager didEndVisit:(GMBLVisit *)visit
{
    NSLog(@"End %@", [visit.place description]);
    [self.placeEvents insertObject:visit atIndex:0];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

# pragma mark - Table View methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.placeEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    GMBLVisit *visit = (GMBLVisit*)self.placeEvents[indexPath.row];
    
    if (visit.departureDate == nil)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Begin: %@", visit.place.name];
        cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:visit.arrivalDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithFormat:@"End: %@", visit.place.name];
        cell.detailTextLabel.text = [NSDateFormatter localizedStringFromDate:visit.departureDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    }
    
    return cell;
}


@end

```
