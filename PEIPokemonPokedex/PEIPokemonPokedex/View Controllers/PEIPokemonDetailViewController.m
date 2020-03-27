//
//  PEIPokemonDetailViewController.m
//  PEIPokemonPokedex
//
//  Created by Austin Potts on 3/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "PEIPokemonDetailViewController.h"

@interface PEIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak,nonatomic) IBOutlet UILabel *pokemonID;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilities;
 
@end

@implementation PEIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
