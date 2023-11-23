//
//  ContentView.swift
//  BirdChat
//
//  Created by Yakov Manshin on 10/22/23.
//

import SwiftUI

struct ContentView: View {
    
    let currentUser: Bird
    let otherUser: Bird
    
    var body: some View {
        // FIXME: Encapsulate this logic inside `Bird`
        if currentUser.id != otherUser.id {
            addToFriendsView
        } else {
            sameUserErrorView
        }
    }
    
    @ViewBuilder
    var addToFriendsView: some View {
        VStack(spacing: 32) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "bird.circle.fill")
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundStyle(.tint)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.green)
                    .background()
                    .clipShape(Circle())
            }
            VStack (spacing: 8) {
                Text("\(currentUser.displayName), would you like to add \(otherUser.displayName) to friends?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                // TODO: Display `otherUser`’s `favoriteFood`
            }
            HStack {
                Button("Add") {
                    // TODO: Add to friends
                }
                .buttonStyle(.borderedProminent)
                .fontWeight(.bold)
                Button("Cancel") {
                    // TODO: Cancel and go back
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var sameUserErrorView: some View {
        VStack(spacing: 32) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundStyle(.red)
            Text("Sorry, you cannot add yourself as a friend.")
                .font(.headline)
        }
    }
    
}

#Preview {
    ContentView(currentUser: .sampleBird1, otherUser: .sampleBird2)
}
