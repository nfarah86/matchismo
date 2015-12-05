//
//  SetCard.h
//  matchismo
//
//  Created by Nadine Hachouche on 12/4/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSNumber* number;
@property (nonatomic,strong) NSString* symbol;
@property (strong, nonatomic) NSString* shading;
@property (nonatomic,strong) NSString* color;

+(NSArray* )numbers;
+(NSArray* )symbols;
+(NSArray* )shadings;
+(NSArray* )colors;


@end
