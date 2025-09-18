//
//  NameInputBoxViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import Foundation

extension NameInputBoxView{
    class ViewModel: ObservableObject{
        
        @Published var playersName: String = ""
        @Published var nfcToken: String = ""
        @Published var isValidNFC: Bool = false  // for closing add box

        var disableOpacity: Bool{
            return nfcToken.isEmpty || playersName.isEmpty
        }
        
        func setNfcToken(nfcToken: String){
            self.nfcToken = nfcToken
            self.isValidNFC = true
        }
        
        func createPlayer() -> Player{
            return Player(name: playersName, nfcToken: nfcToken)
        }
        
        func validateInput(textInput: String) -> Bool{
            textInput.trimmingCharacters(in: .whitespaces) == ""
        }
        
        var add_new_player: String = "add_new_player".translated()
        var name_input_placeholder: String = "name_input_placeholder".translated()
        var looks_great: String = "looks_great".translated()
        var token_input_instruction: String = "token_input_instruction".translated()
        var name_input_instruction: String = "name_input_instruction".translated()
        var nfc_already_registeres: String = "nfc_already_registeres".translated()
        var nfc_register_button: String {"nfc_register_button".translated()}

    }
}
