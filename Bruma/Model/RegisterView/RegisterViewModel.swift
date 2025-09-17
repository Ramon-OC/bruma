//
//  RegisterViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

extension RegisterView{
    class ViewModel: ObservableObject{
        
        @Published var playersNames: [String] = []
        // Computed vars
        var noPlayers: Int { playersNames.count }
        var canRegisterUser: Bool{ noPlayers < 8}
        var emptyPlayersName: Bool { playersNames.count == 0}
        
        func addPlayerNama(name: String){
            playersNames.append(name)
        }
        
        func deletePlayer(at offsets: IndexSet) {
            playersNames.remove(atOffsets: offsets)
        }
        
        // Strings
        var players_names: String = "players_names".translated()
        var players_names_count: String{ "players_count".translated(with: String(noPlayers)) }

    }
}
