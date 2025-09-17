//
//  NameInputBoxViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import Foundation

extension NameInputBoxView{
    class ViewModel: ObservableObject{
        
        func validateInput(textInput: String) -> Bool{
            textInput.trimmingCharacters(in: .whitespaces) == ""
        }
        
        var add_new_player: String = "add_new_player".translated()
        var name_input_placeholder: String = "name_input_placeholder".translated()
        var looks_great: String = "looks_great".translated()
    }
}
