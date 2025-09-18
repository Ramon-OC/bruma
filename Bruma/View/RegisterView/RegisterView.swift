//
//  RegisterView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

struct RegisterView: View {
    
    @StateObject private var vm = ViewModel()
    
    @State private var showRegisterBox = false
    
    var body: some View {
        NavigationView{
            ZStack {
                // MARK: - HEADER AND ADD BUTTON
                VStack{
                    HStack{
                        VStack(spacing: 10){
                            Text(vm.players_names)
                                .font(.custom("Helvetica", size: 41))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(vm.players_names_count)
                                .font(.custom("Helvetica", size: 20))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Spacer()
                        if vm.canRegisterUser{
                            Button(action: { showRegisterBox = true }, label:{
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            })
                        }
                    }
                    .padding(.all, 20)
                    
                    // MARK: - LIST OF REGISTERED PLAYERS
                    List {
                        ForEach(vm.players) { player in
                            RegisterRowView(playerName: player.name)
                                .listRowBackground(Color.black)
                        }
                        .onDelete(perform: vm.deletePlayer)
                    }
                    .background(Color.black)
                    .listStyle(.plain)
                    // MARK: - NEXT VIEW BUTTON
                    if vm.enoughtPlayers {
                        NavigationLink(
                            destination: RevealView().navigationBarHidden(true),
                            label: {
                                Text(vm.looks_great)
                                    .font(.custom("Helvetica", size: 15))
                                    .frame(minWidth: 100, maxWidth: 200)
                                    .background(Color.mediumBlue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding()
                            }
                        )
                        .simultaneousGesture(TapGesture().onEnded {
                            vm.startGame()
                        })
                    }
                }
                .rotation3DEffect(Angle(degrees: showRegisterBox ? 5 : 0), axis: (x: 1, y: 0, z: 0))
                .animation(.easeOut, value: showRegisterBox)
                .background(.black)
                
                // MARK: - VIEW PLACEHOLDER IF NO USERS REGISTERED
                if vm.emptyPlayersName {
                    NoRegisterDataView()
                }
                
                // MARK: - ADD PLAYERS NAME INPUT
                if showRegisterBox {
                    VStack {
                        BlankView(bgColor: .black)
                            .opacity(0.8)
                            .onTapGesture {
                                self.showRegisterBox = false
                            }
                        Spacer()
                        NameInputBoxView(isShow: $showRegisterBox, containsNFCToken: vm.containsNFCToken, onSubmit: { player in
                            vm.addPlayer(player: player)
                        })
                        .padding([.horizontal, .bottom])
                    }
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}
