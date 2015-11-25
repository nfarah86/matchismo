//
//  BeanViewController.m
//  matchismo
//
//  Created by Nadine Hachouche on 11/23/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "BeanViewController.h"
#import "PTDBeanManager.h"
#import "ViewController.h"


@interface BeanViewController ()<PTDBeanManagerDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong) PTDBeanManager* beanManager;
@property(nonatomic, strong) PTDBean* bean;
@property(nonatomic, strong) NSMutableArray* beans;

@end


@implementation BeanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.beans = [[NSMutableArray alloc] init];
    self.beanManager = [[PTDBeanManager alloc]initWithDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    if (![self.beans containsObject:bean]) {
        [self.beans addObject:bean];
        NSLog(@" %ld BEAN LENGTH", [self.beans count]);
    }
    
        [self.tableView reloadData];

    
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
    [self performSegueWithIdentifier:@"showGameDetail" sender:self];

   // [bean setLedColor:[UIColor blueColor]];
    //[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(disconnectBean) userInfo:nil repeats:NO];
    
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController* viewController = segue.destinationViewController;
    viewController.bean = self.bean; 
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
    NSLog(@"%ld BEANNS lengtttth", [self.beans count]);
    //return 1;
    return [self.beans count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* beanIdentifier = @"beanIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:beanIdentifier];
    NSLog(@"%@ cell", cell);
    
    if(!cell)
    {
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:beanIdentifier];
    }
    
    PTDBean* beanAtIndex = [self.beans objectAtIndex:indexPath.row];
    //cell.textLabel.text = @"nadine";
    cell.textLabel.text = beanAtIndex.name;
    NSLog(@"%@ this is bean", beanAtIndex.name);
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PTDBean* userSelectedBean = self.beans[indexPath.row];
    //connect to bean
    
    [self.beanManager connectToBean:userSelectedBean error:nil];
    
    
        
    //create a delegate to check if Bean has been shaken
    
    //shuffle deck
}

@end
