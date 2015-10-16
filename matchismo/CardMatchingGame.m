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

//@property (nonatomic) NSInteger matchScore;
@property(nonatomic, strong) NSMutableArray* cards; //of Card
@property(nonatomic, strong) NSMutableArray* chosenCards;
@property (nonatomic) NSInteger getScore;


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
        self.score = 0;
        
        
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

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index atSelectedSegmentIndex: (NSInteger) segmentIndex
{
   
    Card *card = [self cardAtIndex:index];
    //ViewController segmentedControl.enabled = YES;

    card.chosen = YES;
    
    if (card.isChosen) {
        [self.chosenCards addObject:card];
        card.matched = YES;
    }
    
    if (([self.chosenCards count] == 3) && segmentIndex == 1){

        NSInteger matchScore = [card match:self.chosenCards];
        NSLog(@"at match method");
        
        [self getScore:matchScore];
        
    }
    
    else if (([self.chosenCards count] == 2) && segmentIndex == 0){
         int matchScore = [card match:self.chosenCards];
        
        [self getScore:matchScore];
     
    }
}

-(NSInteger) getScore:(NSInteger)matchScore
{
    NSLog(@"THIS IS THE match %ld", matchScore);
    if (matchScore) {
        self.score += (matchScore * MATCH_BONUS);
        self.score -= ([self.chosenCards count] * COST_TO_CHOOSE);
    }
    else{
        self.score -= ([self.chosenCards count] * COST_TO_CHOOSE);
        self.score -= MISMATCH_PENALTY;
    }
    
    self.chosenCards = [NSMutableArray array];
    return self.score;

}



@end
