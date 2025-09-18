//
//  RegisterViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

extension RegisterView{
    class ViewModel: ObservableObject{
        
        @Published var players: [Player] = []
        // Computed vars
        var noPlayers: Int { players.count }
        var canRegisterUser: Bool{ noPlayers < 8}
        var emptyPlayersName: Bool { players.count == 0}
        var enoughtPlayers: Bool { players.count >= 4}
        
        func addPlayer(player: Player){
            players.append(player)
        }
        
        func deletePlayer(at offsets: IndexSet) {
            players.remove(atOffsets: offsets)
        }
        
        func containsNFCToken(_ token: String) -> Bool {
            return players.contains { $0.nfcToken == token }
        }
        
        func startGame(){
            guard players.count >= 4 else { return }
            Game.shared.beginGame(players: players)
        }
        
        // Strings
        var players_names: String = "players_names".translated()
        var players_names_count: String{ "players_count".translated(with: String(noPlayers)) }
        var looks_great: String = "looks_great".translated()

    }
}
