//
//  ViewController.h
//  matchismo
//
//  Created by Nadine Hachouche on 8/15/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTDBeanManager.h"


@interface ViewController : UIViewController<PTDBeanDelegate>

@property(nonatomic, strong) PTDBean* bean; 

@end

