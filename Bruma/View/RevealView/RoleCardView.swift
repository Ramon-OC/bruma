//
//  RoleCardView.swift
//  Bruma
//
//  Created by José Ramón Ortiz Castañeda on 18/09/25.
//

import SwiftUI

struct RoleCardView: View {
    @ObservedObject var motion = RoleCardMotionManager()
    
    var width: CGFloat = 320
    var height: CGFloat = 450
    
    @Binding var isFlipped: Bool
    // front card info
    var frontCardImage = "RoleCard"
    // back card info
    var roleSymbol: String
    var roleName: String
    var roleAFI: String
        
    var body: some View {
        ZStack {
            ZStack {
                if !isFlipped { // front of the card
                    frontCard
                        .rotation3DEffect(.degrees(0), axis: (x: 0, y: 1, z: 0))
                } else { // back of the card
                    backCard
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }
            .clipped()
            .frame(width: width, height: height)
            .mask(RoundedRectangle(cornerRadius: 24))
            .rotation3DEffect(.degrees(motion.pitch), axis: (x: 1, y: 0, z: 0))
            .rotation3DEffect(.degrees(motion.roll), axis: (x: 0, y: 1, z: 0))
            .animation(.easeOut(duration: 0.2), value: motion.pitch)
            .animation(.easeOut(duration: 0.2), value: motion.roll)
            .animation(.easeInOut(duration: 0.6), value: isFlipped)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.6)) {
                    motion.calibrate()
                    isFlipped = false
                }
            }
        }
    }
    
    // Vista de la parte frontal
    var frontCard: some View {
        ZStack {
            Image(frontCardImage) // card image
                .resizable()
                .scaledToFill()
            
            // Topographic effect
            Image(.topographic)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(
                    LinearGradient(
                        colors: [.red, .blue, .green, .pink],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: width, height: height)
                .mask {
                    reflection(blur: 50)
                }
                .clipped()
            
            reflection(blur: 100)
        }
    }
    
    // Vista de la parte trasera
    var backCard: some View {
        ZStack {
            // Fondo de la parte trasera
            LinearGradient(
                colors: [Color(.mediumBlue)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Patrón de fondo opcional
            Image(.topographic)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.white.opacity(0.1))
                .frame(width: width, height: height)
            
            // Símbolo central
            VStack(spacing: 40){
                Text(roleName)
                    .fontWeight(.heavy)
                    .font(.custom("Helvetica", size: 40))
                    .foregroundStyle(.white)
                FlexibleImage(name: roleSymbol)
                    .font(.system(size: 80, weight: .light))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                Text(roleAFI)
                    .fontWeight(.light)
                    .font(.custom("Helvetica", size: 40))
                    .foregroundStyle(.white)
            }
            
            reflection(blur: 80) // efecto en la parte de atrás de la carta
                .opacity(0.3)
        }
        .scaleEffect(x: -1, y: 1) // Voltea horizontalmente para corregir el efecto espejo
    }
    
    func reflection(blur: CGFloat) -> some View {
        Circle()
            .foregroundStyle(.white)
            .frame(width: width, height: height)
            .offset(
                x: motion.roll * calculateOffsetMultiplier(),
                y: motion.pitch * calculateOffsetMultiplier()
            )
            .blur(radius: blur)
            .opacity(min(sqrt(motion.pitch * motion.pitch + motion.roll * motion.roll) / 15, 0.8))
    }
    
    // Calcula el multiplicador del offset para que el círculo no salga de la tarjeta
    private func calculateOffsetMultiplier() -> CGFloat {
        let cardWidth = width
        let cardHeight = height
        let circleRadius: CGFloat = 10
        
        let maxOffsetX = (cardWidth / 2) - circleRadius
        let maxOffsetY = (cardHeight / 2) - circleRadius
        
        let multiplierX = maxOffsetX / 15
        let multiplierY = maxOffsetY / 15
        
        return min(multiplierX, multiplierY)
    }
}
