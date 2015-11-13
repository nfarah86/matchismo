//
//  BeanController.h
//  matchismo
//
//  Created by Nadine Hachouche on 11/11/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeanController : NSObject

+(BeanController*) sharedBeanController;
-(void)connectToBean;

@end
