//
//  PlayingCard.m
//  matchismo
//
//  Created by Nadine Hachouche on 8/17/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


- (NSString *)contents
//overwriting getter from parent class
//comes from card.h
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    //rankStrings is a private class method below
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
//we implement setter and getter of suit.. so we have to do
//@synthesize.

+ (NSArray *)validSuits
{
    return @[@"♣︎", @"♥︎",@"♦︎", @"♠︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank
{
    return [[self rankStrings] count] -1;
}


-(void)setSuit:(NSString *)suit
//setter method overright
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
        //call the setter method
    }
}

-(void)setRank:(NSInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (int)match:(NSArray *)otherCards; //override card method
{
    int score;
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank){
            score = 4;
        } else if(otherCard.suit == self.suit){
            score = 1;
        }
    }
    return score;
}

@end
