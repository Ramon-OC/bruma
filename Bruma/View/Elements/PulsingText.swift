//
//  PulsingText.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 19/09/25.
//

import SwiftUI

struct PulsingText: View {
    @State var textIsPulsing = false
    var text: String = ""
    var body: some View {
        ZStack {
            Text(text)
                .italic()
                .font(.system(size: 25, weight: .light, design: .default))
                .foregroundColor(.black)
                .padding(.top, 40)
                .opacity(textIsPulsing ? 0.5 : 1.0)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
        }
        .animation(
            Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true),
            value: textIsPulsing
        )
        .onAppear { textIsPulsing = true }
        .onDisappear { textIsPulsing = false }
        
    }
}
