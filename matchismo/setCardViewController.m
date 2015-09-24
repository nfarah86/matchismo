//
//  setCardViewController.m
//  matchismo
//
//  Created by Nadine Hachouche on 9/21/15.
//  Copyright (c) 2015 nadine farah. All rights reserved.
//

#import "setCardViewController.h"
#import "setCardDeck.h"

@interface setCardViewController ()

@end

@implementation setCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(Deck *)createDeck
{
    return [[setCardDeck alloc]init];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
