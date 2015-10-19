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

- (NSMutableArray *) match:(NSMutableArray *)userPickedCards; //override card method
{
    if(!(self.matchedCards)) self.matchedCards = [NSMutableArray new];
    
    for (int i = 0; i <= ([userPickedCards count]-1); i++)
    {
        for (int j= 1; j<= ([userPickedCards count]-1); j++)
        {
            NSLog(@"%ld in for loop other cards", [userPickedCards count]);
            if (i != j)
            {
                PlayingCard* firstCard = userPickedCards[i];
                PlayingCard* secondCard = userPickedCards[j];
                
                
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
     NSLog(@"match score in game PLAYING CARD, %@", uniqueMatchArray);
    return uniqueMatchArray; 
}

@end
