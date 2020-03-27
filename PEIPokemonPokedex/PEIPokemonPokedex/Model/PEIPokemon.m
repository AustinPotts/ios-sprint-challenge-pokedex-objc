//
//  PEIPokemon.m
//  PEIPokemonPokedex
//
//  Created by Austin Potts on 3/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "PEIPokemon.h"

@interface PEIPokemon ()

@property (nonatomic, nullable) NSMutableArray *abilitiesArray;

@end

@implementation PEIPokemon


- (instancetype)initWithName:(NSString *)name andURLString:(NSString *)urlString {
    if (self = [super init]) {
        self.name = name;
        self.pokemonURL = urlString;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        self.name = dictionary[@"name"];
        self.pokemonURL = dictionary[@"url"];
    }
    return self;
}

- (void)getAbilitiesAsString:(NSArray *)array {

    NSMutableArray<NSString *> *abilities = [@[] mutableCopy];

    for (NSDictionary *abilityDict in array) {
        NSDictionary *abilityDic = abilityDict[@"ability"];
        NSString *ability = abilityDic[@"name"];
        [abilities addObject:ability];
    }
    self.abilities = [abilities componentsJoinedByString:@", "];
}



@end
