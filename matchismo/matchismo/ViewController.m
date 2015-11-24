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
#import "cardCollectionViewCell.h"
#import "BeanViewController.h"




@interface ViewController () <CardMatchingGameDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *score_label;
@property(nonatomic) Deck* deck;
@property(nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *cardDescription;
@property (nonatomic) NSInteger scoreTracker;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray* cardsArray;
@property(nonatomic, getter=isSelected) BOOL selected;

@end



@implementation ViewController

- (Deck *)deck
{
    return [[PlayingCardDeck alloc] init];
}

-(CardMatchingGame *) game
{
    if (! _game)
    {
       _game = [[CardMatchingGame alloc] initWithCardCount:30 usingDeck:[self deck]];
                 //self.deck is calling the method deck above
        _game.delegate = self;
        self.cardsArray = [NSMutableArray new];

    }
    return _game;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.scoreTracker = 0;
    [self _createNewDeckOnUI];
    NSLog(@"viewdid load");
    [BeanViewController sharedBeanViewController];
}

- (IBAction)clickOnDeal:(UIButton *)sender
{
    if(sender)
    {
        [self _createNewDeckOnUI];
        _scoreTracker = 0;

        self.segmentedControl.enabled = YES;
        self.cardDescription.text = @"Lets Play";
    }
}

- (void)_createNewDeckOnUI
{
    CardMatchingGame * newCards = [self.game initWithCardCount:30 usingDeck:[self deck]];
    
        self.cardsArray = [NSMutableArray new];

    
        for(NSUInteger i = 0; i < 30; i++)
        {
            PlayingCard* newCardAtIndex = (PlayingCard *)[newCards cardAtIndex:i];
            [self.cardsArray addObject:newCardAtIndex];
            self.score_label.text = [NSString stringWithFormat:@"Score: 0"];
        }

    [self.collectionView reloadData];

}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage*) backgroundImageForCard: (Card *) card
{
    if (card.isChosen) {
        return nil;
    }else{
    return [UIImage imageNamed: @"back_card"];
    }
}

-(void)gotUniqueCards:(NSMutableArray *) unqiueMatchedCards
{
    // delegate method
    if ([unqiueMatchedCards count])
    {
        NSMutableString* labelDescription = [[NSMutableString alloc]initWithString:@"Matched: "];
        for (int i = 0; i < [unqiueMatchedCards count]; i+= 1)
        {
            PlayingCard* matchingCard = unqiueMatchedCards[i];
            [labelDescription appendFormat:@"%ld%@ and ", matchingCard.rank, matchingCard.suit];
        }
        NSString* newLabelDescription = [NSString stringWithString:labelDescription];
        NSRange replaceAnd= [labelDescription rangeOfString:@"and " options:NSBackwardsSearch];
        if (replaceAnd.location != NSNotFound)
        {
            newLabelDescription = [newLabelDescription stringByReplacingCharactersInRange:replaceAnd withString:@""];
        }
        self.cardDescription.text = newLabelDescription;
    } else{
        self.cardDescription.text = @"Sorry, No Matches";
    }
}

- (IBAction)chooseMatchCardGame:(UISegmentedControl *)sender
{
    NSInteger segmentIndex = [sender selectedSegmentIndex];
    if (segmentIndex == 0 || segmentIndex == 1)
    {
        [self _createNewDeckOnUI];
    }
}



#pragma UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cardCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[cardCollectionViewCell alloc] init];
    }
    
    PlayingCard *card = self.cardsArray[indexPath.row];
    NSString* cardTitle = [self titleForCard:card];
    cell.cardLabel.text =cardTitle;
    cell.imageView.image = [self backgroundImageForCard:card];
    
     return cell;
}

-(void)collectionView:(UICollectionView* )collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //reload
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.game chooseCardAtIndex:indexPath.row atSelectedSegmentIndex:[self.segmentedControl selectedSegmentIndex]];
    
    self.segmentedControl.enabled = NO;
    self.score_label.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];

    [collectionView reloadData];
}



@end
