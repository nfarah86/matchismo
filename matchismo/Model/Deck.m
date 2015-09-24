//
//  Deck.m
//  Matchismo
//
//  Created by Nadine Hachouche on 8/16/15.
//  Copyright (c) 2015 MyCompany. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
//creates a pointer to cards, but doesn't allocate array in heap
@end

@implementation Deck

-(NSMutableArray *) cards
//creates empty array 
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
        //now we have an empty [] in the heap by allocating memory
    return _cards;
}


- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop)
    {
        [self.cards insertObject:card atIndex:0];
    } else{
        [self.cards addObject:card];
    }
    
}

- (void)addCard:(Card *)card;
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    //above is a test... problem is there is NO CARDS...
    if ([self.cards count]) {
        // get a random card and remove it from the deck
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        NSLog(@"randomCard, %@", randomCard);
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
    //NSLog(@"randomCard, %@", randomCard);
}
@end
