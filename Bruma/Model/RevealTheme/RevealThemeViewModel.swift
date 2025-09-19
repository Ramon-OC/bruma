//
//  RevealThemeViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import Foundation

extension RevealWordView{
    class ViewModel: ObservableObject{
        
        @Published var queriedPlayerIds: Set<String> = []
        @Published var players: [Player] = []
        @Published var isValidNFC: Bool = false
        @Published var isScratchingEnabled: Bool = false

        var remainPlayers: Int {players.count - queriedPlayerIds.count - 1} // -1 no se considera al pescador
        
        @Published var currentPlayerName: String = "name"
        @Published var word: String = "word"
        @Published var wordAFI: String = "wordAFI"
        
        var currentUserRole: PlayerRole = .fish
        
        init(){
            self.players = Game.shared.players
            let gameWord: (String, String) = Game.shared.getGameWord()
            self.word = gameWord.0
            self.wordAFI = gameWord.1
        }
        
        func queryPlayer(token: String){
            guard !queriedPlayerIds.contains(token) else {
                isScratchingEnabled = false
                return
            }
            
            if let player = players.first(where: { $0.nfcToken == token }) {
                self.isValidNFC = true
                self.currentUserRole = player.role
                self.currentPlayerName = player.name
                queriedPlayerIds.insert(token)
                print("Jugador: \(currentPlayerName). Rol: \(currentUserRole).")
                isScratchingEnabled = true
            }else{
                isScratchingEnabled = false
            }
        }
        
        var scratch_title: String {"scratch_title".translated()}
        var scratch_instruction: String {"scratch_instruction".translated()}
        var remain_reveals: String { "remain_reveals".translated(with: String(remainPlayers)) }
        var nfc_reveal_button: String { isScratchingEnabled ? "hello_name".translated(with: currentPlayerName) : "nfc_reveal_button".translated() }
        var hide_word_button: String { "hide_word_button".translated()}
    }
}
