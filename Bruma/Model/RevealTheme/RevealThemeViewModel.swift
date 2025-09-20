//
//  RevealThemeViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import Foundation

extension RevealWordView{
    enum CardState {
        case empty
        case knownWord
        case fishermanCard
        case hookCard
        case fishCard
    }
    
    class ViewModel: ObservableObject{
        
        @Published var queriedPlayerIds: Set<String> = []
        @Published var players: [Player] = []
        @Published var isValidNFC: Bool = false
        @Published var isScratchingEnabled: Bool = false
        
        var remainPlayers: Int {players.count - queriedPlayerIds.count - 1} // -1 no se considera al pescador
        
        @Published var currentPlayerName: String = "name"
        @Published var gameKeyword: (String, String) = ("","") // word and afi word
        @Published var gameWord: (String, String) = ("","")    // word and afi word
        
        var currentUserRole: PlayerRole = .fish
        var cardState: CardState = .empty
        
        init(){
            self.players = Game.shared.players
            let word: (String, String) = Game.shared.getGameWord()
            let keyword: (String, String) = Game.shared.getGameKeyword()
            self.gameWord = word
            self.gameKeyword = keyword
        }
        
        func queryPlayer(token: String){
            guard !queriedPlayerIds.contains(token) else {
                isScratchingEnabled = false
                cardState = .knownWord
                return
            }
            
            if let player = players.first(where: { $0.nfcToken == token }) {
                switch player.role {
                case .fisherman:
                    cardState = .fishermanCard
                case .hook:
                    cardState = .hookCard
                    self.isValidNFC = true
                    self.currentUserRole = player.role
                    self.currentPlayerName = player.name
                    queriedPlayerIds.insert(token)
                    isScratchingEnabled = true
                case .fish:
                    cardState = .fishCard
                    self.isValidNFC = true
                    self.currentUserRole = player.role
                    self.currentPlayerName = player.name
                    queriedPlayerIds.insert(token)
                    isScratchingEnabled = true
                }
            }else{
                isScratchingEnabled = false
            }
        }
        
        var scratch_title: String {"scratch_title".translated()}
        var scratch_instruction: String {"scratch_instruction".translated()}
        var remain_reveals: String { "remain_reveals".translated(with: String(remainPlayers)) }
        var hide_word_button: String { "hide_word_button".translated()}
        var nfc_reveal_button: String { isScratchingEnabled ? "memorize_keyword_user".translated(with: currentPlayerName) : "nfc_reveal_button".translated() }
        var viewMessage: String {
            switch cardState {
            case .knownWord:
                return "known_word".translated()
            case .fishermanCard:
                return "fisherman_reveal_word".translated()
            case .fishCard:
                return "game_hint_message".translated()
            case .empty:
                return ""
            case .hookCard:
                return "game_word_message".translated()
            }
        }
        
    }
}
