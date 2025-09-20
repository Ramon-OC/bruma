//
//  RevealView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

struct RevealRoleView: View {
    @StateObject var vm = ViewModel()
    @State private var showFinalOverlay = false
    @State private var animateText = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                VStack(spacing: 10){
                    Text(vm.reveal_role_title)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.bold)
                    
                    Text(vm.remain_reveals)
                        .font(.custom("Helvetica", size: 30))
                        .fontWeight(.light)
                }

                RoleCardView(
                    isFlipped: $vm.isCardFlipped,
                    frontCardImage: "RoleCard",
                    roleSymbol: vm.roleImage,
                    roleName: vm.roleName,
                    roleAFI: vm.rolePhonetic
                )

                VStack(alignment: .center, spacing: 10) {
                    if vm.isCardFlipped {
                        PulsingText(text: vm.press_to_hide)
                    } else {
                        NFCRegisterButtonView(
                            buttonIsDisabled: false,
                            buttonMessage: vm.nfc_reveal_button,
                            turnGreenButton: vm.isCardFlipped
                        ) { nfcToken in
                            vm.isCardFlipped = true
                            vm.queryPlayer(token: nfcToken)
                        }
                        .padding(.vertical)
                    }
                }
            }

            // MARK: - FINAL OVERLAY
            if vm.allPlayersHaveScanned && !vm.isCardFlipped{
                Color.black.opacity(0.75)
                    .ignoresSafeArea()
                    .transition(.opacity)

                VStack(spacing: 20) {
                    Text("¡Listo! Todos conocen su rol")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(y: animateText ? 0 : 50)
                        .opacity(animateText ? 1 : 0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.65).delay(0.1), value: animateText)

                    NavigationLink(
                        destination: RevealWordView().navigationBarHidden(true),
                        label: {
                            Text("Ir al siguiente paso")
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                        }
                    )
                    .scaleEffect(animateText ? 1 : 0.8)
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut.delay(0.3), value: animateText)
                }.onAppear{
                    animateText = true
                }
            }
        }
    }
}

#Preview {
    RevealRoleView()
}
