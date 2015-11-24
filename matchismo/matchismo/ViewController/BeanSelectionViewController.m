//
//  BeanSelectionViewController.m
//  matchismo
//
//  Created by Nadine Hachouche on 11/9/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "PTDBeanManager.h"
#import "BeanSelectionViewController.h"

@interface BeanSelectionViewController ()<PTDBeanManagerDelegate, PTDBeanDelegate>
@property(nonatomic, strong) PTDBeanManager* beanManager;
@property(nonatomic, strong) PTDBean* bean;
@property(nonatomic, strong) NSMutableArray* beans;

@end

@implementation BeanSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.beanManager = [[PTDBeanManager alloc]initWithDelegate:self];
    // Do any additional setup after loading the view.
}


- (void)beanManagerDidUpdateState:(PTDBeanManager *)manager
{
    // if manager is powered on, start scanning
    if(self.beanManager.state == BeanManagerState_PoweredOn){
        [self.beanManager startScanningForBeans_error:nil];
    }
    else if (self.beanManager.state == BeanManagerState_PoweredOff) {
        NSLog(@"Please check your connection with the Bean and Bluetooth");
    }
}

-(void)beanManager:(PTDBeanManager *)beanManager didDiscoverBean:(PTDBean *)bean error:(NSError *)error
{
    NSLog(@"did discover bean");
}
-(void)beanManager:(PTDBeanManager *)beanManager didConnectBean:(PTDBean *)bean error:(NSError *)error
{
    NSLog(@"did connect bean");
}
-(void)beanManager:(PTDBeanManager *)beanManager didDisconnectBean:(PTDBean *)bean error:(NSError *)error
{
    NSLog(@"did disconnect bean");
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
