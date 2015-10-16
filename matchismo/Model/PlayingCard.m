//
//  PlayingCard.m
//  matchismo
//
//  Created by Nadine Hachouche on 8/17/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface PlayingCard ()

@property (nonatomic, strong) NSMutableArray* matchedCards;

@end

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



- (NSInteger)match:(NSMutableArray *)otherCards; //override card method
{
    NSInteger score;

    if(!(self.matchedCards)) self.matchedCards = [NSMutableArray new];
    
    for (int i = 0; i <= ([otherCards count]-1); i++)
    {
        for (int j= 1; j<= ([otherCards count]-1); j++)
        {
            NSLog(@"%ld in for loop other cards", [otherCards count]);
            if (i != j)
            {
                PlayingCard* firstCard = otherCards[i];
                PlayingCard* secondCard = otherCards[j];
                
                
                if(!([self.matchedCards containsObject:secondCard]))
                {
                    
                    if(firstCard.suit == secondCard.suit)
                    {
                        [self.matchedCards addObject:firstCard];
                        [self.matchedCards addObject:secondCard];
                        
                        
                    } else if(firstCard.rank == secondCard.rank){
                        [self.matchedCards addObject:secondCard];
                        [self.matchedCards addObject:firstCard];
                        
                    }
                }
            }
        }
    }
    
    NSMutableArray* uniqueMatchArray = [self.matchedCards valueForKeyPath:@"@distinctUnionOfObjects.self"];
    
    NSLog(@" %ld TOTAL IN MATCHED CARDS", [uniqueMatchArray count]);
    
    if ([self.matchedCards count] == 0) {
        return 0;
    }
    
    if ([otherCards count] == 3)
    {
        if ([uniqueMatchArray count] == 3) {
            if (([uniqueMatchArray[0]rank] == [uniqueMatchArray[1]rank] && [uniqueMatchArray[1]rank] == [uniqueMatchArray[2]rank]))
            {
                NSLog(@"ranks match return score");
                return 5;
            }
            if (([uniqueMatchArray[0]suit] == [uniqueMatchArray[1]suit] && [uniqueMatchArray[1]suit] == [uniqueMatchArray[2]suit]))
            {
                NSLog(@"SUITS MATCH RETURN SCORE");
                return 3;
                
            }
            
            else if(([uniqueMatchArray[0]rank] == [uniqueMatchArray[1]rank] ||[uniqueMatchArray[1]rank] == [uniqueMatchArray[2]rank] ||
                [uniqueMatchArray[0]rank] ==
                [uniqueMatchArray[2]rank]))
            {
                NSLog(@"WE HAVE 2 MATCHES RANK");
                return 2;
            
            }
            else if(([uniqueMatchArray[0]suit] == [uniqueMatchArray[1]suit] ||[uniqueMatchArray[1]suit] == [uniqueMatchArray[2]suit] ||
                [uniqueMatchArray[0]suit] ==
                [uniqueMatchArray[2]suit]))
            {
                NSLog(@"WE HAVE 2 MATCHES SUIT");
                return 1;
                
            }
            
        }
            else if ([uniqueMatchArray count] == 2) {
                if (([uniqueMatchArray[0]rank] == [uniqueMatchArray[1]rank]))
                {
                    NSLog(@" 2 ranks match return score");
                    return 4;
                }
                
                else if (([uniqueMatchArray[0]suit] == [uniqueMatchArray[1]suit]))
                {
                    NSLog(@" 2 suits match return score");
                    return 1;
                }
        
            }
    }
    
    if ([otherCards count] == 2) {
        
        if (([uniqueMatchArray[0]rank] == [uniqueMatchArray[1]rank]))
        {
            NSLog(@" 2 card game match rank");
            return 4;
        }
        
        else if (([uniqueMatchArray[0]suit] == [uniqueMatchArray[1]suit]))
        {
            NSLog(@"  2 card game match suit");
            return 2;
        }
        
    }
    
    return 1;
}

@end
