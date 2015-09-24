//
//  ViewController.m
//  matchismo
//
//  Created by Nadine Hachouche on 8/15/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *score_label;
@property(nonatomic) Deck* deck;
@property(nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;


@end

@implementation ViewController

- (Deck *)deck
{
    return [[PlayingCardDeck alloc] init];
}

-(CardMatchingGame *) game{
    if (! _game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self deck]];
                 //self.deck is calling the method deck above
    return _game;
}


- (IBAction)touchCardBack:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    //when we touch a card that is sender (sender is the index)
    NSLog(@"%ld THIS IS A CARD AT INDEX", cardIndex);

    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
    
}



-(void)updateUI
{
        for (UIButton* cardButton in self.cardButtons){
            NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton]; //cardButton is a card object
            Card *card = [self.game cardAtIndex:cardIndex];
        
        
            [cardButton setTitle: [self titleForCard:card] forState: UIControlStateNormal];
            [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
            cardButton.enabled = !card.isMatched;
            self.score_label.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
        }
}



-(NSString*) titleForCard: (Card *) card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage*) backgroundImageForCard: (Card *) card
{
    return [UIImage imageNamed:(card.isChosen) ? @"frontCard" : @"back_card"];
}

@end
