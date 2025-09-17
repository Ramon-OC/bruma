//
//  NFCReader.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI
import CoreNFC

class NFCReader: NSObject, NFCTagReaderSessionDelegate {
    static let shared = NFCReader()
    private var session: NFCTagReaderSession?
    private var completion: ((Result<String, Error>) -> Void)?
    private var didReadSuccessfully = false

    func readTag(completion: @escaping (Result<String, Error>) -> Void) {
        guard NFCTagReaderSession.readingAvailable else {
            completion(.failure(NFCReaderError.readingUnavailable))
            return
        }

        self.completion = completion
        self.didReadSuccessfully = false
        session = NFCTagReaderSession(pollingOption: [.iso14443], delegate: self)
        session?.alertMessage = "nfc_reading_instructions".translated()
        session?.begin()
    }

    // MARK: - NFCTagReaderSessionDelegate
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print("Sesión NFC activa")
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        //print("Sesión NFC terminada: \(error.localizedDescription)")
        
        // Si ya leímos exitosamente, no reportar error
        if didReadSuccessfully {
            return
        }
        
        // Verificar si es cancelación del usuario
        if let nfcError = error as? NFCReaderError {
            completion?(.failure(nfcError))
        } else if (error as NSError).code == 200 {
            completion?(.failure(NFCReaderError.userCancelled))
        } else {
            completion?(.failure(error))
        }
    }

    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        guard let firstTag = tags.first else {
            session.invalidate(errorMessage: "nfc_undetected".translated())
            completion?(.failure(NFCReaderError.noTagsDetected))
            return
        }

        session.connect(to: firstTag) { error in
            if error != nil {
                session.invalidate(errorMessage: "nfc_retry".translated())
                self.completion?(.failure(NFCReaderError.connectionFailed))
                return
            }

            // Obtener el UID según el tipo de tag
            var uid = ""
            
            switch firstTag {
            case .miFare(let mifareTag): // mine
                uid = mifareTag.identifier.map { String(format: "%02X", $0) }.joined()
                
            case .feliCa(let felicaTag):
                uid = felicaTag.currentIDm.map { String(format: "%02X", $0) }.joined()
                
            case .iso15693(let iso15693Tag):
                uid = iso15693Tag.identifier.map { String(format: "%02X", $0) }.joined()
                
            case .iso7816(let iso7816Tag):
                uid = iso7816Tag.identifier.map { String(format: "%02X", $0) }.joined()
                
            @unknown default:
                session.invalidate(errorMessage: "nfc_unsupported".translated())
                self.completion?(.failure(NFCReaderError.unsupportedTag))
                return
            }
            
            session.alertMessage = "successful_reading".translated()
            
            // set succesfull reading
            self.didReadSuccessfully = true
            self.completion?(.success(uid))
            
            session.invalidate()
        }
    }
}

enum NFCReaderError: Error {
    case readingUnavailable
    case noTagsDetected
    case unsupportedTag
    case connectionFailed
    case userCancelled
    
    var localizedDescription: String {
        switch self {
        case .readingUnavailable:
            return "NFC no está disponible"
        case .noTagsDetected:
            return "No se detectaron tags"
        case .unsupportedTag:
            return "Tag no soportado"
        case .connectionFailed:
            return "Error de conexión"
        case .userCancelled:
            return "Cancelado por el usuario"
        }
    }
}
