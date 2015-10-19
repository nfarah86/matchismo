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
@property (weak, nonatomic) IBOutlet UILabel *cardDescription;
@property (nonatomic) NSInteger scoreTracker;





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


-(void)viewDidLoad
{
    self.scoreTracker = 0;
    self.game.delegate = self;
    
    //[self.lib startUpdatingCount];
    
    
}

- (IBAction)touchCardBack:(UIButton *)sender
{
    {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
        //when we touch a card that is sender (sender is the index)

        [self.game chooseCardAtIndex:cardIndex atSelectedSegmentIndex:[self.segmentedControl selectedSegmentIndex]];
        [self updateUI];
        self.segmentedControl.enabled = NO;


    }
    
}


- (IBAction)clickOnDeal:(UIButton *)sender
{
    if(sender)
    {
        [self _createNewDeckOnUI];
        _scoreTracker = 0;

        self.segmentedControl.enabled = YES;
        
    }
}

- (void)_createNewDeckOnUI
{
        CardMatchingGame * newCards = [self.game initWithCardCount:[self.cardButtons count] usingDeck:[self deck]];
        for(NSUInteger i = 0; i < [self.cardButtons count]; i++)
        {
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
    [self updateMatchingScoreLabel:self.game.score];
}

-(void) updateMatchingScoreLabel:(NSInteger)score
{
    
    NSLog(@"SCORE after  %ld", score);
    NSLog(@"SCORE tracker before %ld", self.scoreTracker);
    if(_scoreTracker < score){
        NSLog(@"we have a match if tracker, %ld", self.scoreTracker);
        NSLog(@"we have a match if score, %ld", score);
    } else{
        NSLog(@"we don't have a match %ld", self.scoreTracker);
        NSLog(@"SCORE in else  %ld", score);
    }
    _scoreTracker = score;
    
    NSLog(@"bottom of function tracker %ld",self.scoreTracker);
}


-(void)gotUniqueCards:(NSMutableArray *) unqiueMatchedCards
{
    NSLog(@"%@ ARRAY", unqiueMatchedCards);
}


-(NSString *)titleForCard:(Card *)card
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
    if (segmentIndex == 0 || segmentIndex == 1)
    {
        [self _createNewDeckOnUI];
    }
}


@end
