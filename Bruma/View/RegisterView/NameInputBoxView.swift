//
//  NameInputBoxView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

struct BlankView: View {
    var bgColor: Color
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(bgColor)
        .edgesIgnoringSafeArea(.all)
    }
}

struct NameInputBoxView: View {
    @StateObject var vm = ViewModel()

    @Binding var isShow: Bool // for closing add box
    @State var isEditing = false // for keyboard input
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // @State var inputName: String = ""
    var containsNFCToken: (String) -> Bool
    var onSubmit: (Player) -> Void
    @FocusState private var showkeyboard: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            // Spacer()
            // MARK: - TILE AND CLOSE BUTTON
            HStack {
                Text(vm.add_new_player)
                    .font(.custom("Helvetica", size: 30))
                    .foregroundStyle(.white)
                Spacer()

                Button(action: { isShow = false }, label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .font(.headline)
                })
            }

            // MARK: NFC READER INPUT
            VStack(alignment: .leading, spacing: 10){
                Text(vm.token_input_instruction)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                NFCRegisterButtonView(buttonIsDisabled: false, buttonMessage: vm.nfc_register_button, turnGreenButton: vm.isValidNFC) { nfcToken in
                    if !containsNFCToken(nfcToken) {
                        vm.setNfcToken(nfcToken: nfcToken)
                    }else{
                        alertMessage = vm.nfc_already_registeres
                        showAlert = true
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("TEXTO"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("Ok"))
                )
            }

            // MARK: NAME TEXT INPUT
            VStack(alignment: .leading, spacing: 10){
                Text(vm.name_input_instruction)
                    .font(.caption)
                    .foregroundColor(Color.gray)
                TextField(vm.name_input_placeholder, text: $vm.playersName, onEditingChanged: { (editingChanged) in
                    isEditing = editingChanged
                })
                .focused($showkeyboard)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.bottom)
                .onAppear {
                    showkeyboard = true
                }
            }

            // submit button
            Button(action: {
                let player = vm.createPlayer()
                onSubmit(player)
                self.isShow = false
            }, label: {
                Text(vm.looks_great)
                    .font(.system(.headline, design: .rounded))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundStyle(.white)
            })
            .floatingButtonStyle(color: .mediumBlue)
            .disableWithOpacity(vm.disableOpacity)
        }
        .padding()
        .background {
            Color.darkBlue
                .cornerRadius(10) // Corner radius de 10
                .ignoresSafeArea()
        }
    }
}
