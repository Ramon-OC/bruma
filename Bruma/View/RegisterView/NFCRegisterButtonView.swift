//
//  NFCRegisterButton.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI
import CoreNFC

struct NFCRegisterButtonView: View {
    @StateObject var vm = ViewModel()
    var buttonMessage: String
    @Binding var isValidNFC: Bool           // for closing add box
    var onSubmit: (String) -> Void
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        HStack{
            Button(action: {
                NFCReader.shared.readTag { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let uid):
                            print("DEBUG: READS UID: \(uid)")
                            onSubmit(uid)
                        case .failure(let error):
                            if let nfcError = error as? NFCReaderError {
                                switch nfcError {
                                case .userCancelled:
                                    showAlert = true
                                case .readingUnavailable:
                                    alertMessage = vm.reading_unavailable_error
                                    showAlert = true
                                case .noTagsDetected:
                                    alertMessage = vm.no_tags_detected_error
                                    showAlert = true
                                case .connectionFailed:
                                    alertMessage = vm.connection_failed_error
                                    showAlert = true
                                case .unsupportedTag:
                                    alertMessage = vm.unsupported_tag_error
                                    showAlert = true
                                }
                            } else {
                                alertMessage = error.localizedDescription
                                showAlert = true
                            }
                        }
                    }
                }
            }, label: {
                Image(systemName: "wave.3.left.circle.fill")
                    .font(.title3)
                    .foregroundColor(isValidNFC ? .green : .gray)
                Text(vm.nfc_register_button)
                    .font(.title3)
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(vm.nfc_error_alert),
                message: Text(alertMessage),
                dismissButton: .default(Text("Ok"))
            )
        }
        
    }
}


//struct NFC: View {
//    @State private var nfcResult = "Esperando..."
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//
//    var body: some View {
//        VStack(spacing: 20) {
//            Text("Resultado NFC:")
//                .font(.headline)
//
//            Text(nfcResult)
//                .foregroundColor(.blue)
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(8)
//
//            Button("Leer tag NFC") {
//                NFCReader.shared.readTag { result in
//                    DispatchQueue.main.async {
//                        switch result {
//                        case .success(let uid):
//                            nfcResult = "ID: \(uid)"
//                        case .failure(let error):
//                            if let nfcError = error as? NFCReaderError {
//                                switch nfcError {
//                                case .userCancelled:
//                                    nfcResult = "Lectura cancelada por el usuario"
//                                case .readingUnavailable:
//                                    nfcResult = "NFC no disponible"
//                                    alertMessage = "Este dispositivo no soporta NFC o está desactivado"
//                                    showAlert = true
//                                case .noTagsDetected:
//                                    nfcResult = "No se detectó ningún tag"
//                                    alertMessage = "Acerca más el dispositivo al tag NFC"
//                                    showAlert = true
//                                case .connectionFailed:
//                                    nfcResult = "Error de conexión"
//                                    alertMessage = "No se pudo conectar con el tag"
//                                    showAlert = true
//                                case .unsupportedTag:
//                                    nfcResult = "Tag no compatible"
//                                    alertMessage = "El tag detectado no es compatible"
//                                    showAlert = true
//                                }
//                            } else {
//                                nfcResult = "Error: \(error.localizedDescription)"
//                                alertMessage = error.localizedDescription
//                                showAlert = true
//                            }
//                        }
//                    }
//                }
//            }
//            .padding()
//            .background(Color.green)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//            .disabled(!NFCTagReaderSession.readingAvailable)
//            
//            if !NFCTagReaderSession.readingAvailable {
//                Text("NFC no disponible en este dispositivo")
//                    .foregroundColor(.red)
//                    .font(.caption)
//            }
//        }
//        .padding()
//        .alert(isPresented: $showAlert) {
//            Alert(
//                title: Text("Error de NFC"),
//                message: Text(alertMessage),
//                dismissButton: .default(Text("OK"))
//            )
//        }
//    }
//}
