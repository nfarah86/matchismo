//
//  Card.m
//  matchismo
//
//  Created by Nadine Hachouche on 8/15/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "Card.h"

@interface Card()
@end

@implementation Card


- (NSMutableArray*) match:(NSMutableArray *)userPickedCards
{
    NSMutableArray* uniqueArrayOfCards = [NSMutableArray new];

    
    for (Card *card in userPickedCards)
    {
        if ([card.contents isEqualToString:self.
             contents])
        {
            NSLog(@"card match");
            //card.contents is calling the getter of contents property of card instance. Setter: card.contents = (now we are calling the setter).
            //self.contents is also calling getter
            //isEqualToString (need to compare two strings ie ==)
            // isEqualToString returns boolean
            // == compares POINTERS but not what the POINTERS point to.
            //setter and getters use . notation
            //setter = card.contents but position is on LEFT hand side, where getter is NOT LEFT hand side (same syntax)
            return uniqueArrayOfCards;
        }
    }
    
    return uniqueArrayOfCards;
}
@end





