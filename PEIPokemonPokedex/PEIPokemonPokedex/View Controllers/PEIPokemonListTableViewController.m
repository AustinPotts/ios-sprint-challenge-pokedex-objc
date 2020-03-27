//
//  PEIPokemonListTableViewController.m
//  PEIPokemonPokedex
//
//  Created by Austin Potts on 3/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "PEIPokemonListTableViewController.h"
#import "PEIPokemonDetailViewController.h"
#import "PEIPokemon.h"
#import <PEIPokemonPokedex-Swift.h>


@interface PEIPokemonListTableViewController ()

@property (nonatomic) NSMutableArray *pokemonArray;

@property APIController *pokemonController;

@end

@implementation PEIPokemonListTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[APIController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<PEIPokemon *> * _Nullable array, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%lu", array.count);
            [self.tableView  reloadData];
        });
    }];
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return self.pokemonController.allPokemon.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pokemonController.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
     PEIPokemon *pokemon = self.pokemonController.allPokemon[indexPath.row];
     cell.textLabel.text = pokemon.name.capitalizedString;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonSegue"]) {
        PEIPokemonDetailViewController *detailVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PEIPokemon *pokemon = self.pokemonController.allPokemon[indexPath.row];
        detailVC.pokemon = pokemon;
        [self.pokemonController fillInDetailsFor:pokemon];
    }
}


@end
