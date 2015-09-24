//
//  Card.h
//  matchismo
//
//  Created by Nadine Hachouche on 8/15/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
//setter and getter methods are available: _contents
//can't see it.

@property (nonatomic, assign, getter=isChosen) BOOL chosen;
@property (nonatomic, assign, getter=isMatched) BOOL matched;
//getter and setter methods for these are already assigned.
//we renamed the getter method to ie isChosen, because it's easier to read
//setter method is -(void)setChosen:(BOOL)chosen
//getter method is: (BOOL)isChosen

- (int)match:(NSArray *)otherCards;
//tell whether two cards matched

@end