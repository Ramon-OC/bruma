//
//  File.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import Foundation

struct Player: Identifiable{
    var id = UUID()
    var name: String
    var nfcToken: String = ""
    var role: PlayerRole = .fish
    
    init(name: String, nfcToken: String) {
        self.name = name
        self.nfcToken = nfcToken
    }
    
    init(name: String){
        self.name = name
    }
}
