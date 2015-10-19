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

- (void)chooseCardAtIndex:(NSUInteger)index atSelectedSegmentIndex:(NSInteger)segmentIndex
{
    Card *card = [self cardAtIndex:index];
    //ViewController segmentedControl.enabled = YES;

    card.chosen = YES;
    
    if (card.isChosen) {
        [self.chosenCards addObject:card];
        card.matched = YES;

    }
    
    if (([self.chosenCards count] == 3 && segmentIndex == 1) || ([self.chosenCards count] == 2 && segmentIndex == 0))
    {
            NSMutableArray* uniqueArrayOfMatchCards = [card match:self.chosenCards];
            NSInteger gotUserRawPoints = [self getMatchingCards: uniqueArrayOfMatchCards];
            [self getScore:gotUserRawPoints];
    }
    
//    
//    if ([self.delegate respondsToSelector:@selector(gotUniqueCards:)]) {
//        [self.delegate gotUniqueCards:uniqueArrayOfMatchCards];
//    }
    
}

-(NSInteger ) getMatchingCards:(NSMutableArray *)uniqueArrayOfMatchingCards
{
    NSLog(@"ARRAY IN GAME %@", uniqueArrayOfMatchingCards);
    if ([uniqueArrayOfMatchingCards count] == 0) {
        return 0;
    }
    
    if ([self.chosenCards count] == 3)
    {
        if ([uniqueArrayOfMatchingCards count] == 3) {
            if (([uniqueArrayOfMatchingCards[0]rank] == [uniqueArrayOfMatchingCards[1]rank] && [uniqueArrayOfMatchingCards[1]rank] == [uniqueArrayOfMatchingCards[2]rank]))
            {
                return 5;
            }
            if (([uniqueArrayOfMatchingCards[0]suit] == [uniqueArrayOfMatchingCards[1]suit] && [uniqueArrayOfMatchingCards[1]suit] == [uniqueArrayOfMatchingCards[2]suit]))
            {
                return 3;
            }
            
            else if(([uniqueArrayOfMatchingCards[0]rank] == [uniqueArrayOfMatchingCards[1]rank] ||[uniqueArrayOfMatchingCards[1]rank] == [uniqueArrayOfMatchingCards[2]rank] ||
                     [uniqueArrayOfMatchingCards[0]rank] ==
                     [uniqueArrayOfMatchingCards[2]rank]))
            {
                return 2;
            }
            else if(([uniqueArrayOfMatchingCards[0]suit] == [uniqueArrayOfMatchingCards[1]suit] ||[uniqueArrayOfMatchingCards[1]suit] == [uniqueArrayOfMatchingCards[2]suit] ||
                     [uniqueArrayOfMatchingCards[0]suit] ==
                     [uniqueArrayOfMatchingCards[2]suit]))
            {
                return 1;
                
            }
        }else if ([uniqueArrayOfMatchingCards count] == 2) {
            if (([uniqueArrayOfMatchingCards[0]rank] == [uniqueArrayOfMatchingCards[1]rank]))
            {
                return 4;
            }else if (([uniqueArrayOfMatchingCards[0]suit] == [uniqueArrayOfMatchingCards[1]suit]))
            {
                return 1;
            }
            
        }
    }
    
    if ([self.chosenCards count] == 2) {
        if (([uniqueArrayOfMatchingCards[0]rank] == [uniqueArrayOfMatchingCards[1]rank]))
        {
            return 4;
        }
        
        else if (([uniqueArrayOfMatchingCards[0]suit] == [uniqueArrayOfMatchingCards[1]suit]))
        {
            return 2;
        }
    }
    
    return 1;
}

-(NSInteger) getScore:(NSInteger)matchScore
{
    NSLog(@"match score in game, %ld", matchScore);
    if (matchScore) {
        NSLog(@"match score in if game, %ld", matchScore);
        self.score += (matchScore * MATCH_BONUS);
        self.score -= ([self.chosenCards count] * COST_TO_CHOOSE);
    }else{
        NSLog(@"match score in game else, %ld", matchScore);
        self.score -= ([self.chosenCards count] * COST_TO_CHOOSE);
        self.score -= MISMATCH_PENALTY;
    }
    self.chosenCards = [NSMutableArray array];
    return self.score;
}

@end
