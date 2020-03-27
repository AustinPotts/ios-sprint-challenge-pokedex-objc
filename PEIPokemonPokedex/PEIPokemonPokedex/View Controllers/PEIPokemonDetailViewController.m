//
//  PEIPokemonDetailViewController.m
//  PEIPokemonPokedex
//
//  Created by Austin Potts on 3/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "PEIPokemonDetailViewController.h"
#import "PEIPokemon.h"

@interface PEIPokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *pokemonImage;
@property (weak, nonatomic) IBOutlet UILabel *pokemonName;
@property (weak,nonatomic) IBOutlet UILabel *pokemonID;
@property (weak, nonatomic) IBOutlet UILabel *pokemonAbilities;
 
@end

@implementation PEIPokemonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.pokemon) {
        self.pokemonName.text = self.pokemon.name.capitalizedString;
    }

    // Adding KVO to pokemon properties
    [self.pokemon addObserver:self forKeyPath:@"pokemonID" options:0 context:NULL];
    [self.pokemon addObserver:self forKeyPath:@"abilities" options:0 context:NULL];
    [self.pokemon addObserver:self forKeyPath:@"pokemonSprite" options:0 context:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == NULL) {
        [self updateViews];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateViews {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.pokemonImage.image = self.pokemon.pokemonSprite;
        self.pokemonName.text = self.pokemon.name.capitalizedString;
        if (self.pokemon.abilities) {
            self.pokemonAbilities.text = self.pokemon.abilities.capitalizedString;
        } else {
            self.pokemonAbilities.text = @"No abilities";
        }
        self.pokemonID.text = self.pokemon.pokemonID;
    });
}


// Removing KVO 
- (void)dealloc
{
    [self.pokemon removeObserver:self forKeyPath:@"pokemonID"];
    [self.pokemon removeObserver:self forKeyPath:@"abilities"];
    [self.pokemon removeObserver:self forKeyPath:@"pokemonSprite"];
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
