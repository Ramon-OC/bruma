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
            VStack(alignment: .leading, spacing: 30){
                VStack(alignment: .leading, spacing: 10){
                    Text(vm.scratch_title)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.bold)
                    
                    Text(vm.scratch_instruction)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.light)
                }
                
                VStack(alignment: .center, spacing: 20){
                    Text(vm.remain_reveals)
                        .font(.custom("Helvetica", size: 25))
                        .fontWeight(.thin)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ScratchWordView(points: $points, isScratchingEnabled: $vm.isScratchingEnabled, keyword: vm.word, keywordAFI: vm.wordAFI)
                    
                    NFCRegisterButtonView(buttonIsDisabled: vm.isScratchingEnabled, buttonMessage: vm.nfc_reveal_button, turnGreenButton: vm.isScratchingEnabled) { nfcToken in
                        vm.queryPlayer(token: nfcToken)
                    }
                    
                    if vm.isScratchingEnabled{
                        Button(vm.hide_word_button) {
                            vm.isScratchingEnabled = false
                            points = []
                        }
                        .frame(width: 330)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(.mediumBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
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
