//
//  RevealWordView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import SwiftUI

struct RevealWordView: View {
    @StateObject var vm = RevealWordView.ViewModel()
    @State private var points: [CGPoint] = []
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 50){
                // MARK: TITLE AND INSTRUCTION
                VStack(alignment: .leading, spacing: 10){
                    Text(vm.scratch_title)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.bold)
                    
                    Text(vm.scratch_instruction)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.light)
                }
                // MARK: REMAIN PLAYERS // SCRATCH CARD // NFC READING // HIDE BUTTON
                VStack(alignment: .center, spacing: 30){
                    VStack(spacing: 10){
                        Text(vm.remain_reveals)
                            .font(.custom("Helvetica", size: 25))
                            .fontWeight(.light)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text(vm.viewMessage)
                            .font(.custom("Helvetica", size: 20))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                            .animation(.easeInOut(duration: 0.5), value: vm.viewMessage)
                            .id(vm.viewMessage)
                    }
                    
                    ScratchWordView(points: $points, isScratchingEnabled: $vm.isScratchingEnabled, keyword: vm.gameWord.0, keywordAFI: vm.gameWord.1)
                    
                    NFCRegisterButtonView(buttonIsDisabled: vm.isScratchingEnabled, buttonMessage: vm.nfc_reveal_button, turnGreenButton: vm.isScratchingEnabled) { nfcToken in
                        vm.queryPlayer(token: nfcToken)
                    }
                    
                    if vm.isScratchingEnabled{
                        Button(action: {
                            vm.isScratchingEnabled = false
                            vm.cardState = .empty
                            points = []
                        }, label: {
                            PulsingText(text: vm.hide_word_button)
                        })
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
        }
    }
}

#Preview {
    RevealWordView()
}
