//
//  BeanController.m
//  matchismo
//
//  Created by Nadine Hachouche on 11/11/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "PTDBeanManager.h"
#import "BeanController.h"

@interface BeanController ()<PTDBeanManagerDelegate, PTDBeanDelegate>
@property(nonatomic, strong) PTDBeanManager* beanManager;
@property(nonatomic, strong) PTDBean* bean;
@property(nonatomic, strong) NSMutableArray* beans;

@end


@implementation BeanController

+(BeanController*) sharedBeanController
{
    static BeanController *sharedBeanController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ sharedBeanController = [[BeanController alloc] init];
        sharedBeanController.beanManager = [[PTDBeanManager alloc]initWithDelegate:sharedBeanController];});
    
    
    return sharedBeanController;
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
    // if bean is there, connect directly
    if ([bean.name isEqualToString:@"BeanCheese"]) {
        NSLog(@"did discover bean");
        //connect to Bean
        [beanManager connectToBean:bean error:nil];
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


@end
