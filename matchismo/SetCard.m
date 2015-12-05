//
//  SetCard.m
//  matchismo
//
//  Created by Nadine Hachouche on 12/4/15.
//  Copyright © 2015 nadine farah. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@property (nonatomic, strong) NSMutableArray* matchedCards;

@end


@implementation SetCard

@synthesize number =_number, color=_color, shading=_shading, symbol=_symbol;


+(NSArray* )numbers;
{
    return @[@1, @2, @3];
}

+(NSArray* )symbols;
{
    return @[@"diamond",@"oval", @"squiggle"];
}

+(NSArray* )shadings;
{
    return @[@"solid", @"striped", @"open"];
}

+(NSArray* )colors;
{
    return @[@"purple", @"green", @"red"];
}

-(NSString*)color
{
    return _color ? _color: @"?";
}

-(NSString*)shading
{
    return _shading ? _shading : @"?";
}

-(NSString*) symbol
{
    return _shading ? _shading : @"?";
}

-(void)setNumber:(NSNumber *)number
{
    if ([[SetCard numbers] containsObject:number]) {
        _number = number;
    }
}

-(void)setSymbol:(NSString *)symbol
{
    if ([[SetCard symbols]containsObject:symbol]) {
        _symbol = symbol;
    }
}

-(void)setShading:(NSString *)shading
{
    if ([[SetCard shadings]containsObject:shading]) {
        _shading = shading;
    }
}

-(void)setColor:(NSString *)color
{
    if ([[SetCard colors]containsObject:color]) {
        _color = color;
    }
}

-(NSString*)contents
{
    NSString* setCardsContent = [[NSString alloc]initWithFormat:@"%@, %@, %@, %@", self.number, self.shading, self.color, self.symbol];
    
    return setCardsContent;
}

@end
