//
//  PlayingCard.h
//  matchismo
//
//  Created by Nadine Hachouche on 8/17/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *) validSuits;
//people will know what the valid suits are
+ (NSUInteger) maxRank;
//people will know how big our rank is


@end
