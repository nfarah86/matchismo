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
        for (int j= 0; j<= ([otherCards count]-1); j++)
        {
            NSLog(@"%ld in for loop other cards", [otherCards count]);
            if (i != j)
            {
                PlayingCard* firstCard = otherCards[i];
                PlayingCard* secondCard = otherCards[j];
            
                
                if(!([self.matchedCards containsObject:secondCard]))
                    NSLog(@"CARD ! %ld", [self.matchedCards count]);
                {
                
                    if(firstCard.suit == secondCard.suit)
                    {
                        NSLog(@"this is true %ld", firstCard.rank);
                        NSLog(@"%ld inside SUIT checking match cards", [self.matchedCards count]);
                        [self.matchedCards addObject:firstCard];
                        [self.matchedCards addObject:secondCard];
                        
                            
                        NSLog(@"%ld inside 2 SUIT checking match cards", [self.matchedCards count]);
                        NSLog(@"this is other cards left %ld", [otherCards count]);
                        
                    
                    } else if(firstCard.rank == secondCard.rank){
                        [self.matchedCards addObject:secondCard];
                        [self.matchedCards addObject:firstCard];
                        
                        NSLog(@"%ld inside rank checking match cards", [self.matchedCards count]);
                        NSLog(@"this is other cards left %@", self.matchedCards);
                    }
                }
            }
        }
}
    
    NSMutableArray* uniqueMatchArray = [self.matchedCards valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"UNIQUE ARRAY %@", uniquearray);
    
    NSLog(@" %ld TOTAL IN MATCHED CARDS", [self.matchedCards count]);
    NSLog(@"this is other cards left %@", self.matchedCards);
    
    if ([self.matchedCards count] ==0) {
        return 1;
    }
    
    if ([otherCards count] == 3)
    {
        if ([uniqueMatchArray count] == 3) {
            if ([PlayingCard [uniqueMatchArray  objectAtIndex:0]].rank == [PlayingCard [uniqueMatchArray  objectAtIndex:1]].rank == [PlayingCard [uniqueMatchArray  objectAtIndex:2]].rank)
            {
                
                return 4;
            }
        }
    }
     return 1;
}

@end

