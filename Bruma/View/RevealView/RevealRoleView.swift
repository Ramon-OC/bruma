//
//  RevealView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

struct RevealRoleView: View {
    @StateObject var vm = RevealRoleView.ViewModel()
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            VStack(spacing: 10){
                Text(vm.reveal_role_title)
                    .font(.custom("Helvetica", size: 30))
                    .fontWeight(.bold)
                
                Text(vm.remain_reveals)
                    .font(.custom("Helvetica", size: 30))
                    .fontWeight(.light)
            }
            
            RoleCardView(isFlipped: $vm.isCardFlipped, frontCardImage: "RoleCard", roleSymbol: vm.roleImage, roleName: vm.roleName, roleAFI: vm.rolePhonetic)
            
            // MARK: NFC READER INPUT // TAP TO FLIP // GO TO NEXT VIEW
            VStack(alignment: .center, spacing: 10){
                if vm.isCardFlipped{
                    PulsingText(text: vm.press_to_hide)
                }else{
                    
                    NFCRegisterButtonView(buttonIsDisabled: false, buttonMessage: vm.nfc_reveal_button, turnGreenButton: vm.isValidNFC) { nfcToken in
                        vm.isCardFlipped = true
                        vm.queryPlayer(token: nfcToken)
                    }
                    .padding(.vertical)
                    
                    NavigationLink(
                        destination: RevealWordView().navigationBarHidden(true),
                        label: {
                            Text("TEST")
                        })
                }

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
    RevealRoleView()
}
