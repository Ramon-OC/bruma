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
    
    @Binding var isShow: Bool    // for closing add box
    @State var isEditing = false // for keyboard input

    @State var inputName: String = ""
    var onSubmit: (String) -> Void
    @FocusState private var showkeyboard: Bool

    var body: some View {
        VStack(alignment: .leading){
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
            // MARK: NFC READER INPUT}
            NFCRegisterButtonView{ tokenID in
                print("llegó este token al input box: \(tokenID)")
            }
            
            // MARK: NAME TEXT INPUT
            TextField(vm.name_input_placeholder, text: $inputName, onEditingChanged: { (editingChanged) in
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
            
            // submit button
            Button(action: {
                if vm.validateInput(textInput: inputName) { return }
                onSubmit(inputName)
                self.isShow = false
            }) {
                Text(vm.looks_great)
                    .font(.system(.headline, design: .rounded))
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color("BrumaBlue"))
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            
        }
        .padding()
        .background {
            Color.black.ignoresSafeArea()
        }
    }
}
