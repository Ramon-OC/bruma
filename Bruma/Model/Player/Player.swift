//
//  File.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import Foundation

enum playerRole {
    case fish
    case hook
    case fisherman
}

struct Player{
    var name: String
    var nfcToken: String
    var role: playerRole = .fish
    
    init(name: String, nfcToken: String) {
        self.name = name
        self.nfcToken = nfcToken
    }
}
