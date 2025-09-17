//
//  Multilanguaje.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 16/09/25.
//
import Localize_Swift

extension String {
    func translated() -> String {
        return self.localized()
    }
    
    func translated(with arguments: CVarArg...) -> String {
        let format = self.localized()
        return String(format: format, arguments: arguments)
    }
        
}
