//
//  CardMatchingGame.m
//  matchismo
//
//  Created by Nadine Hachouche on 9/3/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"

@interface CardMatchingGame ()
@property(nonatomic, readwrite) NSInteger score;
//readwrite is the default; use this to re declare
//a read only from public api to private
//The readwrite says we are going to have a setter that
//Can call setter in the implementation; and no
//public api can set score, without a warning.

@property(nonatomic, strong) NSMutableArray* cards; //of Card
@property(nonatomic, strong) NSMutableArray* chosenCards;


@end


@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
 
}

-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
//have to call initializer, or our class will not initialize
{
    self = [super init]; //override NSObject
    //NSObject initializer is init
    if(self){
        
        self.cards = [NSMutableArray array];
        self.chosenCards = [NSMutableArray array];
        
        
        for (int i=0; i< count; i++){
            Card* card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
                //cards is an empty array for which we are adding a card to
            }
            else{
                //if there isn't a card, break from loop
                self = nil;
                break;
            }
        }
    }
    return self;
}


-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENALTY = 2;  // this is typed so it will show in the debugger
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index atSelectedSegmentIndex: (NSInteger) segmentIndex
{
    Card *card = [self cardAtIndex:index];
    card.chosen = YES;
    [self.chosenCards addObject:card];
    int score;

     NSLog(@"LENGTH of array in game match in segment 0 is %ld", [self.chosenCards count]);
    
//    
//    if (!card.isMatched) {
//        if (card.isChosen)
//        {
//            card.chosen = NO;
//            NSLog(@"this if in game match is working");
//        }else
    
        if (([self.chosenCards count] == 3) && segmentIndex == 0){
    
            NSLog(@"LENGTH of array in game match in segment 0 is %ld", [self.chosenCards count]);
            
            // match against another card
            
            //for (Card *otherCard in self.chosenCards) {
                //if (otherCard.isChosen && !otherCard.isMatched) {
            
            NSLog(@"BEFORE METHOD");
                    int matchScore = [card match:self.chosenCards];
            
                    
                    //if (matchScore) {
                        // increase score
                       // self.score += (matchScore * MATCH_BONUS);
                        
                        // mark cards as matched
                       // card.matched = YES;
                      //  otherCard.matched = YES;
                   // } else {
                        // mismath penalty when cards do no match
                      //  self.score -= MISMATCH_PENALTY;
                        
                        // flip othercard
                     //   otherCard.chosen = NO;
                    }
                    
                //    break;
                //}
            }
            
           // self.score -= COST_TO_CHOOSE;
            //card.chosen = YES;
      //  }
   // }
//}



@end

