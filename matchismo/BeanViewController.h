//
//  BeanViewController.h
//  matchismo
//
//  Created by Nadine Hachouche on 11/23/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "PTDBeanManager.h"



@interface BeanViewController : UITableViewController

+(BeanViewController*) sharedBeanViewController;
//- (void)connectToBean:(PTDBean *)bean error:(NSError **)error;

@end
