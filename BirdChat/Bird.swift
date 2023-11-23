//
//  Bird.swift
//  BirdChat
//
//  Created by Yakov Manshin on 10/22/23.
//

struct Bird {
    
    let id: Int
    let displayName: String
    
    // TODO: Add `favoriteFood`
    
    init(id: Int, displayName: String) {
        self.id = id
        self.displayName = displayName
    }
    
}

extension Bird {
    static let sampleBird1 = Bird(id: 1, displayName: "$uperCr0w")
    static let sampleBird2 = Bird(id: 2, displayName: "BirdOfParadise")
}
