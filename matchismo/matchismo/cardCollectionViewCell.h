//
//  cardCollectionViewCell.h
//  matchismo
//
//  Created by Nadine Hachouche on 10/23/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayingCard.h"

@interface cardCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *cardLabel;
@property(nonatomic, strong) IBOutlet UIImageView* imageView;
@property(nonatomic, strong) PlayingCard* card;
@end




// add the background and front image to the storyboard cell (square header)
// connect the image and label to the new class
//self.forRow -> collection view method ; where we make our cell we set the image.

//subclassing uicollectionviewcell

//