//
//  Card.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import Foundation

struct Card: Codable {
    let id: Int
    let words: [String]
    let afiWords: [String]
    let keyword: String
    let keywordAFI: String
}
