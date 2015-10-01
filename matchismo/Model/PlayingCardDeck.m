//
//  PlayingCardDeck.m
//  matchismo
//
//  Created by Nadine Hachouche on 8/26/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
@implementation PlayingCardDeck

-(instancetype)init
{
    self = [super init];
    if (self){
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc]init];
                    //we care and empty card for each item in a list of list
                card.rank = rank;
                //set rank
                card.suit  = suit;
                //set suit
                [self addCard:card];
                //add card to deck
                
               
                
            }
        }
    }
    return self;
}

@end
