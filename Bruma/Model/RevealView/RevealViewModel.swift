//
//  RevealViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import Foundation
import UIKit

extension RevealRoleView{
    class ViewModel: ObservableObject{
        
        @Published var queriedPlayerIds: Set<String> = []
        @Published var players: [Player] = []
        @Published var isValidNFC: Bool = false
        
        // view states
        @Published var isCardFlipped: Bool = false
        var allPlayersHaveScanned: Bool { queriedPlayerIds.count == players.count }

        // view elements
        @Published var currentPlayerName: String = "name"
        @Published var currentUserRole: PlayerRole = .fish

        var roleName: String { currentUserRole.roleName }
        var rolePhonetic: String { currentUserRole.phonetic }
        var roleImage: String { currentUserRole.imageName }
        
        var noPlayers: Int { players.count }
        var remainPlayers: Int {players.count - queriedPlayerIds.count}
        
        init(){
            self.players = Game.shared.players
        }
                
        func queryPlayer(token: String){
            guard !queriedPlayerIds.contains(token) else {
                return
            }
            
            if let player = players.first(where: { $0.nfcToken == token }) {
                self.isValidNFC = true
                self.currentUserRole = player.role
                self.currentPlayerName = player.name
                queriedPlayerIds.insert(token)
                //print("Jugador: \(currentPlayerName). Rol: \(currentUserRole).")
            }
        }

        // strings
        var reveal_role_title: String = "reveal_role_title".translated()
        var remain_reveals: String { "remain_reveals".translated(with: String(remainPlayers)) }
        var press_to_hide: String { "press_to_hide".translated() }
        var nfc_reveal_button: String { "nfc_reveal_button".translated() }
    }
}
