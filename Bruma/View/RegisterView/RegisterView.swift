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
                        ForEach(vm.playersNames, id: \.self) { name in
                            RegisterRowView(playerName: name)
                                .listRowBackground(Color.black)
                        }
                        .onDelete(perform: vm.deletePlayer)
                    }
                    .background(Color.black)
                    .listStyle(.plain)
                }
                .rotation3DEffect(Angle(degrees: showRegisterBox ? 5 : 0), axis: (x: 1, y: 0, z: 0))
                .offset(y: showRegisterBox ? -50 : 0)
                .animation(.easeOut, value: showRegisterBox)
                .background(.black)
                
                // MARK: - VIEW PLACEHOLDER IF NO USERS REGISTERED
                if vm.emptyPlayersName {
                    NoRegisterDataView()
                }
                
                // MARK: - ADD PLAYERS NAME INPUT
                if showRegisterBox{
                    BlankView(bgColor: .black)
                        .opacity(0.5)
                        .onTapGesture {
                            self.showRegisterBox = false
                        }
                    NameInputBoxView(isShow: $showRegisterBox, onSubmit: { name in
                        vm.addPlayerNama(name: name)
                    })
                }
                
            }
        }
    }
}

#Preview {
    RegisterView()
}
