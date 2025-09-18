//
//  RevealView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

struct RevealView: View {
    @StateObject var vm = RevealView.ViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            VStack(spacing: 10){
                Text(vm.reveal_role_title)
                    .font(.custom("Helvetica", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(vm.remain_reveals)
                    .font(.custom("Helvetica", size: 30))
                    .fontWeight(.light)
                    .foregroundColor(.black)
            }
            
            RoleCardView(isFlipped: $vm.isCardFlipped, frontCardImage: "RoleCard", roleSymbol: vm.roleImage, roleName: vm.roleName, roleAFI: vm.rolePhonetic)
            
            // MARK: NFC READER INPUT
            VStack(alignment: .center, spacing: 10){
                if vm.isCardFlipped{
                    PulsingText(text: vm.press_to_hide)
                }
                NFCRegisterButtonView(buttonMessage: vm.nfc_register_button ,isValidNFC: $vm.isValidNFC) { nfcToken in
                    vm.isCardFlipped = true
                    vm.queryPlayer(token: nfcToken)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("TEXTO"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("Ok"))
                )
            }
        }
    }
}

struct PulsingText: View {
    @State var textIsPulsing = false
    var text: String = ""
    var body: some View {
        ZStack {
            Text(text)
                .italic()
                .font(.system(size: 25, weight: .light, design:.default))
                .foregroundColor(.black)
                .padding(.top, 40)
                .opacity(textIsPulsing ? 0.5 : 1.0)
        }
        .animation(
            Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true),
            value: textIsPulsing
        )
        .onAppear { textIsPulsing = true }
        .onDisappear { textIsPulsing = false }
        
    }
}

#Preview {
    RevealView()
}
