//
//  Deck.h
//  Matchismo
//
//  Created by Nadine Hachouche on 8/16/15.
//  Copyright (c) 2015 MyCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
