//
//  MainViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 16/09/25.
//

import Foundation
extension MainView{
    class ViewModel: ObservableObject{
        
        @Published var showIntructions: Bool = false
        
        // Strings
        var game_name: String = "game_name".translated().uppercased()
        var welcome_title: String = "welcome_title".translated().uppercased()
        var new_around: String = "new_around".translated()
        var go_rules: String = "go_rules".translated()
    }
}
