//
//  CardMatchingGame.h
//  matchismo
//
//  Created by Nadine Hachouche on 9/3/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"9

@protocol CardMatchingGameDelegate <NSObject>
//-(void) didFindMatch:(NSMutableArray);


@end


@interface CardMatchingGame : NSObject

-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;
//how many cards are we playing with..cards >  2 else
//return nil
//designated public initializer; for other classes to see it, must be made public
- (void)chooseCardAtIndex:(NSUInteger)index atSelectedSegmentIndex: (NSInteger) segmentIndex;
//method that person can choose a card; specifies card user chose

-(Card *)cardAtIndex: (NSUInteger) index;
//UI knows which card was picked

@property(nonatomic, readonly) NSInteger score;
//privately we want to set the score; not publicly set
//score can be - = NSInteger


@end
