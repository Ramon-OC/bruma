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
    var players: [Player] = []
    var gameMode: gameMode = .manualGame
    var hookInsider: Int?
    var fishermanInsider: Int?
    
    static var shared: Game = {
        let instance = Game()
        return instance
    }()
    
    func resetGame(){
        players = []
        hookInsider = nil
        fishermanInsider = nil
    }
    
    func beginGame(players: [Player]){
        self.players = players
        distributionOfRoles()
    }
    
    private func distributionOfRoles() {
        guard players.count >= 2 else {
            return
        }

        let randomIndices = Array(0..<players.count).shuffled().prefix(2)
        
        players[randomIndices[0]].role = .hook
        players[randomIndices[1]].role = .fisherman
        
        self.hookInsider = randomIndices[0]
        self.fishermanInsider = randomIndices[1]
    }
    
}
