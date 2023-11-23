//
//  Bird.swift
//  BirdChat
//
//  Created by Yakov Manshin on 10/22/23.
//

import BirdChatMacros

@InferEquatable(basedOn: "id")
struct Bird {
    
    let id: Int
    let displayName: String
    let favoriteFood: FavoriteFood
    
    init(id: Int, displayName: String, favoriteFood: FavoriteFood) {
        self.id = id
        self.displayName = displayName
        self.favoriteFood = favoriteFood
    }
    
    #DisplayableOptions("FavoriteFood", options: ["Grains", "Insects", "Fish", "Other Birds"])
    
}

extension Bird {
    static let sampleBird1 = Bird(id: 1, displayName: "$uperCr0w", favoriteFood: .fish)
    static let sampleBird2 = Bird(id: 2, displayName: "BirdOfParadise", favoriteFood: .insects)
}
