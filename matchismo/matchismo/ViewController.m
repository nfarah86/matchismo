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
#import "PlayingCard.h"


@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *score_label;
@property(nonatomic) Deck* deck;
@property(nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;





@end

@implementation ViewController

- (Deck *)deck
{
    return [[PlayingCardDeck alloc] init];
}

-(CardMatchingGame *) game
{
    if (! _game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                           usingDeck:[self deck]];
                 //self.deck is calling the method deck above
    return _game;
}


- (IBAction)touchCardBack:(UIButton *)sender
{
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
        //when we touch a card that is sender (sender is the index)
        NSLog(@"%ld THIS IS A CARD AT INDEX", cardIndex);

        [self.game chooseCardAtIndex:cardIndex atSelectedSegmentIndex:[self.segmentedControl selectedSegmentIndex]];
        [self updateUI];

    }
    
}


- (IBAction)clickOnDeal:(UIButton *)sender
{
    if(sender)
    {
        [self _createNewDeckOnUI];
    }
}

- (void)_createNewDeckOnUI
{
        CardMatchingGame * newCards = [self.game initWithCardCount:[self.cardButtons count] usingDeck:[self deck]];
        for(NSUInteger i = 0; i < [self.cardButtons count]; i++)
        {
           // NSInteger control =  [self.segmentedControl selectedSegmentIndex];
            
            
            PlayingCard* newCardAtIndex = (PlayingCard * )[newCards cardAtIndex:i];
            UIButton* cardButtonInView = self.cardButtons[i];
            
            cardButtonInView.enabled = !newCardAtIndex.isMatched;
            
            [cardButtonInView setTitle:[self titleForCard: newCardAtIndex]forState:UIControlStateNormal];
            [cardButtonInView setBackgroundImage:[self backgroundImageForCard:newCardAtIndex] forState:UIControlStateNormal];
            self.score_label.text = [NSString stringWithFormat:@"Score: 0"];
        }
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
    return card.isChosen ? @"" : card.contents;
}

-(UIImage*) backgroundImageForCard: (Card *) card
{
    return [UIImage imageNamed:(card.isChosen) ? @"frontCard" : @"back_card"];
}





- (IBAction)chooseMatchCardGame:(UISegmentedControl *)sender
{
    NSInteger segmentIndex = [sender selectedSegmentIndex];
    NSLog(@"THIS IS the index %ld", segmentIndex);
    if (segmentIndex == 0)
    {
        [self _createNewDeckOnUI];
    }
    
    if (segmentIndex == 1)
    {
        [self _createNewDeckOnUI];
    }
    
    
    //if/else
    
    //update card on back.. to see if segment is a 2-card game or 3-card game
    //send that number over //
    //if segment == 1 compare 2 cards (default)
    //if segment == 2 compare 3 cards (we need to modify)
    
    //reinti
    //later on, we should have a pop up that says you want to have a 2 or 3 card matching game..ie choose your game.
    
    
}


@end
