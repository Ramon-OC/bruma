//
//  MainView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 16/09/25.
//

import SwiftUI

struct MainView: View{
    @ObservedObject var vm = ViewModel()
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                Text(vm.welcome_title)
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center)
                    .font(.custom("Helvetica", size: 50))
                    .foregroundColor(.black)
                    .padding(.top, 70)
                
                NavigationLink(
                    destination: RegisterView().navigationBarHidden(true),
                    label: {
                        FishEyeView()
                    })
                
                Text(vm.game_name)
                    .fontWeight(.heavy)
                    .font(.custom("Helvetica", size: 50))
                    .foregroundStyle(.white)
                
                HStack{
                    if(vm.showIntructions){
                        Text(vm.new_around)
                            .foregroundColor(Color(.white))
                        NavigationLink(
                            destination: RegisterView().navigationBarHidden(true),
                            label: {
                                Text(vm.go_rules)
                                    .foregroundColor(Color(.black))
                            })
                    }
                }
                .padding(.top, 50)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            vm.showIntructions.toggle()
                        }
                    }
                }
            }
            .padding()
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color("BrumaBlue"))
        }
    }
}

#Preview {
    MainView()
}
