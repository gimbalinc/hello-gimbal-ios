
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
    
    [Gimbal start];
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
