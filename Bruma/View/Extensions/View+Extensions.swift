//
//  View+Extensions.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 17/09/25.
//

import SwiftUI

extension View {
    
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
    
    func floatingButtonStyle(color: Color, cornerRadius: CGFloat = 10) -> some View {
        self
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        color.opacity(0.8),
                        color
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(cornerRadius)
            )
            .shadow(color: Color.white.opacity(0.1), radius: 2, x: 0, y: 0) // borde claro
            .shadow(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 4) // sombra base
    }
}
