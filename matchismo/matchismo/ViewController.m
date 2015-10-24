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


@interface ViewController () <CardMatchingGameDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *score_label;
@property(nonatomic) Deck* deck;
@property(nonatomic) CardMatchingGame* game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *cardDescription;
@property (nonatomic) NSInteger scoreTracker;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) UIView *backgroundView;


//UICOLLECTIONVIEW


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
    }
    return _game;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.scoreTracker = 0;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass: [UICollectionViewCell class]forCellWithReuseIdentifier:@"cardCell"];
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
        self.cardDescription.text = @"Lets Play";
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
}


-(void)gotUniqueCards:(NSMutableArray *) unqiueMatchedCards
{
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
    }else{
        self.cardDescription.text = @"Sorry, No Matches";
    }
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
    if (segmentIndex == 0 || segmentIndex == 1)
    {
        [self _createNewDeckOnUI];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}

-(UICollectionViewCell* )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //UICollectionViewCell* cell = [[UICollectionViewCell alloc]init];
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cardCell" forIndexPath:indexPath];
    

    cell.contentView.backgroundColor = [UIColor redColor];
    //self.backgroundView.backgroundColor = [UIColor purpleColor];
    return cell;
    
}

-(void)collectionView:(UICollectionView* )collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //do something
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //do something
}



//(CGSize) - collectionSizeForItems.... // if I know the orientation , then I can position the cards to be nice layed out.

//

@end
