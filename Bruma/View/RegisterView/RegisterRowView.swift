//
//  RegisterRowView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

struct RegisterRowView: View {
    var playerName: String
    var body: some View {
        VStack {
            Text(playerName)
                .font(.custom("Helvetica", size: 40))
                .foregroundColor(.white)
                .bold()
                .animation(.default)
            Spacer()
        }
    }
}
