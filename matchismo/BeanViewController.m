//
//  BeanViewController.m
//  matchismo
//
//  Created by Nadine Hachouche on 11/23/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "BeanViewController.h"
#import "PTDBeanManager.h"


@interface BeanViewController ()<PTDBeanManagerDelegate, PTDBeanDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) PTDBeanManager* beanManager;
@property(nonatomic, strong) PTDBean* bean;
@property(nonatomic, strong) NSMutableArray* beans;

@end


@implementation BeanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(BeanViewController*) sharedBeanViewController
{
    static BeanViewController *sharedBeanViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedBeanViewController = [[BeanViewController alloc] init];
        sharedBeanViewController.beanManager = [[PTDBeanManager alloc]initWithDelegate:sharedBeanViewController];});
    sharedBeanViewController.beans = [[NSMutableArray alloc] init];
    
    NSLog(@"CLASS INSTANTIATED");
    return sharedBeanViewController;
}



#pragma mark - BeanManager Delegate

//call back method.. if state changes, call this method
- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager
{
    // if manager is powered on, start scanning
    
    // checks the bt chip on ie phone ... if it is, poweredon-->
    // start scanning..
    
    if(self.beanManager.state == BeanManagerState_PoweredOn){
        [self.beanManager startScanningForBeans_error:nil];
    }
    else if (self.beanManager.state == BeanManagerState_PoweredOff) {
        NSLog(@"Please check your connection with the Bean and Bluetooth");
    }
}

//automatically called when a bean is discovered
// each time
-(void)beanManager:(PTDBeanManager *)beanManager didDiscoverBean:(PTDBean *)bean error:(NSError *)error
{
    if (error) {
        NSLog(@"THIS IS THE ERROR: %@", error);
        return;
    }
    // if bean is there add to array
    
    if (![self.beans containsObject:bean]) {
        [self.beans addObject:bean];
    }
    
}


//once bean connects, didConnectBean automatically called. async.
-(void)beanManager:(PTDBeanManager *)beanManager didConnectBean:(PTDBean *)bean error:(NSError *)error
{
    if (error){
        NSLog(@"THIS IS THE ERROR: %@", error);
    }
    
    // if bean is connected
    NSLog(@"did connect bean");
    self.bean = bean;
    [bean setLedColor:[UIColor blueColor]];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(disconnectBean) userInfo:nil repeats:NO];
    
    //call own dele. mathod bean controller .. view controller should know that the bean is connected.
}

//finish disconnecting, this method is automaticlaly called.
-(void)beanManager:(PTDBeanManager *)beanManager didDisconnectBean:(PTDBean *)bean error:(NSError *)error
{
    if (error){
        NSLog(@"THIS IS THE ERROR: %@", error);
    }
    //do something after bean is disconnected
    NSLog(@"did disconnect bean");
}

-(void)disconnectBean
{
    NSLog(@"bean is disconnected");
    [self.beanManager disconnectBean:self.bean error:nil];
}


#pragma UITableViewDataSource
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.beans count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* beanIdentifier = @"beanIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:beanIdentifier];
    
    if(!cell)
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:beanIdentifier];
    }
    
    PTDBean* bean = self.beans[indexPath.row];
    cell.detailTextLabel.text = bean.name;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:25];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTDBean* userSelectedBean = self.beans[indexPath.row];
    //connect to bean
    
    [self.beanManager connectToBean:userSelectedBean error:nil];
    [self performSegueWithIdentifier:@"showGameDetail" sender:self];
    
        
    //create a delegate to check if Bean has been shaken
    
    //shuffle deck
}

@end
