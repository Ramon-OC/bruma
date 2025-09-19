//
//  CardManager.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import Foundation

class CardManager: ObservableObject {
    static let shared = CardManager()

    @Published var cards: [Card] = []
    var totalCards: Int { cards.count }

    func getRandomCard(completion: @escaping (Card?) -> Void) {
        let jsonFileName: String = "json_file_name".translated()
        loadCards(jsonFileName: jsonFileName) { [weak self] in
            completion(self?.cards.randomElement())
        }
    }

    func loadCards(jsonFileName: String, completion: @escaping () -> Void) {
        if let url = Bundle.main.url(forResource: jsonFileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decodedCards = try JSONDecoder().decode([Card].self, from: data)
                DispatchQueue.main.async {
                    self.cards = decodedCards
                    completion()
                }
            } catch {
                print("❌ Error decoding JSON: \(error)")
                completion()
            }
        } else {
            print("❌ JSON file '\(jsonFileName).json' not found in bundle.")
            completion()
        }
    }

}

