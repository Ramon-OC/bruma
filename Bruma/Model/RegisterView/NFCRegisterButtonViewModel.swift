//
//  NFCRegisterButtonViewModel.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import Foundation

extension NFCRegisterButtonView{
    class ViewModel: ObservableObject{
                
        var nfc_error_alert: String = "nfc_error_alert".translated()
        var nfc_register_button: String = "nfc_register_button".translated()
        var reading_unavailable_error: String = "reading_unavailable_error".translated()
        var no_tags_detected_error: String = "no_tags_detected_error".translated()
        var connection_failed_error: String = "connection_failed_error".translated()
        var unsupported_tag_error: String = "unsupported_tag_error".translated()
        
    }
}
