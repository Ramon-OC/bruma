//
//  Game.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import Foundation

enum gameMode {
    case nfcGame
    case manualGame
}

class Game{
    private(set) var players: [Player] = []
    private(set) var card: Card?
    private(set) var wordIndex: Int = 0
    private(set) var gameMode: gameMode = .nfcGame
    private(set) var hookIndex: Int?
    private(set) var fishermanIndex: Int?
    
    static var shared: Game = {
        let instance = Game()
        return instance
    }()
    
    func resetGame(){
        players = []
        card = nil
        wordIndex = 0
        hookIndex = nil
        fishermanIndex = nil
    }
    
    func beginGame(players: [Player]){
        // random roles
        self.players = players
        distributionOfRoles()
        // random card
        CardManager.shared.getRandomCard { card in
            self.card = card
        }
        print(card?.words ?? "LA CARTA ESTA VACIA")
        self.wordIndex = Int.random(in: 0...4)
    }
    
    func getGameWord() -> (String, String) {
        return (card?.words[wordIndex] ?? "WORD", card?.afiWords[wordIndex] ?? "AFI")
    }
    
    private func distributionOfRoles() {
        guard players.count >= 2 else {
            return
        }

        let randomIndices = Array(0..<players.count).shuffled().prefix(2)
        
        players[randomIndices[0]].role = .hook
        players[randomIndices[1]].role = .fisherman
        
        self.hookIndex = randomIndices[0]
        self.fishermanIndex = randomIndices[1]
    }

}
